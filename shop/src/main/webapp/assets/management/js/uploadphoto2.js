//图片上传预览，IE用了滤镜
function previewImage(file,id)
{
  var MAXWIDTH  = file.parentNode.offsetWidth;//最外层容器的宽度
  var MAXHEIGHT = file.parentNode.offsetHeight;//最外层容器的高度
  // var div = document.getElementById('preview');//图片的父容器
  var div = file.parentNode.childNodes;
  if (file.files && file.files[0])
  {
      div[1].innerHTML = '<img id='+id+' />';
      // var img = document.getElementById('imghead');//获取图片
      var divChild = div[1].childNodes;
      var img = removeWhiteNode(divChild);
      var _URL = window.URL || window.webkitURL;
      img1 = new Image();
      img1.onload = function () {
    	  if(this.width!=imglong||this.height!=imgwide){
    		  alert(imgsize);
    		  $(imgheads).attr("src",imgmol);
    		  $(imgheads).css({"width":imglong1,"height":imgwide1});   		  
    		  imageFlag = false;
    	  }else{
    		  imageFlag = true;
    	  }
      };
      img1.src = _URL.createObjectURL(file.files[0]);
      img[0].onload = function(){
        var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img[0].offsetWidth, img[0].offsetHeight);        
        img[0].width  =  rect.width;
        img[0].height =  rect.height;
        img[0].style.marginTop = rect.top+'px';
        img[0].style.marginLeft = rect.left+'px';
      }
      var reader = new FileReader();
      reader.onload = function(evt){img[0].src = evt.target.result;}
      reader.readAsDataURL(file.files[0]);
  }
  else //兼容IE
  {
    var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="")';
    file.select();
    var src = document.selection.createRange().text; //运用IE滤镜获取数据;

    // div.innerHTML = '<img id=imghead>';
    // var img = document.getElementById('imghead');
    alert("ie");
    div[1].innerHTML = '<img id='+id+' />';
    var img = removeWhiteNode(div[1].childNodes);
    
    alert(img[0].className);

    img[0].filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
    var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img[0].offsetWidth, img[0].offsetHeight);
    status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;margin-left:"+rect.left+"px;"+sFilter+src+"\"'></div>";
  }
}
//图片居中显示
function clacImgZoomParam( maxWidth, maxHeight, width, height ) {
    var param = {top:0, left:0, width:width, height:height};
    param.width =  120;
	param.height = 126;
	param.left = 0;
	param.top = 0;
   /* if(width != 0 && height != 0){
    	if( width>maxWidth || height>maxHeight )
    	{
    		rateWidth = width / maxWidth;
    		rateHeight = height / maxHeight;
    		
    	}
    	
    }*/
    return param;
}
//移除空白字符
function removeWhiteNode(node) {
  for (var i = 0; i < node.length; i++) {
    if (node[i].nodeType === 3 && /^\s+$/.test(node[i].nodeValue)) {
      node[i].parentNode.removeChild(node[i]);
    }
  }
  return node;
}