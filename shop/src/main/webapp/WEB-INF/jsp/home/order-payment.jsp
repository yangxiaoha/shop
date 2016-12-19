<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="decorator"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>一见喜</title>
<style>
</style>
</head>
<body style="background-color: #ECECF2">
    <div id="wrap">
        <div class="nav-bar write-order ta-center clearfloat">
          <p class="clearfloat">返回</p>填写订单
        </div>
    
        <c:forEach items="${orderMsg}" var="orderList">
          <div class="order-detail p10">      
            <div class="order-detail-addr">
              <h4 class="mb5"><span id="oldName">${orderList.name}</span>，<span id="oldPhone">${orderList.phone}</span></h4>
              <p class="fc-9fa0a0 fs-12"  id="oldAddress">${orderList.address}</p>
              <a href="javascript:void(0)" class="icon-item" id="getAddr" style="display: block; color: #231815;">
                <span class="iconfont">&#xe7f7;</span>
              </a>
            </div>
            <p class="order-detail-total p5 clearfloat">
              <span class="fl">商品合计：</span>
              <span class="fr font-price">￥${orderList.totalPrice}</span>
            </p>
            <div class="order-detail-goods p5">
              <c:forEach items="${orderList.orderDetail}" var="orderDetailList">
                <div class="order-show order-list clearfloat">
                  <img src="<%=basePath%>${orderDetailList.url}">
                  <ul class="shopping-car-detail pv5">
                    <li class="fc-595757 mb5">${orderDetailList.name}</li>
                    <li class="fc-9fa0a0 fs-1rem">已选 ${orderDetailList.val}</li>
                  </ul>
                  <div class="shopping-car-edit pv5">
                    <p class="font-price">￥${orderDetailList.price} x${orderDetailList.num}</p>
                  </div>
                </div>
              </c:forEach>
            </div>
            <form class="order-remarks" id="buyGoodsForm">
              <div>
                <label for="remarks" class="fc-9fa0a0">备注:</label>
                <textarea id="remarks" name="memo">${orderList.memo}</textarea>
                <input id="proviceFirstStageName" value="" />
                <input id="addressCitySecondStageName" value="" />
                <input id="addressCountiesThirdStageName" value="" />
                <input id="addressPostalCode" value="" />
                <input id="addressDetailInfo" value="" />       
                <input id="telNumber" value="" />
                <input id="username" value="" />
              </div>
            </form> 
            <form id="buyGoodsSubForm" action="../submitOrder" method="post" style="width: 0; height: 0;">
              <input type="hidden" id="postData" name="postData" />
              <input type="hidden" id="orderId" name="orderId" value="${orderId}" />
              <input type="hidden" id="state" name="state" value="1" />
            </form>                         
          </div>
    
          <div class="tab-bar order-tab-bar">   
            <p class="fl">实付款</p>           
            <p class="fr payment">付款</p>
          <p class="fr font-price">￥${orderList.totalPrice}</p>
          </div>
        </c:forEach>
    </div>
    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript">
        var appId = "${appId}";  
        var timeStamp = "${timeStamp}";  
        var nonceStr = "${nonceStr}";  
        var signature = "${signature}"; 
        var prepay_id = "${prepay_id}";
        var paySign = "${paySign}";
        var addrSign = "${addrSign}";
        wx.config({
            debug: true,
            appId: appId,
            timestamp: timeStamp,
            nonceStr: nonceStr,
            signature: signature,
            jsApiList: [
            'checkJsApi',
            'editAddress',
            'chooseWXPay',
            'getLatestAddress',
            'openCard',
            'getLocation'
            ]
        });
        $(document).ready(function() {
            $(".payment").click(function() {
                var queryArray = $("#buyGoodsForm").serializeArray();
                var jsonString= '{';  
                for (var i = 0; i < queryArray.length; i++) {  
                    jsonString+= JSON.stringify(queryArray[i].name) + ':' + JSON.stringify(queryArray[i].value) + ',';  
                }  
                jsonString= jsonString.substring(0, (jsonString.length - 1));  
                jsonString+= '}'; 
                $("#postData").val(jsonString);
                onBridgeReady();
            });
            $("#getAddr").click(function() {
                getAddr();
            });
        });
        //获取地址
        function getAddr() {
            WeixinJSBridge.invoke(
                'editAddress', {
                   "appId":appId, //公众号名称，由商户传入     
                   "scope":"jsapi_address", 
                   "signType":"sha1", //微信签名方式   
                   "addrSign":addrSign,//微信签名 
                   "timeStamp":timeStamp, //时间戳，自1970年以来的秒数  
                   "nonceStr":nonceStr, //随机串     
                },
                function(res){     
                    if(res != null && res != ""){  
                        alert("获取收货地址"); 
                        alert(res);
                        $("#proviceFirstStageName").val(res.proviceFirstStageName);
                        $("#addressCitySecondStageName").val(res.addressCitySecondStageName);
                        $("#addressCountiesThirdStageName").val(res.addressCountiesThirdStageName);
                        $("#addressPostalCode").val(res.addressPostalCode);
                        $("#addressDetailInfo").val(res.addressDetailInfo);                 
                        $("#telNumber").val(res.telNumber);
                        $("#username").val(res.username);                   
                        $("#oldName").text(res.username);
                        $("#oldPhone").text(res.telNumber);
                        $("#oldAddress").text();
                    }else {
                        alert("取消编辑收货地址"); 
                    }
                }
            ); 
        }
        //付款
        function onBridgeReady() {
            WeixinJSBridge.invoke(
                'getBrandWCPayRequest', {
                   "appId":appId, //公众号名称，由商户传入     
                   "timeStamp":timeStamp, //时间戳，自1970年以来的秒数     
                   "nonceStr":nonceStr, //随机串     
                   "package":"prepay_id="+prepay_id,     
                   "signType":"MD5", //微信签名方式   
                   "paySign":paySign //微信签名 
                },
                function(res){     
                    if(res.err_msg == "get_brand_wcpay_request:ok"){  
                        alert("微信支付成功"); 
                        //$("#buyGoodsSubForm").submit();
                    }else if(res.err_msg == "get_brand_wcpay_request:cancel"){  
                        alert("用户取消支付"); 
                        //$("#buyGoodsSubForm").submit();
                    }else{  
                        alert("支付失败"); 
                        //$("#buyGoodsSubForm").submit();
                    } 
                }
            ); 
         }
         if (typeof WeixinJSBridge == "undefined"){
            if( document.addEventListener ){
                document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
            }else if (document.attachEvent){
                document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
                document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
            }
         }else{
            onBridgeReady();
         }
    </script>
</body>
</html>