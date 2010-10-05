<!--- Redirect to the list page if no survey chosen --->
<cfif theUrl.search('survey') eq ''>
	<cfset transport.theSession.managers.singleton.getMessage().addMessages('Please select a survey before working with questions.') />
	
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.redirectRedirect() />
</cfif>

<cfset servSurvey = services.get('survey', 'survey') />
<cfset servQuestion = services.get('survey', 'question') />

<!--- Retrieve the object --->
<cfset survey = servSurvey.getSurvey( transport.theSession.managers.singleton.getUser(), theURL.search('survey') ) />
<cfset question = servQuestion.getQuestion( transport.theSession.managers.singleton.getUser(), theURL.search('survey'), theURL.search('question') ) />

<cfif cgi.request_method eq 'post'>
	<!--- Process the form submission --->
	<cfset objectSerial.deserialize(form, question) />
	
	<cfset servQuestion.setQuestion( transport.theSession.managers.singleton.getUser(), survey, question ) />
	
	<!--- Add a success message --->
	<cfset transport.theSession.managers.singleton.getSuccess().addMessages('The question ''' & question.getQuestion() & ''' was successfully saved.') />
	
	<!--- Redirect --->
	<cfset theURL.setRedirect('_base', '/survey/question/list') />
	<cfset theURL.removeRedirect('question') />
	
	<cfset theURL.redirectRedirect() />
</cfif>
