document.addEventListener('DOMContentLoaded', function() {
	console.log('DOM fully loaded and parsed');
	$('#datepicker').datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'hh:mm:ss',
	});
});
