<cfset viewResponse = views.get('survey', 'response') />

<cfset filter = {
		'search' = theURL.search('search'),
		'isArchived' = false
	} />

<cfoutput>
	#viewResponse.filter( filter )#
</cfoutput>
