<cfset viewQuestion = views.get('survey', 'question') />

<cfset filter = {
		'search' = theURL.search('search'),
		'isArchived' = false
	} />

<cfoutput>
	#viewQuestion.filter( filter )#
</cfoutput>
