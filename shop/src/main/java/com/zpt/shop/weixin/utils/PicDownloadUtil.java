package com.zpt.shop.weixin.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.alibaba.fastjson.JSONObject;



public class PicDownloadUtil {
	  /** 
     *  
     * 根据文件id下载文件 
     *  
     *  
     *  
     * @param mediaId 
     *  
     *            媒体id 
     *  
     * @throws Exception 
     */  
  
    public static InputStream getInputStream(String accessToken, String mediaId) {  
        InputStream is = null;  
        String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="  
                + accessToken + "&media_id=" + mediaId;  
        System.out.println(url+"------------------------------------------99999");
        try {  
            URL urlGet = new URL(url);  
            HttpURLConnection http = (HttpURLConnection) urlGet  
                    .openConnection();  
            http.setRequestMethod("GET"); // 必须是get方式请求  
            http.setRequestProperty("Content-Type",  
                    "application/x-www-form-urlencoded");  
            http.setDoOutput(true);  
            http.setDoInput(true);  
            System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒  
            System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒  
            http.connect();  
            // 获取文件转化为byte流  
            is = http.getInputStream();  
  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return is;  
  
    }  
  
    /** 
     *  
     * 获取下载图片信息（jpg） 
     *  
     *  
     *  
     * @param mediaId 
     *  
     *            文件的id 
     *  
     * @throws Exception 
     */  
  
    public static void saveImageToDisk(String accessToken, String mediaId, String picName, String picPath)  
            throws Exception {  
        InputStream inputStream = getInputStream(accessToken, mediaId);  
        byte[] data = new byte[10240];  
        int len = 0;  
        FileOutputStream fileOutputStream = null;  
        try {  
            fileOutputStream = new FileOutputStream(picPath+picName);  
            while ((len = inputStream.read(data)) != -1) {  
                fileOutputStream.write(data, 0, len);  
            }  
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (inputStream != null) {  
                try {  
                    inputStream.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
            if (fileOutputStream != null) {  
                try {  
                    fileOutputStream.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
    }  
  
    /** 
     * 图片下载 
     *  
     * @param accessToken 
     * @param mediaId 
     */  
    public static void getPic(String accessToken, String mediaId) {  
        String requestUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID";  
        requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace(  
                "MEDIA_ID", mediaId);  
        System.out.println(requestUrl+"-------------------requsturl:");
        JSONObject jsonObject = WeixinUtils.httpRequest(requestUrl, "GET", null);  
        System.out.println(jsonObject);  
    }  
  
}
