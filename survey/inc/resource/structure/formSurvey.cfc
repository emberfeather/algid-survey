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
			<cfcase value="grid">
				<cfreturn elementGrid(arguments.element) />
			</cfcase>
			<cfcase value="rank">
				<cfreturn elementRank(arguments.element) />
			</cfcase>
			<cfcase value="singleChoice">
				<cfreturn elementSingleChoice(arguments.element) />
			</cfcase>
			<cfdefaultcase>
				<cfreturn super.elementToHTML(arguments.element) />
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<!--- 
		Creates the grid form element.
	--->
	<cffunction name="elementGrid" access="private" returntype="string" output="false">
		<cfargument name="element" type="struct" required="true" />
		
		<cfset var formatted = '' />
		<cfset var group = '' />
		<cfset var optGroups = '' />
		<cfset var option = '' />
		
		<cfset formatted = '<div ' />
		
		<!--- Common HTML Attributes --->
		<cfset formatted &= commonAttributesHtml(arguments.element) />
		
		<cfset formatted &= '>' />
		
		<cfset formatted &= 'Grid Not implemented yet.' />
		
		<cfset formatted &= '</div>' />
		
		<cfreturn formatted />
	</cffunction>
	
	<!--- 
		Creates the rank form element.
	--->
	<cffunction name="elementRank" access="private" returntype="string" output="false">
		<cfargument name="element" type="struct" required="true" />
		
		<cfset var formatted = '' />
		<cfset var group = '' />
		<cfset var optGroups = '' />
		<cfset var option = '' />
		
		<cfset formatted = '<div ' />
		
		<!--- Common HTML Attributes --->
		<cfset formatted &= commonAttributesHtml(arguments.element) />
		
		<cfset formatted &= '>' />
		
		<!--- TODO Determine if we have thresholds --->
		
		<!--- 
		<!--- Get the option groups --->
		<cfset optGroups = arguments.element.options.get() />
		
		<cfset formatted &= '<div class="col ranked">' />
		
		<!--- Output the ranked options --->
		<cfset formatted &= '<div><strong>Ranking</strong></div>' />
		
		<cfloop array="#optGroups#" index="group">
			<cfset formatted &= '<ol>' />
			
			<cfloop array="#group.options#" index="option">
				<cfset formatted &= '<li id="' & arguments.element.name & '-' & option.value & '"' />
				
				<!--- Selected --->
				<cfif option.value eq arguments.element.value>
					<cfset formatted &= ' class="selected"' />
				</cfif>
				
				<cfset formatted &= '>' & option.title & '</li>' />
			</cfloop>
			
			<cfset formatted &= '</ol>' />
		</cfloop>
		
		<cfset formatted &= '</div>' />
		
		<cfset formatted &= '<div class="col available">' />
		
		<!--- Output the unranked options --->
		<cfset formatted &= '<div><strong>Available</strong></div>' />
		<cfloop array="#optGroups#" index="group">
			<cfif group.label neq ''>
				<cfset formatted &= '<div>' & variables.label.get(group.label) & '</div>' />
			</cfif>
			
			<cfset formatted &= '<ul>' />
			
			<cfloop array="#group.options#" index="option">
				<cfset formatted &= '<li id="' & arguments.element.name & '-' & option.value & '"' />
				
				<!--- Selected --->
				<cfif option.value eq arguments.element.value>
					<cfset formatted &= ' class="selected"' />
				</cfif>
				
				<cfset formatted &= '>' & option.title & '</li>' />
			</cfloop>
			
			<cfset formatted &= '</ul>' />
		</cfloop>
		
		<cfset formatted &= '</div>' />
		 --->
		
		<cfset formatted &= 'Not implemented yet.' />
		
		<cfset formatted &= '</div>' />
		
		<cfreturn formatted />
	</cffunction>
	
	<!--- 
		Creates the checkbox form element.
	--->
	<cffunction name="elementSingleChoice" access="private" returntype="string" output="false">
		<cfargument name="element" type="struct" required="true" />
		
		<cfset var formatted = '' />
		<cfset var defaults = {} />
		
		<!--- Set defaults --->
		<cfset defaults.type = 'auto' />
		
		<!--- Extend the form options --->
		<cfset arguments.element = variables.extender.extend(defaults, arguments.element) />
		
		<!--- Check for automatic type determination --->
		<cfif arguments.element.type eq 'auto'>
			<cfswitch expression="#arguments.element.options.length()#">
				<cfcase value="1">
					<cfset arguments.element.type = 'checkbox' />
				</cfcase>
				
				<cfcase value="2,3,4,5">
					<cfset arguments.element.type = 'radio' />
				</cfcase>
				
				<cfdefaultcase>
					<cfset arguments.element.type = 'autocomplete' />
				</cfdefaultcase>
			</cfswitch>
		</cfif>
		
		<cfswitch expression="#arguments.element.type#">
			<cfcase value="checkbox">
				<cfset formatted = elementCheckbox(arguments.element) />
			</cfcase>
			
			<cfcase value="radio">
				<cfset formatted = elementRadio(arguments.element) />
			</cfcase>
			
			<cfcase value="autocomplete">
				<cfset formatted = elementAutocomplete(arguments.element) />
			</cfcase>
			
			<cfdefaultcase>
				<cfset formatted = 'Unrecognized type: ' & arguments.element.type & '.' />
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn formatted />
	</cffunction>
</cfcomponent>
