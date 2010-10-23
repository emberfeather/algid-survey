<cfcomponent extends="cf-compendium.inc.resource.structure.formExtended" output="false">
	<!--- 
		Used to format the actual HTML element.
		<p>
		To add a custom element extend the form cfc and override the formatElement
		function and create a switch statement with the proper functions calls to the new
		elements. To keep the default elements available call super.formatElement in the default
		case of the override function.
	--->
	<cffunction name="elementToHTML" access="private" returntype="string" output="false">
		<cfargument name="element" type="struct" required="true" />
		
		<cfswitch expression="#arguments.element.elementType#">
			<cfcase value="rank">
				<cfreturn elementRank(arguments.element) />
			</cfcase>
			<cfdefaultcase>
				<cfreturn super.elementToHTML(arguments.element) />
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<!--- 
		Creates the rank form element.
	--->
	<cffunction name="elementRank" access="private" returntype="string" output="false">
		<cfargument name="element" type="struct" required="true" />
		
		<cfset var formatted = '' />
		
		<cfset formatted = '<div ' />
		
		<!--- Common HTML Attributes --->
		<cfset formatted &= commonAttributesHtml(arguments.element) />
		
		<!--- Common Element Attributes --->
		<cfset formatted &= commonAttributesMeter(arguments.element) />
		
		<cfset formatted &= '>' />
		
		<cfset formatted &= 'Rank Goes Here...' />
		
		<cfset formatted &= '</div>' />
		
		<cfreturn formatted />
	</cffunction>
</cfcomponent>
