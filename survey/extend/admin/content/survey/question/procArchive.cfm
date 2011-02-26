<!--- Redirect to the list page if no survey chosen --->
<cfif theUrl.search('survey') eq ''>
	<cfset transport.theSession.managers.singleton.getMessage().addMessages('Please select a survey before working with questions.') />
	
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.redirectRedirect() />
<cfelseif theUrl.search('question') eq ''>
	<cfset transport.theSession.managers.singleton.getMessage().addMessages('Please select a question .') />
	
	<cfset theURL.setRedirect('_base', '/survey/question/list') />
	<cfset theURL.redirectRedirect() />
</cfif>

<cfset servSurvey = services.get('survey', 'survey') />
<cfset servQuestion = services.get('survey', 'question') />

<!--- Retrieve the object --->
<cfset survey = servSurvey.getSurvey( theURL.search('survey') ) />
<cfset question = servQuestion.getQuestion( theURL.search('survey'), theUrl.search('question') ) />

<cfset servQuestion.archiveQuestion( survey, question ) />

<!--- Redirect --->
<cfset theURL.setRedirect('_base', '/survey/question/list') />
<cfset theURL.removeRedirect('question') />

<cfset theURL.redirectRedirect() />

