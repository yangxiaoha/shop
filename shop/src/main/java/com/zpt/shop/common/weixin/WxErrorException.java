package com.zpt.shop.common.weixin;

public class WxErrorException  extends Exception {
	private static final long serialVersionUID = -6357149550353160810L;

	private WxError error;

	public WxErrorException(WxError error) {
		super(error.toString());
		this.error = error;
	}

	public WxError getError() {
		return error;
	}
}
