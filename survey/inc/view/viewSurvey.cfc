<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="display" access="public" returntype="string" output="false">
		<cfargument name="survey" type="component" required="true" />
		
		<cfset var html = '' />
		<cfset var i = '' />
		<cfset var j = '' />
		<cfset var y = '' />
		<cfset var current = 1 />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<div class="survey">
					<cfloop from="1" to="#randRange(1, 4)#" index="y">
						<div class="tab tab-#y#">
							<cfloop from="1" to="#randRange(1, 4)#" index="i">
								<div class="section section-#i#">
									<h3>Section #i#</h3>
									
									<cfloop from="1" to="#randRange(3, 24)#" index="j">
										<div class="item<cfif i eq 2 and j eq 3> current<cfelseif randRange(1,100) mod 4 eq 1> noResponse</cfif>">
											<div class="question question-#current#">
												<div class="number">#current#</div>
												
												<h4>#randomTitle()#</h4>
											</div>
											<div class="answer">
												Answer options
											</div>
										</div>
										
										<cfset current++ />
									</cfloop>
								</div>
							</cfloop>
						</div>
					</cfloop>
				</div>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<!--- TODO Remove --->
	<cffunction name="randomTitle" access="public" returntype="string" output="false">
		<cfset var titles = [
				'How much wood could a wood chuck chuck if a wood chuck could chuck wood?',
				'How cool would I be if I were cool like you?'
			] />
		
		<cfreturn titles[randRange(1, arrayLen(titles))] />
	</cffunction>
</cfcomponent>
