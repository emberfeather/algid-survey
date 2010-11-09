component extends="plugins.mongodb.inc.resource.base.model" {
	public component function init(required component i18n, required string locale) {
		super.init(arguments.i18n, arguments.locale);
		
		// Question ID
		addAttribute(
				attribute = '_id'
			);
		
		// Archived On
		addAttribute(
				attribute = 'archivedOn'
			);
		
		// Field
		addAttribute(
				attribute = 'field'
			);
		
		// I18N
		addAttribute(
				attribute = 'i18n',
				defaultValue = {}
			);
		
		// Question
		addAttribute(
				attribute = 'question'
			);
		
		// Order By
		addAttribute(
				attribute = 'orderBy',
				defaultValue = 1000
			);
		
		// Set the bundle information for translation
		addBundle('plugins/survey/i18n/inc/model', 'modQuestion');
		
		return this;
	}
	
	public string function _toProperties(string locale = 'en_US') {
		var i = '';
		var i18n = this.getI18N();
		var text = '';
		
		text = 'question-' & this.get_ID() & '=' & i18n[arguments.locale] & chr(10);
		
		// TODO Convert any option locales
		
		return text;
	}
}
