<cfset servSurvey = services.get('survey', 'survey') />

<!--- Retrieve the object --->
<cfset survey = servSurvey.getSurvey( transport.theSession.managers.singleton.getUser(), theURL.search('survey') ) />

<cfif cgi.request_method eq 'post'>
	<!--- Process the form submission --->
	<cfset objectSerial.deserialize(form, survey) />
	
	<cfset questions = [] />
	
	<!--- Handle the qusetion processing --->
	<cfloop list="#form.fieldnames#" index="i">
		<cfif left(i, 8) eq 'question' and trim(form[i]) neq ''>
			<cfset question = deserializeJson(form[i]) />
			
			<cfset arrayAppend(questions, question) />
		</cfif>
	</cfloop>
	
	<cfset survey.setQuestions(questions) />
	
	<cfset servSurvey.setSurvey( transport.theSession.managers.singleton.getUser(), survey ) />
	
	<!--- Add a success message --->
	<cfset transport.theSession.managers.singleton.getSuccess().addMessages('The survey ''' & survey.getSurvey() & ''' was successfully saved.') />
	
	<!--- Redirect --->
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.removeRedirect('survey') />
	
	<cfset theURL.redirectRedirect() />
</cfif>
