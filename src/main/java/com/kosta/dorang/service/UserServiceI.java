package com.kosta.dorang.service;

import java.util.Map;

public interface UserServiceI {
	public String getReturnAccessToken(String code);
	public Map<String, Object> getUserInfo(String access_token);
	public String logout(String access_token);
}
