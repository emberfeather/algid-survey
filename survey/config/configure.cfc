component extends="algid.inc.resource.plugin.configure" {
	public void function onApplicationStart(required struct theApplication) {
		var plugin = '';
		var storagePath = '';
		
		// Get the plugin
		plugin = arguments.theApplication.managers.plugin.getContent();
		
		storagePath = plugin.getStoragePath();
		
		// Make sure that the i18n directory exists
		if( !directoryExists(storagePath & '/i18n') ) {
			directoryCreate(storagePath & '/i18n');
		}
	}
}
