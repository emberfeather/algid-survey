component extends="algid.inc.resource.base.model" {
	public component function init(required component i18n, required string locale) {
		super.init(arguments.i18n, arguments.locale);
		
		// Survey ID
		addAttribute(
				attribute = '_id'
			);
		
		// Survey
		addAttribute(
				attribute = 'survey'
			);
		
		// Set the bundle information for translation
		addBundle('plugins/survey/i18n/inc/model', 'modSurvey');
		
		return this;
	}
}
