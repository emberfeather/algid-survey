component extends="algid.inc.resource.base.view" {
	public string function display(required component survey, required struct request) {
		var i = '';
		var i18n = '';
		var j = '';
		var plugin = '';
		var questions = '';
		var newOptions = '';
		var theForm = '';
		var theUrl = '';
		
		i18n = variables.transport.theApplication.managers.singleton.getI18N();
		theURL = variables.transport.theRequest.managers.singleton.getUrl();
		theForm = variables.transport.theApplication.factories.transient.getFormForSurvey('survey', i18n);
		plugin = variables.transport.theApplication.managers.plugin.getSurvey();
		
		// Add the resource bundle for the view
		theForm.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey');
		
		// Survey specific bundle
		theForm.addBundle(plugin.getStoragePath() & '/i18n', 'survey-' & arguments.survey.get_ID());
		
		// Retrieve the questions
		questions = arguments.survey.getQuestions();
		
		if(!arrayLen(questions)) {
			return '<div><strong>No questions found.</strong></div>';
		}
		
		// Add all the questions to the form
		for(i = 1; i <= arrayLen(questions); i++) {
			if(! structKeyExists(questions[i], 'archivedOn') && structKeyExists(questions[i], 'field')) {
				if(!structKeyExists(questions[i].field.options, 'label')) {
					questions[i].field.options['label'] = 'question-' & questions[i]._id;
				}
				
				// Check for options
				if(structKeyExists(questions[i].field.options, 'options')) {
					newOptions = variables.transport.theApplication.factories.transient.getOptions();
					
					for(j = 1; j <= arrayLen(questions[i].field.options.options); j++) {
						newOptions.addOption(questions[i].field.options.options[j].text, questions[i].field.options.options[j].value);
					}
					
					questions[i].field.options.options = newOptions;
				}
				
				theForm.addElement(argumentCollection = questions[i].field);
			}
		}
		
		return theForm.toHTML(theURL.get(), { class: 'survey' });
	}
	
	public string function export(required any data, struct options) {
		var datagrid = '';
		var html = '';
		var i18n = '';
		
		arguments.options.theURL = variables.transport.theRequest.managers.singleton.getURL();
		i18n = variables.transport.theApplication.managers.singleton.getI18N();
		datagrid = variables.transport.theApplication.factories.transient.getDatagrid(i18n, variables.transport.theSession.managers.singleton.getSession().getLocale());
		
		// Add the resource bundle for the view
		datagrid.addBundle('plugins/survey/i18n/inc/view', 'viewSurvey');
		
		datagrid.addColumn({
			key = '_id',
			format = {
				checkbox: {}
			},
			class = 'width-min'
		});
		
		datagrid.addColumn({
			key = 'survey',
			label = 'survey',
			link = {
				'_base' = '/survey',
				'survey' = '_id'
			}
		});
		
		datagrid.addColumn({
			class = 'phantom align-right width-min',
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
		
		// Create a form for the datagrid
		html = '<form method="post" action="' & arguments.options.theURL.get() & '">';
		
		html &= datagrid.toHTML( arguments.data, arguments.options );
		
		html &= '<input type="submit" value="Export"></form>';
		
		return html;
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
	
	public string function import(struct request) {
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
		
		theForm.addElement('file', {
			name = "surveyFile",
			label = "surveyFile",
			value = ( structKeyExists(arguments.request, 'surveyFile') ? arguments.request.surveyFile : '' )
		});
		
		return theForm.toHTML(theURL.get());
	}
	
	public string function overview(required component survey) {
		var html = '';
		var theUrl = '';
		
		theUrl = variables.transport.theRequest.managers.singleton.getUrl();
		
		html = '<div class="grid_8 alpha">';
		
		html &= '<h3>Recent Responses</h3>';
		
		html &= '<div>TODO: Show a list of recent responses</div>';
		
		html &= '</div>';
		
		html &= '<div class="grid_4 omega">';
		
		html &= '<h3>Statistics</h3>';
		
		theUrl.setStats('_base', '/survey/question');
		
		html &= '<div><a href="' & theUrl.getStats() & '"><strong>' & arguments.survey.lengthQuestions() & '</strong> Questions</a></div>';
		
		theUrl.setStats('_base', '/survey/response');
		
		html &= '<div><a href="' & theUrl.getStats() & '"><div><strong>' & arguments.survey.lengthResponses() & '</strong> Responses</a></div>';
		
		html &= '</div>';
		
		return html;
	}
}
