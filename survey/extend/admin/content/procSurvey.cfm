<!--- Redirect to the list page if no survey chosen --->
<cfif theUrl.search('survey') eq ''>
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.redirectRedirect() />
</cfif>

<cfset servSurvey = services.get('survey', 'survey') />

<!--- Retrieve the object --->
<cfset survey = servSurvey.getSurvey( theURL.search('survey') ) />

<!--- Add to the current levels --->
<cfset template.addLevel(survey.getSurvey(), survey.getSurvey(), theUrl.get(), 0, true) />
