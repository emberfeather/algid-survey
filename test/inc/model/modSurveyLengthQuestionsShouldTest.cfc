component extends="algid.inc.resource.base.modelTest" {
	public void function setup() {
		super.setup();
		
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
