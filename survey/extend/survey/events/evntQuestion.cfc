component extends="algid.inc.resource.base.event" {
	public void function afterSave( required struct transport, required component currUser, required component survey, required component question ) {
		var servSurvey = getService(arguments.transport, 'survey', 'survey');
		
		// Pull the latest version of the survey with all the changes
		arguments.survey = servSurvey.getSurvey(arguments.currUser, arguments.survey.get_id());
		
		// Update the i18n for the survey
		servSurvey.updateI18N(arguments.currUser, arguments.survey);
	}
}
