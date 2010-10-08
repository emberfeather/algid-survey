<cfset servSurvey = services.get('survey', 'survey') />

<cfif cgi.request_method eq 'post'>
	<!--- Process the form submission --->
	
	<!--- Read uploaded file --->
	<cfset import = fileRead(form.surveyFile) />
	
	<!--- Validate json format --->
	<cfif not isJson(import)>
		<cfthrow type="validation" message="Invalid format" detail="The import file is not in a valid JSON format." />
	</cfif>
	
	<cfset import = deserializeJson(import) />
	
	<!--- Validate has surveys --->
	<cfif not structKeyExists(import, 'surveys')>
		<cfthrow type="validation" message="Invalid format" detail="The import file is missing the survey information." />
	</cfif>
	
	<cfif !isArray(import.surveys)>
		<cfthrow type="validation" message="Invalid format" detail="The import file surveys need to be an array." />
	</cfif>
	
	<cfset user = transport.theSession.managers.singleton.getUser() />
	<cfset objectSerial = transport.theApplication.managers.singleton.getObjectSerial() />
	
	<!--- Save all surveys to db --->
	<cfloop array="#import.surveys#" index="result">
		<cfset survey = servSurvey.getSurvey(user, '') />
		
		<cfset objectSerial.deserialize(result, survey) />
		
		<cfset servSurvey.setSurvey(user, survey) />
	</cfloop>
	
	<!--- Add a success message --->
	<!--- TODO Use i18n --->
	<cfset transport.theSession.managers.singleton.getSuccess().addMessages('The surveys were successfully imported.') />
	
	<!--- Redirect --->
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.removeRedirect('survey') />
	
	<cfset theURL.redirectRedirect() />
</cfif>
