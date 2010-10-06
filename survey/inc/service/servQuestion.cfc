<cfcomponent extends="plugins.mongodb.inc.resource.base.service" output="false">
	<cffunction name="archiveQuestion" access="public" returntype="void" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="survey" type="component" required="true" />
		<cfargument name="question" type="component" required="true" />
		
		<cfset var collection = '' />
		<cfset var eventLog = '' />
		<cfset var observer = '' />
		<cfset var questions = '' />
		
		<cfset collection = variables.db.getCollection( 'survey.survey' ) />
		
		<!--- Get the event observer --->
		<cfset observer = getPluginObserver('survey', 'question') />
		
		<!--- Get the event log from the transport --->
		<cfset eventLog = variables.transport.theApplication.managers.singleton.getEventLog() />
		
		<!--- TODO Check user Permissions --->
		
		<!--- Before Archive Event --->
		<cfset observer.beforeArchive(variables.transport, arguments.currUser, arguments.survey, arguments.question) />
		
		<!--- Archive the question --->
		<cfset questions = arguments.survey.getQuestions() />
		
		<cfloop from="1" to="#arrayLen(questions)#" index="i">
			<cfif questions[i]._id eq arguments.question.get_id()>
				<cfset questions[i]['archivedOn'] = now() />
				
				<!--- Update the questions only --->
				<cfset collection.update({ '_id': arguments.survey.get_id() }, { '$set': { 'questions': questions } }) />
				
				<cfbreak />
			</cfif>
		</cfloop>
		
		<!--- After Archive Event --->
		<cfset observer.afterArchive(variables.transport, arguments.currUser, arguments.survey, arguments.question) />
	</cffunction>
	
	<cffunction name="getQuestion" access="public" returntype="component" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="surveyID" type="string" required="true" />
		<cfargument name="questionID" type="string" required="true" />
		
		<cfset var collection = '' />
		<cfset var i = '' />
		<cfset var objectSerial = '' />
		<cfset var result = '' />
		<cfset var question = '' />
		
		<cfset question = getModel('survey', 'question') />
		
		<cfif arguments.questionID neq ''>
			<cfset collection = variables.db.getCollection( 'survey.survey' ) />
			
			<!--- TODO Check for user connection --->
			
			<!--- Retrieve Survey --->
			<cfset result = collection.findOne({ '_id': arguments.surveyID }) />
			
			<cfif not structIsEmpty(result) and structKeyExists(result, 'questions')>
				<!--- TODO Better way to query for sub document? --->
				<!--- Search for the question id match --->
				<cfloop from="1" to="#arrayLen(result.questions)#" index="i">
					<cfif structKeyExists(result.questions[i], '_id') and result.questions[i]._id eq arguments.questionID>
						<cfset objectSerial = variables.transport.theApplication.managers.singleton.getObjectSerial() />
						
						<cfset objectSerial.deserialize(result.questions[i], question) />
						
						<cfbreak />
					</cfif>
				</cfloop>
			</cfif>
		</cfif>
		
		<cfreturn question />
	</cffunction>
	
	<cffunction name="getQuestions" access="public" returntype="array" output="false">
		<cfargument name="surveyID" type="string" required="true" />
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var collection = '' />
		<cfset var defaults = {
			'orderBy': 'questiondOn',
			'search': ''
		} />
		<cfset var i = '' />
		<cfset var query = {} />
		<cfset var sort = { 'orderBy': 1 } />
		<cfset var results = '' />
		
		<!--- Expand the with defaults --->
		<cfset arguments.filter = extend(defaults, arguments.filter) />
		
		<cfset collection = variables.db.getCollection( 'survey.survey' ) />
		
		<!--- TODO Check for user connection --->
		
		<!--- Query building --->
		<cfset query['_id'] = arguments.surveyID />
		
		<cfif filter.search neq ''>
			<cfif not structKeyExists(query, 'questions')>
				<cfset query['questions'] = {} />
			</cfif>
			
			<cfset query['questions']['question'] = collection.regex(arguments.filter.search, 'i') />
		</cfif>
		
		<!--- Sorting --->
		<cfswitch expression="#arguments.filter.orderBy#">
			<cfdefaultcase>
				<cfset sort['orderBy'] = 1 />
			</cfdefaultcase>
		</cfswitch>
		
		<!--- Retrieve Questions without questions --->
		<cfset results = collection.find( query, { 'questions': 1 } ).sort(sort).toArray() />
		
		<cfif arrayLen(results)>
			<!--- TODO Figure out how to do this as part of the query --->
			<cfif structKeyExists(arguments.filter, 'isArchived')>
				<cfloop from="1" to="#arrayLen(results[1].questions)#" index="i">
					<cfif arguments.filter.isArchived and not structKeyExists(results[1].questions[i], 'archivedOn')>
						<cfset arrayDeleteAt(results[1].questions, i) />
					<cfelseif not arguments.filter.isArchived and structKeyExists(results[1].questions[i], 'archivedOn')>
						<cfset arrayDeleteAt(results[1].questions, i) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfreturn results[1].questions />
		</cfif>
		
		<cfreturn [] />
	</cffunction>
	
	<cffunction name="setQuestion" access="public" returntype="void" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="survey" type="component" required="true" />
		<cfargument name="question" type="component" required="true" />
		
		<cfset var collection = '' />
		<cfset var i = '' />
		<cfset var isFound = '' />
		<cfset var isArchived = '' />
		<cfset var observer = '' />
		<cfset var questions = '' />
		<cfset var results = '' />
		
		<!--- Get the event observer --->
		<cfset observer = getPluginObserver('survey', 'question') />
		
		<cfset collection = variables.db.getCollection( 'survey.survey' ) />
		
		<!--- TODO Check user permissions --->
		
		<!--- Before Save Event --->
		<cfset observer.beforeSave(variables.transport, arguments.currUser, arguments.survey, arguments.question) />
		
		<cfif arguments.question.get_ID() neq ''>
			<!--- Before Update Event --->
			<cfset observer.beforeUpdate(variables.transport, arguments.currUser, arguments.survey, arguments.question) />
			
			<cfset questions = arguments.survey.getQuestions() />
			
			<cfset isFound = false />
			
			<cfloop from="1" to="#arrayLen(questions)#" index="i">
				<cfif questions[i]._id eq arguments.question.get_id()>
					<cfset isFound = true />
					
					<cfset questions[i] = arguments.question.get__instance() />
					
					<!--- Update the questions only --->
					<cfset collection.update({ '_id': arguments.survey.get_id() }, { '$set': { 'questions': questions } }) />
					
					<cfbreak />
				</cfif>
			</cfloop>
			
			<!--- Insert if not found --->
			<cfif not isFound>
				<!--- Push onto the survey --->
				<cfset collection.update({ '_id': arguments.survey.get_id() }, { '$push': { 'questions': arguments.question.get__instance() } }) />
			</cfif>
			
			<!--- After Update Event --->
			<cfset observer.afterUpdate(variables.transport, arguments.currUser, arguments.survey, arguments.question) />
		<cfelse>
			<!--- Before Create Event --->
			<cfset observer.beforeCreate(variables.transport, arguments.currUser, arguments.survey, arguments.question) />
			
			<!--- Create an ID --->
			<cfset arguments.question.set_ID(createUUID()) />
			
			<!--- Push onto the survey --->
			<cfset collection.update({ '_id': arguments.survey.get_id() }, { '$push': { 'questions': arguments.question.get__instance() } }) />
			
			<!--- After Create Event --->
			<cfset observer.afterCreate(variables.transport, arguments.currUser, arguments.survey, arguments.question) />
		</cfif>
		
		<!--- After Save Event --->
		<cfset observer.afterSave(variables.transport, arguments.currUser, arguments.survey, arguments.question) />
	</cffunction>
</cfcomponent>
