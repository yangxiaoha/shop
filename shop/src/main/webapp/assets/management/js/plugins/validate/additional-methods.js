jQuery.validator.addMethod("noEqualTo", function(value, element,param) { 
	    return value != $(param).val();
}, "上级类型不能是自己！");