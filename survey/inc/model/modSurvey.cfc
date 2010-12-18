component extends="plugins.mongodb.inc.resource.base.model" {
	public component function init(required component i18n, string locale = 'en_US') {
		super.init(arguments.i18n, arguments.locale);
		
		// Survey ID
		addAttribute(
				attribute = '_id'
			);
		
		// Archived On
		addAttribute(
				attribute = 'archivedOn'
			);
		
		// I18N
		addAttribute(
				attribute = 'i18n',
				defaultValue = {}
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
	
	public array function getLocales() {
		return listToArray(structKeyList(this.getI18N()));
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
	
	public string function _toProperties(string locale = 'en_US') {
		var i = '';
		var i18n = this.getI18N();
		var text = '';
		var questions = '';
		
		text = '## Survey Title' & chr(10) & 'survey=' & i18n[arguments.locale].survey & chr(10);
		
		return text;
	}
}
