/**
 * Survey JavaScript
 * 
 * Used to unobtrusively enhance the survey experience for the user.
 */
(function($) {
	var positionElement;
	var percentElement;
	var progressElement;
	
	$.survey.hooks.updatePosition = function(current, total) {
		positionElement = positionElement || $('#surveyPosition');
		
		positionElement.attr('value', current);
		positionElement.attr('max', total);
	};
	
	$.survey.hooks.updatePercent = function(percent) {
		percentElement = percentElement || $('#surveyPercent');
		progressElement = progressElement || $('#surveyProgress');
		
		$('.value', percentElement).text(percent.toFixed(0));
		progressElement.attr('value', percent);
	};
}(jQuery));
