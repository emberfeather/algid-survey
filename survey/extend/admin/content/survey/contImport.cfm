<cfset viewSurvey = views.get('survey', 'survey') />

<cfoutput>
	#viewSurvey.import(form)#
</cfoutput>
