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
}
