<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>一见喜</title>
<style>
    .swiper-container {
        width: 100%;
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;
        
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    }
    .swiper-slide > img {
        width: 100%;
    }
   </style>
</head>
<body>
	<div id="wrap">
	  <div class="shopping-car mb80">
  		<!--无商品-->
  		<div class="no-shopping-car-show ta-center">
  			<div></div>
  			<a href="index.html" class="btn bc-c8161d" style="font-size: 2rem;">去逛逛</a>
  		</div>
	  	<!--有商品-->
	  	<div class="go-shopping">
	  		<a href="index.html" class="fl btn mr5 bc-c8161d">继续购买</a>
	  		<p class="fl go-shopping-title">购物车：立即结算，抢回还有货的商品</p>
	  	</div>
	  	<div class="shopping-car-show order-list clearfloat">
        <img src="images/shooping-car-img.jpg">
        <ul class="shopping-car-detail ph5">
          <li><a href="#" class="fc-000">LH-一见喜棉被系</a></li>
          <li>商品规格：S</li>
          <li><span class="fl">￥1888</span><span class="fr">x2</span></li>
        </ul>
        <div class="shopping-car-edit">
          <p>修改</p>
          <p class="iconfont order-delete" style="font-size: 2.5rem;">&#xe649;</p>
        </div>
      </div>
	  	<div class="shopping-car-show order-list clearfloat">
        <img src="images/shooping-car-img.jpg">
        <ul class="shopping-car-detail ph5">
          <li><a href="#" class="fc-000">LH-一见喜棉被系</a></li>
          <li>商品规格：S</li>
          <li><span class="fl">￥1888</span><span class="fr">x2</span></li>
        </ul>
        <div class="shopping-car-edit">
          <p>修改</p>
          <p class="iconfont order-delete" style="font-size: 2.5rem;">&#xe649;</p>
        </div>
      </div> 
	  </div>

	  <div class="tab-bar car-tab-bar">		
  		<a class="btn fr bc-c8161d">结算（4）</a>
  		<p class="fr mr10" style="font-size: 2rem;">合计：￥7552.00</p>
	  </div>
    </div>

	<script type="text/javascript">
    	$(document).ready(function() {
    		$('.order-delete').click(function() {
    			$(this).parents("div .shopping-car-show").remove(); 
    		}); 
    	});
    </script>
</body>
</html>