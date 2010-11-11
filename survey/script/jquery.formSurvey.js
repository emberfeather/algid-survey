/**
 * Form
 * 
 * Used to unobtrusively enhance the form experience for the user.
 */
(function($) {
	$(function() {
		var elements = $('.form .element');
		
		// Make the single choice elements into button sets
		elements.filter('.singleChoice').find('.options').buttonset().end().end();
	});
}(jQuery));