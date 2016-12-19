package com.zpt.shop.weixin.utils;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Writer;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;   

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;
import com.zpt.shop.common.weixin.Article;
import com.zpt.shop.common.weixin.ArticleResMsg;
import com.zpt.shop.common.weixin.WeixinUserInfo;
import com.zpt.shop.main.entities.PayCallback;

import net.sf.json.xml.XMLSerializer;

public class WeixinUtils {

	public static final String REQ_MSG_TYPE_EVENT = "event";
    public static final String EVENT_TYPE_SCAN = "scan";//事件类型：scan(用户已关注时的扫描带参数二维码)
	public static final String EVENT_TYPE_CLICK = "CLICK";//事件类型：CLICK(自定义菜单)
	public static final String EVENT_TYPE_SUBSCRIBE = "subscribe";//事件类型：subscribe(订阅)
	public static final String EVENT_TYPE_UNSUBSCRIBE = "unsubscribe";//事件类型：unsubscribe(取消订阅)

	@Autowired
	private static WeixinUserInfo userInfo;

	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		System.setProperty("jsse.enableSNIExtension", "false");
		try {
			TrustManager[] tm = { new X509TrustManager() {
				@Override
				public void checkClientTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
				}

				@Override
				public void checkServerTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
				}

				@Override
				public X509Certificate[] getAcceptedIssuers() {
					return null;
				}
			} };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSONObject.parseObject(buffer.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObject;
	}

	/**
	 * 获取微信的accesstoken
	 * @param appid
	 * @param secret
	 * @return
	 */
	public static String getAccessToken(String appid, String secret) {
		String accessToken = null;
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appid
				+ "&secret=" + secret;
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
		if (null != jsonObject) {
			try {
				accessToken = jsonObject.getString("access_token");
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		return accessToken;
	}
	
	/**
	 * 通过code获取access_token,openid 
	 * https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
	 * @param appid
	 * @param secret
	 * @return
	 * 获取返回的access_token
	 * 获取返回的openid
	 */
	public static String getAuthAccessToken(String appId, String secret, String code) {
		Map<String,Object> map = new HashMap<String, Object>();
		String openid = null;
		String requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appId
		+ "&secret=" + secret + "&code=" + code
		+ "&grant_type=authorization_code";
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
		if (null != jsonObject) {
			try {
				openid = jsonObject.getString("openid");
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		return openid;
	}

	/**
	 * 通过access_token,openid获取用户信息
	 * https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN
	 * @param access_token
	 * @param openid
	 * @return
	 */
	public static WeixinUserInfo getWeixinUserInfo(String openid, String accessToken) {
		String requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken
		+ "&openid=" + openid
		+ "&lang=zh_CN";
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
		System.out.println(jsonObject + "jsonObject");
		if (null != jsonObject) {
			try {
				userInfo.setOpenId(jsonObject.getString("openid"));
				userInfo.setNickname(jsonObject.getString("nickname"));
				userInfo.setSex(jsonObject.getInteger("sex"));
				userInfo.setProvince(jsonObject.getString("province"));
				userInfo.setCity(jsonObject.getString("city"));
				userInfo.setCountry(jsonObject.getString("country"));
				userInfo.setHeadImgUrl(jsonObject.getString("headimgurl"));
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		return userInfo;
	}
	
	/**
	 * 批量获取用户信息
	 * https://api.weixin.qq.com/cgi-bin/user/info/batchget?access_token=ACCESS_TOKEN
	 * @param openidList 
	 * @param access_token
	 * @return
	 */
	public static JSONObject getBatchWeixinUserInfo(String openidList, String accessToken) {
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/user/info/batchget?access_token=" + accessToken;
		JSONObject jsonObject = httpRequest(requestUrl, "POST", openidList);
		if (null != jsonObject) {
			try {

			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		return jsonObject;
	}
	
	/**
	 * 获取预支付id
	 * https://api.mch.weixin.qq.com/pay/unifiedorder
	 */
	public static String getPayNo(String content) {
		String requestUrl = "https://api.mch.weixin.qq.com/pay/unifiedorder";
		JSONObject result = httpRequest(requestUrl, "POST", content);
		String jsonObject = xmltoJson(result.toString());//返回的的结果 
		System.out.println(jsonObject + "jsonObject");
		return jsonObject;
	}
	
	public static String xmltoJson(String xml) {  
        XMLSerializer xmlSerializer = new XMLSerializer();  
        return xmlSerializer.read(xml).toString();  
    } 

	/*
	 * public static Map<String, String> parseXml2(HttpServletRequest request)
	 * throws Exception { Map<String, String> map = new HashMap<String,
	 * String>(); InputStream inputStream = request.getInputStream(); SAXReader
	 * reader = new SAXReader(); Document document = reader.read(inputStream);
	 * Element root = document.getRootElement(); List<Element> elementList =
	 * root.elements(); for (Element e : elementList) map.put(e.getName(),
	 * e.getText()); inputStream.close(); inputStream = null; return map; }
	 * 
	 * public static Map<String, String> parseXml(HttpServletRequest request)
	 * throws Exception { Map<String, String> map = new HashMap<String,
	 * String>(); StringBuilder buffer = new StringBuilder(); BufferedReader
	 * reader = null; try { reader = new BufferedReader(new
	 * InputStreamReader(request.getInputStream())); String line = null; while
	 * ((line = reader.readLine()) != null) { buffer.append(line); } } catch
	 * (Exception e) { e.printStackTrace(); } finally { if (null != reader) {
	 * try { reader.close(); } catch (IOException e) { e.printStackTrace(); } }
	 * } Document document = null; try { document =
	 * DocumentHelper.parseText(buffer.toString()); } catch (Exception e) {
	 * e.printStackTrace(); } if (null == document) { return null; } Element
	 * root = document.getRootElement(); List<Element> elementList =
	 * root.elements(); for (Element e : elementList) map.put(e.getName(),
	 * e.getText()); return map; }
	 */
	private static XStream xstream = new XStream(new XppDriver() {
		public HierarchicalStreamWriter createWriter(Writer out) {
			return new PrettyPrintWriter(out) {
				boolean cdata = true;

				public void startNode(String name, Class clazz) {
					super.startNode(name, clazz);
				}

				protected void writeText(QuickWriter writer, String text) {
					if (cdata) {
						writer.write("<![CDATA[");
						writer.write(text);
						writer.write("]]>");
					} else {
						writer.write(text);
					}
				}
			};
		}
	});

	public static String articleMessageToXml(ArticleResMsg articleResMsg) {
		xstream.alias("xml", articleResMsg.getClass());
		xstream.alias("item", new Article().getClass());
		return xstream.toXML(articleResMsg);
	}
	
	public static String payCallbackToXml(PayCallback payCallback) {
		xstream.alias("xml", payCallback.getClass());
		xstream.alias("item", new PayCallback().getClass());
		return xstream.toXML(payCallback);
	}

	// 请求方法
	public enum RequestMethodEnum {
		GET, POST
	}

	public static String httpRequest(String requestUrl, RequestMethodEnum requestMethod, String outputStr) {
		StringBuilder sb = new StringBuilder();
		System.setProperty("jsse.enableSNIExtension", "false");
		try {
			TrustManager[] tm = { new X509TrustManager() {
				@Override
				public void checkClientTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
				}

				@Override
				public void checkServerTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
				}

				@Override
				public X509Certificate[] getAcceptedIssuers() {
					return null;
				}
			} };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);
			httpUrlConn.setConnectTimeout(10000);
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			httpUrlConn.setRequestMethod(requestMethod.toString());

			if (requestMethod.equals(RequestMethodEnum.GET))
				httpUrlConn.connect();

			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				sb.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			return sb.toString();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 模拟form表单的形式 ，上传文件以输出流的形式把文件写入到url中，然后用输入流来获取url的响应
	 * 
	 * @param url
	 *            请求地址form表单url地址
	 * @param filePath
	 *            文件在服务器保存路径
	 * @return String url的响应信息返回值
	 * @throws IOException
	 */
	public static String sendFile(String url, File file) {
		String result = null;
		BufferedReader reader = null;

		System.setProperty("jsse.enableSNIExtension", "false");
		try {
			TrustManager[] tm = { new X509TrustManager() {
				@Override
				public void checkClientTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
				}

				@Override
				public void checkServerTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
				}

				@Override
				public X509Certificate[] getAcceptedIssuers() {
					return null;
				}
			} };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			/**
			 * 第一部分
			 */
			URL urlObj = new URL(url);
			// 连接
			HttpsURLConnection con = (HttpsURLConnection) urlObj.openConnection();

			/**
			 * 设置关键值
			 */
			con.setRequestMethod("POST"); // 以Post方式提交表单，默认get方式
		
			con.setDoInput(true);
			con.setDoOutput(true);
			con.setUseCaches(false); // post方式不能使用缓存
			con.setSSLSocketFactory(ssf);

			// 设置请求头信息
			con.setRequestProperty("Connection", "Keep-Alive");
			con.setRequestProperty("Charset", "UTF-8");

			// 设置边界
			String BOUNDARY = "----------" + System.currentTimeMillis();
			con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

			// 请求正文信息

			// 第一部分：
			StringBuilder sb = new StringBuilder();
			sb.append("--"); // 必须多两道线
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("Content-Disposition: form-data;name=\"media\";filename=\"" + file.getName() + "\"\r\n");
			sb.append("Content-Type:application/octet-stream\r\n\r\n");

			byte[] head = sb.toString().getBytes("utf-8");

			// 获得输出流
			OutputStream out = new DataOutputStream(con.getOutputStream());
			// 输出表头
			out.write(head);

			// 文件正文部分
			// 把文件已流文件的方式 推入到url中
			DataInputStream in = new DataInputStream(new FileInputStream(file));
			int bytes = 0;
			byte[] bufferOut = new byte[1024];
			while ((bytes = in.read(bufferOut)) != -1) {
				out.write(bufferOut, 0, bytes);
			}
			in.close();
			// 结尾部分
			byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
			out.write(foot);
			out.flush();
			out.close();

			StringBuffer buffer = new StringBuffer();

			// 定义BufferedReader输入流来读取URL的响应
			reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line = null;
			while ((line = reader.readLine()) != null) {
				// System.out.println(line);
				buffer.append(line);
			}
			if (result == null) {
				result = buffer.toString();
			}
			return result;
		} catch (Exception e) {
			System.out.println("发送POST请求出现异常！" + e);
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		}
	}

	public static Map<String, String> parseXml2(HttpServletRequest request) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		InputStream inputStream = request.getInputStream();
		SAXReader reader = new SAXReader();
		Document document = reader.read(inputStream);
		Element root = document.getRootElement();
		List<Element> elementList = root.elements();
		for (Element e : elementList)
			map.put(e.getName(), e.getText());
		inputStream.close();
		inputStream = null;
		return map;
	}

	public static Map<String, String> parseXml(HttpServletRequest request) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		StringBuilder buffer = new StringBuilder();
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
			String line = null;
			while ((line = reader.readLine()) != null) {
				buffer.append(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != reader) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		Document document = null;
		try {
			document = DocumentHelper.parseText(buffer.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (null == document) {
			return null;
		}
		Element root = document.getRootElement();
		List<Element> elementList = root.elements();
		for (Element e : elementList)
			map.put(e.getName(), e.getText());
		return map;
	}
}
