<cfset viewSurvey = views.get('survey', 'survey') />

<cfset filter = {
		'search' = theURL.search('search')
	} />

<cfoutput>
	#viewSurvey.filter( filter )#
</cfoutput>
