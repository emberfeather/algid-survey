<!--- Redirect to the list page if no survey chosen --->
<cfif theUrl.search('survey') eq ''>
	<cfset transport.theSession.managers.singleton.getMessage().addMessages('Please select a survey before working with questions.') />
	
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.redirectRedirect() />
</cfif>

<!--- Redirect to the list page until a good reason for this page exists --->
<cfset theURL.setRedirect('_base', '/survey/question/list') />
<cfset theURL.redirectRedirect() />
