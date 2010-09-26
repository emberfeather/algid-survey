<cfset responses = servResponse.getResponses( theUrl.search('survey'), filter ) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(arrayLen(responses), session.numPerPage, theURL.searchID('onPage')) />

<cfoutput>#viewMaster.datagrid(transport, responses, viewResponse, paginate, filter)#</cfoutput>
