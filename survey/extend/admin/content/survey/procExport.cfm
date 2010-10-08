<cfset servSurvey = services.get('survey', 'survey') />

<cfif cgi.request_method eq 'post'>
	<!--- Process the form submission --->
	<cfset results = {
		'exportedOn': now(),
		'surveys': []
	} />
	
	<!--- Retrieve selected surveys --->
	<cfset filter = {
		in_id: form.checkboxSelect
	} />
	
	<cfset results.surveys = servSurvey.getSurveys(filter) />
	
	<cfset resultFile = gettempDirectory() & createUUID() & '.json' />
	
	<!--- Convert to json and write to disk --->
	<cfset fileWrite(resultFile, serializeJSON(results)) />
	
	<!--- Pipe out json file to browser --->
	<cfheader name="Content-Type" value="application/json" />
	<cfheader name="Content-Disposition" value="attachment;filename=surveyExport-#dateFormat(now(), 'yyyy-mm-dd')#.json" />
	
	<!--- Output file and delete when done --->
	<cfcontent type="application/json" file="#resultFile#" deletefile="true" />
	
	<cfabort />
</cfif>
