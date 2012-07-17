$(document).ready(function() {
	$("#close_button").bind('click', function(){
		$("#close").attr('value','true')
	})

	$("#bill_submit").bind('click', function(){
		$("#bill_labor").attr('value', $("#labor_button").hasClass("active") ? 't' : 'f')
	})
})