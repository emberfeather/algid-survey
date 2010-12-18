<cfcomponent extends="algid.inc.resource.base.event" output="false">
<cfscript>
	public void function afterSave( required struct transport, required component currUser, required component survey ) {
		var servSurvey = getService(arguments.transport, 'survey', 'survey');
		
		// Update the i18n for the survey
		servSurvey.updateI18N(arguments.currUser, arguments.survey);
	}
</cfscript>
</cfcomponent>
