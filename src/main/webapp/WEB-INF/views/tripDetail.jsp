<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주도랑 - 여행 상세</title>
<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&family=Jura&family=Lato&family=Nanum+Gothic:wght@400;700;800&family=Nanum+Myeongjo:wght@400;700;800&family=Noto+Serif+KR:wght@200;300;400;500;600;700;900&family=Rajdhani&display=swap" rel="stylesheet">
<!-- css -->
<link rel="stylesheet" href="<c:url value="/resources/css/travel.css"/>">
<style>
 .big {
 	width:50px;
 }
 
 .white {
 	color : white;
 }
 
 .white label {
 	font-weight:bold;
 	padding-right : 10px;
 }
 
 .travel-text-title {
 	font-size : 40px;
 	/* font-family: 'Noto Serif KR', serif; */
 	 font-family: 'Nanum Myeongjo', serif; 
 	font-weight :700;
 }
 
 .travel-text-address {
 	font-size : 16px;
 	font-weight :400;
 }
 
 .travel-detail-tag {
 	background : var(--color-main);
 }
 
 .travel-info-title{
 	color : var(--color-sub);
 }
 
  .travel-info-title span {
 	font-size : 18px;
 	font-weight :bold;
 }
 
 .title-icon {
 	width: 24px;
 }
 .detail-icon {
 	width: 20px;
 }
 
 .travel-info-title img {
 	line-height : 34px;
 }
 
 #bookmark-text {
 	color:white;
 }
</style>


<%-- <script src="<c:url value="/resources/js/jquery-3.3.1.js"/>"></script>
<script src="<c:url value="/resources/js/index.js"/>"></script> --%>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>

<!-- js -->
<script>

	let hashtag = "${place.getHashtag()}";
	const tags = hashtag.split(",");
	console.log(hashtag);
	
	let user_id = 1;
	let trip_id = "${place.getTrip_id()}";
	
	function bookmark(){
		//let isLike = false; //default false
		//ajax -> controller 호출 -> 조회 있음? 삭제하고 업데이트, 없음? 추가하고 업데이트 -> 리턴 boolean
		//option : null(찜한적 없음) = false, !null(이미찜함) = true;
		const heart = document.getElementById("heart");
		//console.log(heart);
		console.log(">>> org src");
		console.log(heart.src);
		$.ajax({
			type:"POST",
			url : "/travel/bookmark",
			data : {"user_id":user_id, "trip_id":trip_id},
			dataType : "text",
			success : function(response){
				console.log(response);
				if(response == "true"){
					console.log(">>> true src");
					heart.src = "<c:url value='/resources/img/icon-like.png'/>";
				} else {
					//$("#heart").attr("src", "<c:url value='/resources/img/icon-unlike.png'/>");
					heart.src ="<c:url value='/resources/img/icon-unlike.png'/>";
				}
			},
			error : function(request, status, err){
				console.log(err);
			}
		});
	}

	$(function(){
		
	})
</script>

</head>
<body>
<!-- header -->
<jsp:include page="headerBoot.jsp"></jsp:include>

<div class="travel-detail-container" style="background-image:url(${place.getImage() });">
	<div class="travel-detail-left">
		<div class="travel-detail-location">
			<img src="<c:url value="/resources/img/icon-location.png"/>" alt="location" class="travel-location-icon big"/>
			<div class="travel-text-title white"> ${place.getTitle() } </div>
			<div class="travel-text-address white"> ${place.getAddress() } </div>
		</div>
		
		<div class="travel-detail-tag white">
			<span class="hashtag">
			 #
			 ${fn:split(place.getHashtag(),',')[0] }
			</span>
			<span class="hashtag">
			 #
			 ${fn:split(place.getHashtag(),',')[1] }
			</span>
			<span class="hashtag">
			 #
			 ${fn:split(place.getHashtag(),',')[2] }
			</span>
			<span class="hashtag">
			 #
			 ${fn:split(place.getHashtag(),',')[3] }
			</span>
			<span class="hashtag">
			 #
			 ${fn:split(place.getHashtag(),',')[4] }
			</span>
		</div>
		
		<div class="travel-detail-intro white">
			${place.getIntroduction() }
		</div>
		
		<div class="travel-detail-info">
			<div class="travel-info-title">
				<img src="<c:url value="/resources/img/icon-info.png"/>" alt="icon-info" class="title-icon"/> 
				<span> INFORMATION </span>
			</div>
			
			<div class="travel-info-tel white">
				<label>
					<img src="<c:url value="/resources/img/icon-tel.png"/>" alt="icon-tel" class="detail-icon"/> 전화번호.
				</label>
				<span> ${place.getTel() } </span>
			</div>
			
			<div class="travel-info-loc white">
				<label>
					<img src="<c:url value="/resources/img/icon-map.png"/>" alt="icon-map" class="detail-icon"/> 위도.
				</label>
				<span> ${place.getLatitude() } </span>
				<br> &nbsp; &nbsp; &nbsp;
				<label> 경도. </label>
				<span> ${place.getLongitude() } </span>
			</div>
			
			<div class="travel-info-etc white">
				<label>
					<img src="<c:url value="/resources/img/icon-check.png"/>" alt="icon-check" class="detail-icon"/> 기타.
				</label>
				<span> ${place.getInfo() } </span>
			</div>
		</div>
	</div>
	
	<div class="travel-detail-right">
		<div class="travel-detail-like" onclick="bookmark()" >
			<a id="bookmark-text">
				<c:choose>
					<c:when test="${isLike eq false }">
						<img src="<c:url value="/resources/img/icon-unlike.png"/>" alt="bookmark" id="heart"/>
					</c:when>
					<c:when test="${isLike eq true }">
						<img src="<c:url value="/resources/img/icon-like.png"/>" alt="bookmark" id="heart" />
					</c:when>
					<c:otherwise>
						<img src="<c:url value="/resources/img/icon-unlike.png"/>" alt="bookmark" id="heart"/>
					</c:otherwise>
				</c:choose>  
				<%-- <img src="<c:url value="/resources/img/icon-unlike.png"/>" alt="" id="heart"/> --%>
				LIKE
			</a>
		</div>
	</div>
</div>


<!-- footer -->
<jsp:include page="footerBoot.jsp"></jsp:include>
</body>
</html>