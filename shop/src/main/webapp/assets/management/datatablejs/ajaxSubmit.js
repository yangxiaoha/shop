(function($, window){

	$.fn.ajaxSubmit = function(_config){
		
		var defaults = {
			"success":null,
			"error":null
		}
		
		var _oSelf = this,
    	$this = $(this);
		this.config = $.extend(defaults, _config);
		
		var _init = function(){
			$.ajax({
				url:$this.attr("action"),
				data:$this.serialize(),
				dataType:"json",
				type:$this.attr("method"),
				success:_oSelf.config.success,
				error:_oSelf.config.error
			});
		};
		
		_init();
		
		return this;
	}
	
})(jQuery,window)
function reset(form){
		$(':input',"#" + $(form).attr("id"))
	 .not(':button, :submit, :reset, :hidden')  
	 .val('')  
	 .removeAttr('checked')  
	 .removeAttr('selected');  
}

function getchecked(name){
	var str="";
    $("input[name='"+name+"']:checkbox").each(function(){ 
        if($(this).is(":checked")){
        	if(str != ""){
            	str+=","+$(this).val();	
        	}else{
        		str = $(this).val();
        	}
        }
    });
    return str;
}