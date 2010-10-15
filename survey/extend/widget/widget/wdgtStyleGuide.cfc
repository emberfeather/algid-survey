component extends="plugins.widget.inc.resource.base.widget" {
	public component function init(required struct transport) {
		super.init(arguments.transport);
		
		variables.theUrl = variables.transport.theRequest.managers.singleton.getUrl();
		variables.i18n = variables.transport.theApplication.managers.singleton.getI18N();
		
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
		var theForm = variables.transport.theApplication.factories.transient.getFormForSurvey('survey', variables.i18n);
		
		// Add the resource bundle for the style guide
		theForm.addBundle('plugins/survey/i18n/extend/widget/widget', 'wdgtStyleGuide');
		
		// Add a mangerie of survey fields to showcase for styling
		
		// Text
		theForm.addElement('text', {
			name: 'text',
			label: 'text',
			value: ''
		});
		
		// Textarea
		theForm.addElement('textarea', {
			name: 'textarea',
			label: 'textarea',
			value: ''
		});
		
		// Email
		theForm.addElement('email', {
			name: 'email',
			label: 'email',
			value: ''
		});
		
		// Url
		theForm.addElement('url', {
			name: 'url',
			label: 'url',
			value: ''
		});
		
		// Range
		theForm.addElement('range', {
			name: 'range',
			label: 'range',
			value: ''
		});
		
		// Color
		theForm.addElement('color', {
			name: 'color',
			label: 'color',
			value: ''
		});
		
		// Date and Time
		theForm.addElement('datetime', {
			name: 'datetime',
			label: 'datetime',
			value: ''
		});
		
		// Date
		theForm.addElement('date', {
			name: 'date',
			label: 'date',
			value: ''
		});
		
		// Time
		theForm.addElement('time', {
			name: 'time',
			label: 'time',
			value: ''
		});
		
		// Month
		theForm.addElement('month', {
			name: 'month',
			label: 'month',
			value: ''
		});
		
		// Week
		theForm.addElement('week', {
			name: 'week',
			label: 'week',
			value: ''
		});
		
		// Number
		theForm.addElement('number', {
			name: 'number',
			label: 'number',
			value: ''
		});
		
		// Phone Number
		theForm.addElement('tel', {
			name: 'tel',
			label: 'tel',
			value: ''
		});
		
		return '<div><strong>This form is for styling purposes and is not functional.</strong></div>' & theForm.toHTML(theURL.get());
	}
}
