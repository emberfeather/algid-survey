<navigation>
	<survey position="main">
		<list position="action"/>
		<add position="action"/>
		<edit/>
		<archive/>
		
		<question position="main" vars="survey">
			<list position="action" vars="survey"/>
			<add position="action" vars="survey"/>
			<edit vars="survey,question"/>
			<archive vars="survey,question"/>
		</question>
		
		<response position="main" vars="survey">
			<list position="action" vars="survey"/>
			<view vars="survey"/>
			<archive vars="survey"/>
		</response>
	</survey>
</navigation>
