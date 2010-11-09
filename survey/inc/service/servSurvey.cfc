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
		<cfset arguments.survey.setArchivedOn(now()) />
		
		<cfset collection.save(arguments.survey.get__instance()) />
		
		<!--- After Archive Event --->
		<cfset observer.afterArchive(variables.transport, arguments.currUser, arguments.survey) />
	</cffunction>
	
	<cffunction name="getSurvey" access="public" returntype="component" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="surveyID" type="string" required="true" />
		
		<cfset var collection = '' />
		<cfset var objectSerial = '' />
		<cfset var result = '' />
		<cfset var survey = '' />
		
		<cfset survey = getModel('survey', 'survey') />
		
		<cfif arguments.surveyID neq ''>
			<cfset collection = variables.db.getCollection( 'survey.survey' ) />
			
			<!--- TODO Check for user connection --->
			
			<!--- Retrieve Survey --->
			<cfset result = collection.findOne({ '_id': arguments.surveyID }) />
			
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
		
		<cfif structKeyExists(arguments.filter, 'isArchived')>
			<cfif arguments.filter.isArchived>
				<cfset query['archivedOn'] = { '$exists': true } />
			<cfelse>
				<cfset query['archivedOn'] = { '$exists': false } />
			</cfif>
		</cfif>
		
		<cfif structKeyExists(arguments.filter, 'in_id')>
			<cfset query['_id'] = { '$in': arguments.filter.in_id } />
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
<cfscript>
	public void function updateI18N(required component currUser, required component survey) {
		var fileContents = '';
		var i = '';
		var i18n = '';
		var j = '';
		var key = '';
		var keys = '';
		var locales = '';
		var plugin = '';
		var objectSerial = '';
		var question = '';
		var questions = '';
		var storagePath = '';
		
		// Get the plugin
		plugin = variables.transport.theApplication.managers.plugin.getSurvey();
		
		storagePath = plugin.getStoragePath() & '/i18n';
		
		locales = arguments.survey.getLocales();
		
		objectSerial = variables.transport.theApplication.managers.singleton.getObjectSerial();
		
		for( i = 1; i <= arrayLen(locales); i++ ) {
			fileContents = '## Updated on: ' & dateFormat(now()) & ' ' & timeFormat(now()) & chr(10) & chr(10);
			
			// Get the properties version of the survey
			fileContents &= arguments.survey._toProperties(locales[i]);
			
			fileContents &= chr(10) & '## Questions' & chr(10);
			
			questions = arguments.survey.getQuestions();
			
			for( j = 1; j <= arrayLen(questions); j++ ) {
				question = getModel('survey', 'question');
				
				objectSerial.deserialize(questions[j], question);
				
				// Add the properties for each of the questions
				fileContents &= question._toProperties(locales[i]);
			}
			
			// Write the survey locale file
			fileWrite(storagePath & '/survey-' & arguments.survey.get_ID() & '_' & locales[i] & '.properties', fileContents & chr(10));
		}
		
		// Write the base survey locale file
		if(!fileExists(storagePath & '/survey-' & arguments.survey.get_ID() & '.properties')) {
			fileWrite(storagePath & '/survey-' & arguments.survey.get_ID() & '.properties', '');
		}
	}
</cfscript>
</cfcomponent>
