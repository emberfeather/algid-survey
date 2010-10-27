component extends="plugins.mongodb.inc.resource.base.model" {
	public component function init(required component i18n, required string locale) {
		super.init(arguments.i18n, arguments.locale);
		
		// Survey ID
		addAttribute(
				attribute = '_id'
			);
		
		// Archived On
		addAttribute(
				attribute = 'archivedOn'
			);
		
		// Questions
		addAttribute(
				attribute = 'questions',
				defaultValue = []
			);
		
		// Responses
		addAttribute(
				attribute = 'responses',
				defaultValue = []
			);
		
		// Survey
		addAttribute(
				attribute = 'survey'
			);
		
		// Set the bundle information for translation
		addBundle('plugins/survey/i18n/inc/model', 'modSurvey');
		
		return this;
	}
	
	/**
	 * Don't count any surveys that are archived.
	 */
	public function lengthQuestions() {
		var count = 0;
		var i = '';
		
		for( i = 1; i <= arrayLen(variables.instance.questions); i++ ) {
			if( !structKeyExists(variables.instance.questions[i], 'archivedOn') || variables.instance.questions[i].archivedOn == '' ) {
				count++;
			}
		}
		
		return count;
	}
}
