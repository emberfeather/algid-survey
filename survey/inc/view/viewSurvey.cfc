<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="display" access="public" returntype="string" output="false">
		<cfargument name="survey" type="component" required="true" />
		<cfargument name="request" type="struct" required="true" />
		
		<cfset var i18n = '' />
		<cfset var theForm = '' />
		<cfset var theUrl = '' />
		
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		<cfset theURL = variables.transport.theRequest.managers.singleton.getUrl() />
		<cfset theForm = variables.transport.theApplication.factories.transient.getFormForSurvey('survey', i18n) />
		
		<!--- Add the resource bundle for the view --->
		<cfset theForm.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey') />
		
		<!--- Title --->
		<cfset theForm.addElement('text', {
				name = "title",
				label = "title",
				value = ( structKeyExists(arguments.request, 'title') ? arguments.request.title : arguments.survey.getSurvey() )
			}) />
		
		<cfreturn theForm.toHTML(theURL.get()) />
	</cffunction>
	
	<!--- TODO Remove --->
	<cffunction name="randomTitle" access="public" returntype="string" output="false">
		<cfset var titles = [
				'How much wood could a wood chuck chuck if a wood chuck could chuck wood?',
				'How cool would I be if I were cool like you?'
			] />
		
		<cfreturn titles[randRange(1, arrayLen(titles))] />
	</cffunction>
</cfcomponent>
