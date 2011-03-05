<cfcomponent extends="plugins.mongodb.inc.resource.base.service" output="false">
	<cffunction name="getResponses" access="public" returntype="array" output="false">
		<cfargument name="surveyID" type="string" required="true" />
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var collection = '' />
		<cfset var defaults = {
				'orderBy': 'responsedOn',
				'search': ''
			} />
		<cfset var query = {} />
		<cfset var sort = { 'response': 1 } />
		<cfset var results = '' />
		
		<!--- Expand the with defaults --->
		<cfset arguments.filter = extend(defaults, arguments.filter) />
		
		<cfset collection = variables.db.getCollection( 'survey.survey' ) />
		
		<!--- TODO Check for user connection --->
		
		<!--- Query building --->
		<cfset query['_id'] = arguments.surveyID />
		
		<cfif filter.search neq ''>
			<cfset query['response'] = collection.regex(arguments.filter.search, 'i') />
		</cfif>
		
		<cfif structKeyExists(arguments.filter, 'isArchived')>
			<cfif arguments.filter.isArchived>
				<cfset query['archivedOn'] = { '$exists': true } />
			<cfelse>
				<cfset query['archivedOn'] = { '$exists': false } />
			</cfif>
		</cfif>
		
		<!--- Sorting --->
		<cfswitch expression="#arguments.filter.orderBy#">
			<cfdefaultcase>
				<cfset sort['responsedOn'] = 1 />
			</cfdefaultcase>
		</cfswitch>
		
		<!--- Retrieve Responses without responses --->
		<cfset results = collection.find( query, { 'responses': 1 } ).sort(sort).toArray() />
		
		<cfif arrayLen(results)>
			<cfreturn results[1].responses />
		</cfif>
		
		<cfreturn results />
	</cffunction>
	
	<cffunction name="setResponse" access="public" returntype="void" output="false">
		<cfargument name="survey" type="component" required="true" />
		<cfargument name="response" type="component" required="true" />
		
		<cfset var collection = '' />
		<cfset var i = '' />
		<cfset var isArchived = '' />
		<cfset var observer = '' />
		<cfset var results = '' />
		
		<!--- Get the event observer --->
		<cfset observer = getPluginObserver('response', 'response') />
		
		<cfset collection = variables.db.getCollection( 'response.response' ) />
		
		<cfset validate__model(arguments.response) />
		
		<!--- Before Save Event --->
		<cfset observer.beforeSave(variables.transport, arguments.response) />
		
		<!--- Before Create Event --->
		<cfset observer.beforeCreate(variables.transport, arguments.response) />
		
		<!--- Push onto the survey --->
		<cfset collection.update({ '_id': arguments.survey.get_id() }, { '$push': { 'responses': arguments.response.get__instance() } }) />
		
		<!--- After Create Event --->
		<cfset observer.afterCreate(variables.transport, arguments.response) />
		
		<!--- After Save Event --->
		<cfset observer.afterSave(variables.transport, arguments.response) />
	</cffunction>
</cfcomponent>
