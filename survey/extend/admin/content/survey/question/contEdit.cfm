<cfset viewQuestion = views.get('survey', 'question') />

<cfoutput>
	#viewQuestion.edit(question)#
</cfoutput>
