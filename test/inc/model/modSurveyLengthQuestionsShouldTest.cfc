component extends="mxunit.framework.TestCase" {
	public void function setup() {
		variables.i18n = createObject('component', 'cf-compendium.inc.resource.i18n.i18n').init(expandPath('/'));
		variables.survey = createObject('component', 'plugins.survey.inc.model.modSurvey').init(variables.i18n);
	}
	
	public void function testSucceedWithoutQuestions() {
		assertEquals(0, variables.survey.lengthQuestions());
	}
	
	public void function testSucceedWithQuestions() {
		variables.survey.addQuestions(
			{ 'question': 'Am I alone?' },
			{ 'question': 'Am you alone?' },
			{ 'question': 'Am we alone?' }
		);
		
		assertEquals(3, variables.survey.lengthQuestions());
	}
	
	public void function testSucceedWithQuestionsAndArchivedQuestions() {
		variables.survey.addQuestions(
			{ 'question': 'Am I alone?' },
			{ 'question': 'Am you alone?' },
			{ 'question': 'Am we alone?' },
			{ 'question': 'Am they alone?' },
			{ 'question': 'Is someone alone?', 'archivedOn': now() }
		);
		
		assertEquals(4, variables.survey.lengthQuestions());
	}
}
