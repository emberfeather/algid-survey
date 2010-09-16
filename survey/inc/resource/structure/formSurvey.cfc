<cfcomponent extends="cf-compendium.inc.resource.structure.formExtended" output="false">
	<!--- 
		Used to format the actual HTML element.
	--->
	<cffunction name="element" access="private" returntype="string" output="false">
		<cfargument name="element" type="struct" required="true" />
		
		<cfswitch expression="#arguments.element.type#">
			<cfcase value="something">
				<cfreturn elementDate(arguments.element) />
			</cfcase>
			<cfdefaultcase>
				<cfreturn super.element(arguments.element) />
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<!--- 
		Creates the something form element.
	--->
	<cffunction name="elementSomething" access="private" returntype="string" output="false">
		<cfargument name="element" type="struct" required="true" />
		
		<cfset var formatted = '' />
		
		<cfset formatted = '< ' />
		
		<!--- Add additional attributes --->
		
		<cfset formatted &= '>' />
		
		<cfset formatted &= '</>' />
		
		<cfset formatted = 'The #arguments.element.type# element has not been programmed yet.' />
		
		<cfreturn formatted />
	</cffunction>
</cfcomponent>
