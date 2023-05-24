package com.kosta.dorang.dto;

public class SessionUser {
	private int user_code;
	private String user_id;
	private String access_token;
	private String user_age_range;
	private String user_nickname;
	private char user_gender;
	private String user_status;
	private String user_pic;
	private String user_choosen_tag;
	
	public void setUser_code() {
		this.user_code=user_code;
	}
	
	public int getUser_code() {
		return user_code;
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public String getUser_age_range() {
		return user_age_range;
	}
	public void setUser_age_range(String user_age_range) {
		this.user_age_range = user_age_range;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public char getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(char user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_status() {
		return user_status;
	}
	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}
	public String getUser_pic() {
		return user_pic;
	}
	public void setUser_pic(String user_pic) {
		this.user_pic = user_pic;
	}
	public String getUser_choosen_tag() {
		return user_choosen_tag;
	}
	public void setUser_choosen_tag(String user_choosen_tag) {
		this.user_choosen_tag = user_choosen_tag;
	}
}
