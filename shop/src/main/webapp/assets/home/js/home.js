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