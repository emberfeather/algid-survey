<cfset servSurvey = services.get('survey', 'survey') />

<!--- Retrieve the object --->
<cfset survey = servSurvey.getSurvey( theURL.search('survey') ) />

<cfset servSurvey.archiveSurvey( survey ) />

<!--- Redirect --->
<cfset theURL.setRedirect('_base', '/survey/list') />
<cfset theURL.removeRedirect('survey') />

<cfset theURL.redirectRedirect() />
