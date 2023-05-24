package com.kosta.dorang.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.mysql.cj.xdevapi.JsonParser;

public class UserService implements UserServiceI {

	@Override // 액세스토큰 얻어오는 메서드
	public String getReturnAccessToken(String code) {
		String access_token="";
		String refresh_token="";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			//HttpURLConnection 설정 값 세팅
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			//buffer 스트림 객체 값 셋팅 후 요청
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=a62a2c16a4182ec20a1185a3f707c2b1");
			sb.append("&redirect_uri=http://localhost:8080/user/kakaoCallback");
			sb.append("&code="+code);
			bw.write(sb.toString());
			bw.flush();
			
			// RETURN 값 result 변수에 저장
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String br_line = "";
			String result = "";
			
			while ((br_line = (String)br.readLine()) != null) {
				result += br_line;
			} // result 값을 Json형식으로 데이터 넘겨줌 -> JsonParser클래스 (Gson라이브러리 적용 필요 -- pom.xml)
			
			JsonParser parser = new JsonParser();
			JsonElement element = (JsonElement) parser.parseDoc(result); // string을 다시 json타입으로 변환
			
			// 토큰 값 저장, 리턴
			access_token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_token = element.getAsJsonObject().get("refresh_token").getAsString();
			
			System.out.println(refresh_token+">.>>>>");
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_token;
	}

	@Override // 얻어낸 토큰 값을 이용해서(파라미터) 로그인한 아이디의 정보를 가져오는 메서드 
	// 연계문서: 가져온 토큰 값을 Header에 추가해주고 reqURL로 요청을 보내면 사용자의 정보를 리턴
	public Map<String, Object> getUserInfo(String access_token) {
		Map<String, Object> resultMap = new HashMap<>(); // 정보 키-값 저장할 map
		String reqURL = "https://kapi.kakao.com/v2/user/me"; // 아이디 정보 가져올 url
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			//요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_token);
			
			int responseCode = conn.getResponseCode();
			System.out.println("########responseConde::"+responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String br_line="";
			String result="";
			
			while ((br_line = br.readLine()) != null ) {
				result += br_line; 
			}
			System.out.println("@@@@@response:"+result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = (JsonElement) parser.parseDoc(result);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_id = (JsonObject) element.getAsJsonObject().get("kakao_account");
			
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
			resultMap.put("user_nickname", nickname);
			resultMap.put("user_pic", profile_image);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return resultMap;
		
	}

	@Override
	public String logout(String access_token) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
