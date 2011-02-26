<cfset servSurvey = services.get('survey', 'survey') />

<cfif cgi.request_method eq 'post'>
	<!--- Process the form submission --->
	
	<!--- Read uploaded file --->
	<cfif fileExists(form.surveyFile)>
		<cfset import = fileRead(form.surveyFile) />
	<cfelse>
		<cfset import = form.surveyFile />
	</cfif>
	
	<!--- Validate json format --->
	<cfif not isJson(import)>
		<cfthrow type="validation" message="Invalid format" detail="The import file is not in a valid JSON format." />
	</cfif>
	
	<cfset import = deserializeJson(import) />
	
	<cfset servSurvey.importSurveys(import) />
	
	<!--- Redirect --->
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.removeRedirect('survey') />
	
	<cfset theURL.redirectRedirect() />
</cfif>
