$(document).ready(function() {
	$("#bill_submit").bind('click', function(){
		$("#bill_labor").attr('value', $("#labor_button").hasClass("active") ? 't' : 'f')
	})
})