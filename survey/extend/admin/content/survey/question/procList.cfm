<!--- Redirect to the list page if no survey chosen --->
<cfif theUrl.search('survey') eq ''>
	<cfset transport.theSession.managers.singleton.getMessage().addMessages('Please select a survey before working with questions.') />
	
	<cfset theURL.setRedirect('_base', '/survey/list') />
	<cfset theURL.redirectRedirect() />
</cfif>

<cfset servQuestion = services.get('survey', 'question') />

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cfset theURL.redirect() />
</cfif>
