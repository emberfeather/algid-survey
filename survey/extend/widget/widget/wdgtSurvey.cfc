component extends="plugins.widget.inc.resource.base.widget" {
	public component function init(required struct transport) {
		super.init(arguments.transport);
		
		variables.servSurvey = getService('survey', 'survey');
		variables.theUrl = variables.transport.theRequest.managers.singleton.getUrl();
		variables.viewSurvey = getView('survey', 'survey');
		
		preventCaching();
		
		return this;
	}
	
	private string function createUrl( string survey = '' ) {
		var base = '';
		
		base = cleanPath(variables.theUrl.search('_base'));
		
		if(len(variables.path)) {
			base = left(base, len(base) - len(variables.path));
		}
		
		if(len(arguments.survey)) {
			base &= '/' & arguments.survey;
		}
		
		variables.theUrl.setSurvey('_base', base);
		
		return variables.theUrl.getSurvey();
	}
	
	public string function process( required string path, required string content, required struct args ) {
		var pathParts = '';
		
		variables.path = cleanPath(arguments.path);
		
		pathParts = explodePath(variables.path);
		
		switch( arrayLen(pathParts) ) {
		case 1:
			return processSurvey(pathParts[1]);
			break;
		}
		
		return processSurveys();
	}
	
	public string function processSurvey( required string surveyID ) {
		var survey = '';
		var user = '';
		var view = '';
		
		user = variables.transport.theSession.managers.singleton.getUser();
		survey = variables.servSurvey.getSurvey(user, arguments.surveyID);
		
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
