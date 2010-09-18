<cfcomponent extends="cf-compendium.inc.resource.structure.formExtended" output="false">
	<!--- 
		Formats the given element into html output.
	--->
	<cffunction name="showElement" access="private" returntype="string" output="false">
		<cfargument name="element" type="struct" required="true" />
		
		<cfset var formatted = '' />
		
		<!--- hidden elements should not be shown --->
		<cfif arguments.element.elementType neq 'hidden'>
			<!--- Start the tag --->
			<cfset formatted = '<div class="element' />
			
			<!--- Check for a required element --->
			<cfif arguments.element.required>
				<cfset formatted &= ' required' />
			</cfif>
			
			<!--- Finish div --->
			<cfset formatted &= '">' />
			
			<!--- Output the label --->
			<cfif not isStruct(arguments.element.label)>
				<cfset arguments.element.label = {
						value = arguments.element.label
					} />
			</cfif>
			
			<cfif structKeyExists(arguments.element.label, 'value') and arguments.element.label.value neq ''>
				<cfif arguments.element.id neq ''>
					<cfset arguments.element.label.for = arguments.element.id />
				</cfif>
				
				<cfset formatted &= '<label ' />
				
				<!--- Common HTML Attributes --->
				<cfset formatted &= commonAttributesHtml(arguments.element.label) />
				
				<!--- Common element attributes --->
				<cfset formatted &= commonAttributesLabel(arguments.element.label) />
				
				<cfset formatted &= '>' & variables.label.get(arguments.element.label.value) & ':</label>' />
			</cfif>
			
			<!--- Add the pre element text --->
			<cfset formatted &= arguments.element.preElement />
		</cfif>
		
		<!--- Get the html for the element --->
		<cfset formatted &= elementToHTML(arguments.element) />
		
		<!--- hidden elements should not be shown --->
		<cfif arguments.element.elementType neq 'hidden'>
			<!--- Add the post element text --->
			<cfset formatted &= arguments.element.postElement />
			
			<!--- End the tag --->
			<cfset formatted &= '</div>' />
		</cfif>
		
		<cfreturn formatted />
	</cffunction>
</cfcomponent>
