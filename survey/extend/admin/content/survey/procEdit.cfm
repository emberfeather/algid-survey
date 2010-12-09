<cfset servSurvey = services.get('survey', 'survey') />

<!--- Retrieve the object --->
<cfset survey = servSurvey.getSurvey( transport.theSession.managers.singleton.getUser(), theURL.search('survey') ) />

<cfif cgi.request_method eq 'post'>
	<!--- Process the form submission --->
	<cfset modelSerial.deserialize(form, survey) />
	
	<cfset servSurvey.setSurvey( transport.theSession.managers.singleton.getUser(), survey ) />
	
	<!--- Add a success message --->
	<cfset transport.theSession.managers.singleton.getSuccess().addMessages('The survey ''' & survey.getSurvey() & ''' was successfully saved.') />
	
	<!--- Redirect --->
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.removeRedirect('survey') />
	
	<cfset theURL.redirectRedirect() />
</cfif>
