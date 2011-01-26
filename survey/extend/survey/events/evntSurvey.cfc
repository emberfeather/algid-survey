component extends="algid.inc.resource.base.event" {
	public void function afterArchive( required struct transport, required component currUser, required component survey ) {
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('The survey ''' & arguments.survey.getSurvey() & ''' was successfully removed.');
	}
	
	public void function afterImport( required struct transport, required component currUser, required struct import ) {
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('The surveys were successfully imported.');
	}
	
	public void function afterCreate( required struct transport, required component currUser, required component survey ) {
		var eventLog = '';
		
		// Get the event log from the transport
		eventLog = arguments.transport.theApplication.managers.singleton.getEventLog();
		
		// Log the create event
		eventLog.logEvent('survey', 'createSurvey', 'Created the ''' & arguments.survey.getSurvey() & ''' survey.', arguments.currUser.getUserID(), arguments.survey.getSurveyID());
		
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('The survey ''' & arguments.survey.getSurvey() & ''' was successfully created.');
	}
	
	public void function afterSave( required struct transport, required component currUser, required component survey ) {
		var servSurvey = getService(arguments.transport, 'survey', 'survey');
		
		// Update the i18n for the survey
		servSurvey.updateI18N(arguments.currUser, arguments.survey);
	}
	
	public void function afterUpdate( required struct transport, required component currUser, required component survey ) {
		var eventLog = '';
		
		// Get the event log from the transport
		eventLog = arguments.transport.theApplication.managers.singleton.getEventLog();
		
		// Log the update event
		eventLog.logEvent('survey', 'updateSurvey', 'Updated the ''' & arguments.survey.getSurvey() & ''' survey.', arguments.currUser.getUserID(), arguments.survey.getSurveyID());
		
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('The survey ''' & arguments.survey.getSurvey() & ''' was successfully updated.');
	}
}
