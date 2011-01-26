<cfset servSurvey = services.get('survey', 'survey') />

<!--- Retrieve the object --->
<cfset survey = servSurvey.getSurvey( session.managers.singleton.getUser(), theURL.search('survey') ) />

<cfset servSurvey.archiveSurvey( session.managers.singleton.getUser(), survey ) />

<!--- Redirect --->
<cfset theURL.setRedirect('_base', '/survey/list') />
<cfset theURL.removeRedirect('survey') />

<cfset theURL.redirectRedirect() />
