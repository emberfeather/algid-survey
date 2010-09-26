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
	
	<cffunction name="edit" access="public" returntype="string" output="false">
		<cfargument name="survey" type="component" required="true" />
		<cfargument name="request" type="struct" default="#{}#" />
		
		<cfset var i18n = '' />
		<cfset var theForm = '' />
		<cfset var theURL = '' />
		
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		<cfset theURL = variables.transport.theRequest.managers.singleton.getUrl() />
		<cfset theForm = variables.transport.theApplication.factories.transient.getFormStandard('survey', i18n) />
		
		<!--- Add the resource bundle for the view --->
		<cfset theForm.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey') />
		
		<cfset theForm.addElement('text', {
				name = "survey",
				label = "survey",
				value = ( structKeyExists(arguments.request, 'survey') ? arguments.request.survey : arguments.survey.getSurvey() )
			}) />
		
		<cfreturn theForm.toHTML(theURL.get()) />
	</cffunction>
	
	<cffunction name="filterActive" access="public" returntype="string" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var filterActive = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		
		<cfset filterActive = variables.transport.theApplication.factories.transient.getFilterActive(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filterActive.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey') />
		
		<cfreturn filterActive.toHTML(arguments.filter, variables.transport.theRequest.managers.singleton.getURL(), 'search') />
	</cffunction>
	
	<cffunction name="filter" access="public" returntype="string" output="false">
		<cfargument name="values" type="struct" default="#{}#" />
		
		<cfset var filter = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		
		<cfset filter = variables.transport.theApplication.factories.transient.getFilterVertical(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filter.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey') />
		
		<!--- Search --->
		<cfset filter.addFilter('search') />
		
		<cfreturn filter.toHTML(variables.transport.theRequest.managers.singleton.getURL(), arguments.values) />
	</cffunction>
	
	<cffunction name="datagrid" access="public" returntype="string" output="false">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />
		
		<cfset var datagrid = '' />
		<cfset var i18n = '' />
		
		<cfset arguments.options.theURL = variables.transport.theRequest.managers.singleton.getURL() />
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		<cfset datagrid = variables.transport.theApplication.factories.transient.getDatagrid(i18n, variables.transport.theSession.managers.singleton.getSession().getLocale()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset datagrid.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey') />
		
		<cfset datagrid.addColumn({
				key = 'survey',
				label = 'survey',
				link = {
					'_base' = '/survey/response/list',
					'survey' = '_id',
					'onPage' = 1
				}
			}) />
		
		<cfset datagrid.addColumn({
				class = 'phantom align-right',
				value = [ 'delete', 'edit' ],
				link = [
					{
						'survey' = '_id',
						'_base' = '/survey/archive'
					},
					{
						'survey' = '_id',
						'_base' = '/survey/edit'
					}
				],
				linkClass = [ 'delete', '' ]
			}) />
		
		<cfreturn datagrid.toHTML( arguments.data, arguments.options ) />
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
