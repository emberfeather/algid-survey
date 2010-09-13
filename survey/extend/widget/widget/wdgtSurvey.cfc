component extends="plugins.widget.inc.resource.base.widget" {
	public component function init(required struct transport) {
		super.init(arguments.transport);
		
		variables.servSurvey = variables.services.get('survey', 'survey');
		variables.theUrl = variables.transport.theRequest.managers.singleton.getUrl();
		
		// TODO Remove
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
		var html = '';
		var pathParts = '';
		
		variables.path = cleanPath(arguments.path);
		
		pathParts = explodePath(variables.path);
		
		html = 'Testing widget';
		
		return html;
	}
}
