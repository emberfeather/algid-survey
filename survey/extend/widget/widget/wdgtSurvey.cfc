component extends="plugins.widget.inc.resource.base.widget" {
	public component function init(required struct transport, required string path) {
		super.init(arguments.transport, arguments.path);
		
		variables.servSurvey = getService('survey', 'survey');
		variables.theUrl = variables.transport.theRequest.managers.singleton.getUrl();
		variables.viewSurvey = getView('survey', 'survey');
		
		preventCaching();
		
		return this;
	}
	
	private string function createUrl( string survey = '' ) {
		var base = '';
		
		base = getBasePath();
		
		if(len(arguments.survey)) {
			base &= '/' & arguments.survey;
		}
		
		variables.theUrl.setSurvey('_base', base);
		
		return variables.theUrl.getSurvey();
	}
	
	public string function process( required string content, required struct args ) {
		var pathParts = '';
		
		pathParts = explodePath(variables.path);
		
		switch( arrayLen(pathParts) ) {
		case 1:
			return processSurvey(pathParts[1]);
			break;
		}
		
		return processSurveys();
	}
	
	public string function processSurvey( required string surveyID ) {
		var plugin = '';
		var survey = '';
		var template = '';
		var view = '';
		
		survey = variables.servSurvey.getSurvey(arguments.surveyID);
		
		// Add the survey title to the current template
		if (variables.transport.theRequest.managers.singleton.hasTemplate()) {
			plugin = transport.theApplication.managers.plugin.getSurvey();
			template = variables.transport.theRequest.managers.singleton.getTemplate();
			
			// Survey specific bundle
			template.addBundle(plugin.getStoragePath() & '/i18n', 'survey-' & survey.get_ID());
			
			template.addLevel(template.getLabel('survey'), template.getLabel('survey'), '', 0, true);
		}
		
		return variables.viewSurvey.display(survey, variables.transport.theForm);
	}
	
	public string function processSurveys() {
		var availableSurveys = '';
		var survey = '';
		var surveys = '';
		var html = '';
		var i = '';
		var theUrl = '';
		
		theUrl = variables.transport.theRequest.managers.singleton.getUrl();
		
		surveys =  variables.servSurvey.getSurveys({
			'isArchived' = false
		});
		
		html &= '<ul class="surveys">';
		
		for( i = 1; i <= arrayLen(surveys); i++ ) {
			html &= '<li><a href="#createUrl(surveys[i]._id)#">#surveys[i].survey#</a></li>';
		}
		
		html &= '</ul>';
		
		return html;
	}
}
