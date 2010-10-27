/**
 * Survey JavaScript
 * 
 * Used to unobtrusively enhance the survey experience for the user.
 */
;(function($) {
	// Default functionality for hooks
	var doNothing = function() {};
	
	$.survey = {
		hooks: {
			updatePosition: doNothing,
			updatePercent: doNothing
		}
	};
	
	$(function() {
		// Make the advanced form functions work
		$('.form.survey .element.rank').each(function() {
			var options = $('ul, ol', this);
			
			options.sortable({ connectWith: options });
		});
		
		// Test out the update hooks
		$.survey.hooks.updatePosition(12, 14);
		$.survey.hooks.updatePercent((10/14) * 100);
	});
})(jQuery);
