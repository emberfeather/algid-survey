component extends="algid.inc.resource.base.event" {
	public void function afterArchive( required struct transport, required component currUser, required component survey, required component question ) {
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('The question ''' & arguments.question.getQuestion() & ''' was successfully removed.');
	}
	
	public void function afterCreate( required struct transport, required component currUser, required component survey, required component question ) {
		var eventLog = '';
		
		// Get the event log from the transport
		eventLog = arguments.transport.theApplication.managers.singleton.getEventLog();
		
		// Log the create event
		eventLog.logEvent('survey', 'createQuestion', 'Created the ''' & arguments.question.getQuestion() & ''' question.', arguments.currUser.getUserID(), arguments.question.getQuestionID());
		
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('The question ''' & arguments.question.getQuestion() & ''' was successfully created.');
	}
	
	public void function afterSave( required struct transport, required component currUser, required component survey, required component question ) {
		var servSurvey = getService(arguments.transport, 'survey', 'survey');
		
		// Pull the latest version of the survey with all the changes
		arguments.survey = servSurvey.getSurvey(arguments.currUser, arguments.survey.get_id());
		
		// Update the i18n for the survey
		servSurvey.updateI18N(arguments.currUser, arguments.survey);
	}
	
	public void function afterCreate( required struct transport, required component currUser, required component survey, required component question ) {
		var eventLog = '';
		
		// Get the event log from the transport
		eventLog = arguments.transport.theApplication.managers.singleton.getEventLog();
		
		// Log the update event
		eventLog.logEvent('survey', 'updateQuestion', 'Updated the ''' & arguments.question.getQuestion() & ''' question.', arguments.currUser.getUserID(), arguments.question.getQuestionID());
		
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('The question ''' & arguments.question.getQuestion() & ''' was successfully updated.');
	}
}
