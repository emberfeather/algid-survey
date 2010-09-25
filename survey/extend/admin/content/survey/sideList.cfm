<cfset viewSurvey = views.get('survey', 'survey') />

<cfset filter = {
		'search' = theURL.search('search'),
		'isArchived' = false
	} />

<cfoutput>
	#viewSurvey.filter( filter )#
</cfoutput>
