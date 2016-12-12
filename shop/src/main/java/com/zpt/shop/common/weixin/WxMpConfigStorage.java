package com.zpt.shop.common.weixin;

/**
 * 微信客户端配置存储
 *
 */
public class WxMpConfigStorage{

	protected volatile String appId;
	protected volatile String secret;
	protected volatile String partnerId;
	protected volatile String partnerKey;
	protected volatile String token;
	protected volatile String accessToken;
	protected volatile String aesKey;
	protected volatile long expiresTime;

	protected volatile String jsapiTicket;
	protected volatile long jsapiTicketExpiresTime;

	protected String website;
	
	protected String welcome;
	protected volatile String code;

	public String getAccessToken() {
		return this.accessToken;
	}

	public boolean isAccessTokenExpired() {
		return System.currentTimeMillis() > this.expiresTime;
	}

	public synchronized void updateAccessToken(WxAccessToken accessToken) {
		updateAccessToken(accessToken.getAccess_token(), accessToken.getExpires_in());
	}

	public synchronized void updateAccessToken(String accessToken, int expiresInSeconds) {
		this.accessToken = accessToken;
		this.expiresTime = System.currentTimeMillis() + (expiresInSeconds - 200) * 1000l;
	}

	/**
	 * 强制将access token过期掉
	 */
	public void expireAccessToken() {
		this.expiresTime = 0;
	}

	public String getJsapiTicket() {
		return jsapiTicket;
	}

	public void setJsapiTicket(String jsapiTicket) {
		this.jsapiTicket = jsapiTicket;
	}

	public long getJsapiTicketExpiresTime() {
		return jsapiTicketExpiresTime;
	}

	public void setJsapiTicketExpiresTime(long jsapiTicketExpiresTime) {
		this.jsapiTicketExpiresTime = jsapiTicketExpiresTime;
	}

	public boolean isJsapiTicketExpired() {
		return System.currentTimeMillis() > this.jsapiTicketExpiresTime;
	}

	public synchronized void updateJsapiTicket(String jsapiTicket, int expiresInSeconds) {
		this.jsapiTicket = jsapiTicket;
		// 预留200秒的时间
		this.jsapiTicketExpiresTime = System.currentTimeMillis() + (expiresInSeconds - 200) * 1000l;
	}

	public void expireJsapiTicket() {
		this.jsapiTicketExpiresTime = 0;
	}

	public String getAppId() {
		return this.appId;
	}

	public String getSecret() {
		return this.secret;
	}

	public String getToken() {
		return this.token;
	}

	public long getExpiresTime() {
		return this.expiresTime;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getAesKey() {
		return aesKey;
	}

	public void setAesKey(String aesKey) {
		this.aesKey = aesKey;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public void setExpiresTime(long expiresTime) {
		this.expiresTime = expiresTime;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	@Override
	public String toString() {
		return "WxMpInMemoryConfigStorage{" +
				"appId='" + appId + '\'' +
				", secret='" + secret + '\'' +
				", token='" + token + '\'' +
				", website='" + website + '\'' +
				", partnerId='" + partnerId + '\'' +
				", partnerKey='" + partnerKey + '\'' +
				", accessToken='" + accessToken + '\'' +
				", aesKey='" + aesKey + '\'' +
				", expiresTime=" + expiresTime +
				'}';
	}

	public String getPartnerId() {
		return partnerId;
	}

	public void setPartnerId(String partnerId) {
		this.partnerId = partnerId;
	}

	public String getPartnerKey() {
		return partnerKey;
	}

	public void setPartnerKey(String partnerKey) {
		this.partnerKey = partnerKey;
	}

	public String getWelcome() {
		return welcome;
	}

	public void setWelcome(String welcome) {
		this.welcome = welcome;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}

