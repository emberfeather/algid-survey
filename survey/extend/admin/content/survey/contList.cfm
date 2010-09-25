<cfset surveys = servSurvey.getSurveys( filter ) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(arrayLen(surveys), session.numPerPage, theURL.searchID('onPage')) />

<cfoutput>#viewMaster.datagrid(transport, surveys, viewSurvey, paginate, filter)#</cfoutput>
