<cfcomponent extends="algid.inc.resource.base.service" output="false">
	<cffunction name="archiveSurvey" access="public" returntype="void" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="survey" type="component" required="true" />
		
		<cfset var eventLog = '' />
		<cfset var observer = '' />
		
		<!--- Get the event observer --->
		<cfset observer = getPluginObserver('survey', 'survey') />
		
		<!--- Get the event log from the transport --->
		<cfset eventLog = variables.transport.theApplication.managers.singleton.getEventLog() />
		
		<!--- TODO Check user Permissions --->
		
		<!--- Before Archive Event --->
		<cfset observer.beforeArchive(variables.transport, arguments.currUser, arguments.survey) />
		
		<!--- TODO Archive the survey --->
		
		<!--- After Archive Event --->
		<cfset observer.afterArchive(variables.transport, arguments.currUser, arguments.survey) />
	</cffunction>
	
	<cffunction name="getSurvey" access="public" returntype="component" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="surveyID" type="string" required="true" />
		
		<cfset var survey = '' />
		<cfset var i = '' />
		<cfset var objectSerial = '' />
		<cfset var path = '' />
		<cfset var results = '' />
		<cfset var type = '' />
		
		<cfset survey = getModel('survey', 'survey') />
		
		<cfif arguments.surveyID neq ''>
			<!--- TODO Check for user connection --->
			
			<!--- TODO Retrieve Survey --->
			
			<!--- 
			<cfif results.recordCount>
				<cfset objectSerial = variables.transport.theApplication.managers.singleton.getObjectSerial() />
				
				<cfset objectSerial.deserialize(results, survey) />
			</cfif>
			 --->
		</cfif>
		
		<cfreturn survey />
	</cffunction>
	
	<cffunction name="getSurveys" access="public" returntype="query" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var defaults = {
			} />
		<cfset var results = '' />
		
		<!--- Expand the with defaults --->
		<cfset arguments.filter = extend(defaults, arguments.filter) />
		
		<!--- TODO Retrieve surveys --->
		
		<cfreturn results />
	</cffunction>
	
	<cffunction name="setSurvey" access="public" returntype="void" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="survey" type="component" required="true" />
		
		<cfset var i = '' />
		<cfset var isArchived = '' />
		<cfset var observer = '' />
		<cfset var results = '' />
		
		<!--- Get the event observer --->
		<cfset observer = getPluginObserver('survey', 'survey') />
		
		<!--- TODO Check user permissions --->
		
		<!--- Before Save Event --->
		<cfset observer.beforeSave(variables.transport, arguments.currUser, arguments.survey) />
		
		<cfif arguments.survey.getSurveyID() neq ''>
			<!--- TODO Check for archived status --->
			
			<cfif isArchived.archivedOn eq ''>
				<!--- Before Update Event --->
				<cfset observer.beforeUpdate(variables.transport, arguments.currUser, arguments.survey) />
			<cfelse>
				<!--- Before Unarchive Event --->
				<cfset observer.beforeUnarchive(variables.transport, arguments.currUser, arguments.survey) />
			</cfif>
			
			<!--- TODO Update existing survey --->
			
			<cfif isArchived.archivedOn eq ''>
				<!--- After Update Event --->
				<cfset observer.afterUpdate(variables.transport, arguments.currUser, arguments.survey) />
			<cfelse>
				<!--- After Unarchive Event --->
				<cfset observer.afterUnarchive(variables.transport, arguments.currUser, arguments.survey) />
			</cfif>
		<cfelse>
			<!--- Before Create Event --->
			<cfset observer.beforeCreate(variables.transport, arguments.currUser, arguments.survey) />
			
			<!--- Insert as a new record --->
			<!--- Create the new ID --->
			<cfset arguments.survey.setSurveyID( createUUID() ) />
			
			<!--- TODO Insert New Survey --->
			
			<!--- After Create Event --->
			<cfset observer.afterCreate(variables.transport, arguments.currUser, arguments.survey) />
		</cfif>
		
		<!--- After Save Event --->
		<cfset observer.afterSave(variables.transport, arguments.currUser, arguments.survey) />
	</cffunction>
</cfcomponent>
