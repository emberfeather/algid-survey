<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="display" access="public" returntype="string" output="false">
		<cfargument name="survey" type="component" required="true" />
		
		<cfset var html = '' />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<div class="section">
					<cfloop from="1" to="144" index="i">
						<div class="item<cfif i eq 3> current<cfelseif randRange(1,100) mod 4 eq 1> noResponse</cfif>">
							<div class="question">
								<div class="number">#i#</div>
								
								<h4>#randomTitle()#</h4>
							</div>
							<div class="answer">
								Answer options
							</div>
						</div>
					</cfloop>
				</div>
			</cfoutput>
		</cfsavecontent>
		
		<!--- Since markdown needs html to be not indented on the first and last line of html --->
		<cfset html = chr(10) & '<div class="survey">' & html & chr(10) & '</div>' & chr(10) />
		
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
