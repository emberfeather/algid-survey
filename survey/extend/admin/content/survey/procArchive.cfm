<cfset servSurvey = services.get('survey', 'survey') />

<!--- Retrieve the object --->
<cfset survey = servSurvey.getSurvey( session.managers.singleton.getUser(), theURL.search('survey') ) />

<cfset servSurvey.archiveSurvey( session.managers.singleton.getUser(), survey ) />

<!--- Add a success message --->
<cfset session.managers.singleton.getSuccess().addMessages('The survey ''' & survey.getSurvey() & ''' was successfully removed.') />

<!--- Redirect --->
<cfset theURL.setRedirect('_base', '/survey/list') />
<cfset theURL.removeRedirect('survey') />

<cfset theURL.redirectRedirect() />
