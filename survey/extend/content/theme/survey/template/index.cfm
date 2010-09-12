<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title><cfoutput>#template.getHTMltitle()#</cfoutput></title>
		
		<!--- Include minified files for production --->
		<cfset midfix = (transport.theApplication.managers.singleton.getApplication().isProduction() ? '-min' : '') />
		
		<cfset template.addStyles(
			'plugins/admin/style/960/reset#midfix#.css',
			'plugins/admin/style/960/960#midfix#.css',
			'https://fonts.googleapis.com/css?family=OFL+Sorts+Mill+Goudy+TT|Josefin+Sans+Std+Light|Molengo',
			'plugins/survey/extend/content/theme/survey/style/styles#midfix#.css'
		) />
		<cfset template.addStyle('plugins/survey/extend/content/theme/survey/style/print#midfix#.css', 'print') />
		
		<cfset template.addScripts('plugins/survey/extend/content/theme/survey/script/survey#midfix#.js') />
		
		<cfoutput>#template.getStyles()#</cfoutput>
	</head>
	<body>
		<div class="container_outer">
			<div class="container_12">
				<div class="container_inner">
					<div class="grid_9">
						<h1><cfoutput>#template.getPageTitle()#</cfoutput></h1>
						
						<!--- Show any messages, errors, warnings, or successes --->
						<cfset messages = session.managers.singleton.getError() />
						
						<cfoutput>#messages.toHTML()#</cfoutput>
						
						<cfset messages = session.managers.singleton.getWarning() />
						
						<cfoutput>#messages.toHTML()#</cfoutput>
						
						<cfset messages = session.managers.singleton.getSuccess() />
						
						<cfoutput>#messages.toHTML()#</cfoutput>
						
						<cfset messages = session.managers.singleton.getMessage() />
						
						<cfoutput>#messages.toHTML()#</cfoutput>
						
						<div class="clear"><!-- clear --></div>
						
						<!--- Output the main content --->
						<cfoutput>#template.getContent()#</cfoutput>
					</div>
					
					<div class="grid_3">
						<div id="overview" class="grid_3 alpha omega">
							<div class="box">
								<progress id="surveyPosition" value="0" max="100"></progress>
							</div>
							
							<div class="stripe">
								<div id="surveyPercent">
									<span class="value">25</span><small>% Complete</small>
								</div>
								
								<progress id="surveyProgress" value="25" max="100"></progress>
								
								<div class="clear"><!-- clear --></div>
							</div>
							
							<div class="box">
								<dl>
									<dt>Contact Information</dt>
									<dd><span class="value">12</span>/16</dd>
									<dt>Prerequisites</dt>
									<dd><span class="value">1</span>/14</dd>
									<dt>Application Process</dt>
									<dd><span class="value">4</span>/18</dd>
									<dt>General Facts</dt>
									<dd><span class="value">2</span>/26</dd>
								</dl>
								<div class="clear"><!-- clear --></div>
							</div>
						</div>
					</div>
					
					<div class="clear"><!-- clear --></div>
				</div>
			</div>
		</div>
		
		<cfoutput>#template.getScripts()#</cfoutput>
	</body>
</html>
