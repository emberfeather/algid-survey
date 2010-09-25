<cfcomponent extends="plugins.mongodb.inc.resource.base.service" output="false">
	<cffunction name="archiveSurvey" access="public" returntype="void" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="survey" type="component" required="true" />
		
		<cfset var collection = '' />
		<cfset var eventLog = '' />
		<cfset var observer = '' />
		
		<cfset collection = variables.db.getCollection( 'survey.survey' ) />
		
		<!--- Get the event observer --->
		<cfset observer = getPluginObserver('survey', 'survey') />
		
		<!--- Get the event log from the transport --->
		<cfset eventLog = variables.transport.theApplication.managers.singleton.getEventLog() />
		
		<!--- TODO Check user Permissions --->
		
		<!--- Before Archive Event --->
		<cfset observer.beforeArchive(variables.transport, arguments.currUser, arguments.survey) />
		
		<!--- Archive the survey --->
		<cfset arguments.survey.set('archivedOn', now()) />
		
		<cfset collection.save(arguments.survey.get__instance()) />
		
		<!--- After Archive Event --->
		<cfset observer.afterArchive(variables.transport, arguments.currUser, arguments.survey) />
	</cffunction>
	
	<cffunction name="getSurvey" access="public" returntype="component" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="surveyID" type="string" required="true" />
		
		<cfset var collection = '' />
		<cfset var i = '' />
		<cfset var objectSerial = '' />
		<cfset var path = '' />
		<cfset var results = '' />
		<cfset var survey = '' />
		<cfset var type = '' />
		
		<cfset survey = getModel('survey', 'survey') />
		
		<cfif arguments.surveyID neq ''>
			<cfset collection = variables.db.getCollection( 'survey.survey' ) />
			
			<!--- TODO Check for user connection --->
			
			<!--- Retrieve Survey without responses --->
			<cfset result = collection.findOne({ '_id': arguments.surveyID }, { 'responses': 0 }) />
			
			<cfif not structIsEmpty(result)>
				<cfset objectSerial = variables.transport.theApplication.managers.singleton.getObjectSerial() />
				
				<cfset objectSerial.deserialize(result, survey) />
			</cfif>
		</cfif>
		
		<cfreturn survey />
	</cffunction>
	
	<cffunction name="getSurveys" access="public" returntype="array" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var collection = '' />
		<cfset var defaults = {
				'orderBy': 'survey',
				'search': ''
			} />
		<cfset var query = {} />
		<cfset var sort = { 'survey': 1 } />
		<cfset var results = '' />
		
		<!--- Expand the with defaults --->
		<cfset arguments.filter = extend(defaults, arguments.filter) />
		
		<cfset collection = variables.db.getCollection( 'survey.survey' ) />
		
		<!--- TODO Check for user connection --->
		
		<!--- Query building --->
		<cfif filter.search neq ''>
			<cfset query['survey'] = collection.regex(arguments.filter.search, 'i') />
		</cfif>
		
		<!--- Sorting --->
		<cfswitch expression="#arguments.filter.orderBy#">
			<cfdefaultcase>
				<cfset sort['survey'] = 1 />
			</cfdefaultcase>
		</cfswitch>
		
		<!--- Retrieve Surveys without responses --->
		<cfset results = collection.find( query, { 'responses': 0 }).sort(sort) />
		
		<cfreturn results.toArray() />
	</cffunction>
	
	<cffunction name="setSurvey" access="public" returntype="void" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="survey" type="component" required="true" />
		
		<cfset var collection = '' />
		<cfset var i = '' />
		<cfset var isArchived = '' />
		<cfset var observer = '' />
		<cfset var results = '' />
		
		<!--- Get the event observer --->
		<cfset observer = getPluginObserver('survey', 'survey') />
		
		<cfset collection = variables.db.getCollection( 'survey.survey' ) />
		
		<!--- TODO Check user permissions --->
		
		<!--- Before Save Event --->
		<cfset observer.beforeSave(variables.transport, arguments.currUser, arguments.survey) />
		
		<cfif arguments.survey.get_ID() neq ''>
			<!--- Before Update Event --->
			<cfset observer.beforeUpdate(variables.transport, arguments.currUser, arguments.survey) />
			
			<!--- Update existing survey --->
			<cfset collection.save(arguments.survey.get__instance()) />
			
			<!--- After Update Event --->
			<cfset observer.afterUpdate(variables.transport, arguments.currUser, arguments.survey) />
		<cfelse>
			<!--- Before Create Event --->
			<cfset observer.beforeCreate(variables.transport, arguments.currUser, arguments.survey) />
			
			<!--- Insert as a new record --->
			<cfset collection.save(arguments.survey.get__instance()) />
			
			<!--- After Create Event --->
			<cfset observer.afterCreate(variables.transport, arguments.currUser, arguments.survey) />
		</cfif>
		
		<!--- After Save Event --->
		<cfset observer.afterSave(variables.transport, arguments.currUser, arguments.survey) />
	</cffunction>
</cfcomponent>
