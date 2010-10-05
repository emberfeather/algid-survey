component extends="algid.inc.resource.base.view" {
	public string function display(required component survey, required struct request) {
		var i = '';
		var i18n = '';
		var questions = '';
		var theForm = '';
		var theUrl = '';
		
		i18n = variables.transport.theApplication.managers.singleton.getI18N();
		theURL = variables.transport.theRequest.managers.singleton.getUrl();
		theForm = variables.transport.theApplication.factories.transient.getFormForSurvey('survey', i18n);
		
		// Add the resource bundle for the view
		theForm.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey');
		
		// TODO Survey specific bundle
		
		// Retrieve the questions
		questions = arguments.survey.getQuestions();
		
		if(!arrayLen(questions)) {
			return '<div><strong>No questions found.</strong></div>';
		}
		
		// Add all the questions to the form
		for(i = 1; i <= arrayLen(questions); i++) {
			if(structKeyExists(questions[i], 'field')) {
				theForm.addElement(argumentCollection = questions[i].field);
			}
		}
		
		return theForm.toHTML(theURL.get());
	}
	
	public string function edit(required component survey, struct request) {
		var i = '';
		var i18n = '';
		var theForm = '';
		var theURL = '';
		var question = '';
		var questions = '';
		
		i18n = variables.transport.theApplication.managers.singleton.getI18N();
		theURL = variables.transport.theRequest.managers.singleton.getUrl();
		theForm = variables.transport.theApplication.factories.transient.getFormStandard('survey', i18n);
		
		// Add the resource bundle for the view
		theForm.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey');
		
		theForm.addElement('text', {
			name = "survey",
			label = "survey",
			value = ( structKeyExists(arguments.request, 'survey') ? arguments.request.survey : arguments.survey.getSurvey() )
		});
		
		return theForm.toHTML(theURL.get());
	}
	
	public string function filterActive(struct filter) {
		var filterActive = '';
		var options = '';
		var results = '';
		
		filterActive = variables.transport.theApplication.factories.transient.getFilterActive(variables.transport.theApplication.managers.singleton.getI18N());
		
		// Add the resource bundle for the view
		filterActive.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey');
		
		return filterActive.toHTML(arguments.filter, variables.transport.theRequest.managers.singleton.getURL(), 'search');
	}
	
	public string function filter(struct values) {
		var filter = '';
		var options = '';
		var results = '';
		
		filter = variables.transport.theApplication.factories.transient.getFilterVertical(variables.transport.theApplication.managers.singleton.getI18N());
		
		// Add the resource bundle for the view
		filter.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey');
		
		// Search
		filter.addFilter('search');
		
		return filter.toHTML(variables.transport.theRequest.managers.singleton.getURL(), arguments.values);
	}
	
	public string function datagrid(required any data, struct options) {
		var datagrid = '';
		var i18n = '';
		
		arguments.options.theURL = variables.transport.theRequest.managers.singleton.getURL();
		i18n = variables.transport.theApplication.managers.singleton.getI18N();
		datagrid = variables.transport.theApplication.factories.transient.getDatagrid(i18n, variables.transport.theSession.managers.singleton.getSession().getLocale());
		
		// Add the resource bundle for the view
		datagrid.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey');
		
		datagrid.addColumn({
				key = 'survey',
				label = 'survey',
				link = {
					'_base' = '/survey',
					'survey' = '_id'
				}
			});
		
		datagrid.addColumn({
				class = 'phantom align-right',
				value = [ 'delete', 'edit' ],
				link = [
					{
						'survey' = '_id',
						'_base' = '/survey/archive'
					},
					{
						'survey' = '_id',
						'_base' = '/survey/edit'
					}
				],
				linkClass = [ 'delete', '' ]
			});
		
		return datagrid.toHTML( arguments.data, arguments.options );
	}
	
	// TODO Remove
	public string function randomTitle() {
		var titles = [
				'How much wood could a wood chuck chuck if a wood chuck could chuck wood?',
				'How cool would I be if I were cool like you?'
			];
		
		return titles[randRange(1, arrayLen(titles))];
	}
}
