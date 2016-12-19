package com.zpt.shop.weixin.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

/**
 * 功能说明:
 * 
 * 微信统一下单接口,获取预支付标示prepay_id 
 *
 * Prepayid.java
 *
 * Original Author: 林敏,2016年12月16日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class PrepayUtil {
	
	/** 
     * 生成签名sign 
     * 第一步：非空参数值的参数按照参数名ASCII码从小到大排序，按照键值对的形式。生成字符串StringA 
     * stringA="appid=wxd930ea5d5a258f4f&body=test&device_info=1000&mch_id=10000100&nonce_str=ibuaiVcKdpRxkhJA"; 
     * 第二部：拼接API密钥，这里的秘钥是微信商户平台的秘钥，是自己设置的，不是公众号的秘钥 
     * stringSignTemp="stringA&key=192006250b4c09247ec02edce69f6a2d" 
     * 第三部：MD5加密 
     * sign=MD5(stringSignTemp).toUpperCase()="9A0A8659F005D6984697E2CA0A9CF3B7" 
     *  
     * @param map 不包含空字符串的map 
     * @return 
     */  
    public static String sign(Map<String, String> map, String key) {  
        //排序  
        String sort = sortParameters(map);  
        //拼接API秘钥  
        sort = sort+"&key="+key;   
        //MD5加密  
        String sign=MD5Util.MD5Encode(sort, "UTF-8").toUpperCase();  
        System.out.println("MD5加密:-----------"+sort);
        System.out.println("MD5加密:-----------"+sign);
        return sign;  
    }  
      
    /** 
     * 对参数列表进行排序，并拼接key=value&key=value形式 
     * @param map 
     * @return 
     */  
    private static String sortParameters(Map<String, String> map) {  
        Set<String> keys = map.keySet();  
        List<String> paramsBuf = new ArrayList<String>();  
        for (String k : keys) {  
            paramsBuf.add((k + "=" + getParamString(map, k)));  
        }  
        // 对参数排序  
        Collections.sort(paramsBuf);  
        String result="";  
        int count=paramsBuf.size();  
        for(int i=0;i<count;i++){  
            if(i<(count-1)){  
                result+=paramsBuf.get(i)+"&";  
            }else {  
                result+=paramsBuf.get(i);  
            }  
        }  
        System.out.println("MD5加密:-----------"+result);
        return result;  
    }  
    
    /** 
     * 返回key的值 
     * @param map 
     * @param key 
     * @return 
     */  
    private static String getParamString(Map map, String key) {  
        String buf = "";  
        if (map.get(key) instanceof String[]) {  
            buf = ((String[]) map.get(key))[0];  
        } else {  
            buf = (String) map.get(key);  
        }  
        return buf;  
    }  
    
    /** 
     * 字符串列表从大到小排序 
     * @param data 
     * @return 
     */  
    private static List<String> sort(List<String> data) {  
        Collections.sort(data, new Comparator<String>() {  
            public int compare(String obj1, String obj2) {  
                return obj1.compareTo(obj2);  
            }  
        });  
        return data;  
    }  
    
    /** 
     * Map转Xml 
     * @param arr 
     * @return 
     */  
    public static String MapToXml(Map<String, String> arr) {  
        String xml = "<xml>";  
        Iterator<Entry<String, String>> iter = arr.entrySet().iterator();  
        while (iter.hasNext()) {  
            Entry<String, String> entry = iter.next();  
            String key = entry.getKey();  
            String val = entry.getValue();  
            System.out.println("MD5加密:-----------"+val);
            if (IsNumeric(val)) {  
                xml += "<" + key + ">" + val + "</" + key + ">";  
            } else  
                xml += "<" + key + "><![CDATA[" + val + "]]></" + key + ">";  
        }  
        xml += "</xml>";  
        return xml;  
    }  
    
    private static boolean IsNumeric(String str) {  
        if (str.matches("\\d *")) {  
            return true;  
        } else {  
            return false;  
        }  
    } 
}