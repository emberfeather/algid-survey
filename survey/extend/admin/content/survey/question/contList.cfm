<cfset questions = servQuestion.getQuestions( survey, filter ) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(arrayLen(questions), session.numPerPage, theURL.searchID('onPage')) />

<cfoutput>#viewMaster.datagrid(transport, questions, viewQuestion, paginate, filter)#</cfoutput>
