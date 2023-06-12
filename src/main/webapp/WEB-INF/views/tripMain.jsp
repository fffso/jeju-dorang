<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주도랑 - 여행</title>
<%-- <link rel="stylesheet" href="<c:url value="resources/css/index.css"/>">

<script src="<c:url value="/resources/js/index.js"/>"></script> --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&family=Jura&family=Lato&family=Nanum+Gothic:wght@400;700;800&family=Nanum+Myeongjo:wght@400;700;800&family=Noto+Serif+KR:wght@200;300;400;500;600;700;900&family=Rajdhani&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/travel.css"/>">
<style>
	/* travel tab css */
	.travelTab {
	    height: 80px;
	    margin: 50px auto; 
	    margin-bottom : 10px;
	    display: flex;
	    align-items: center;
	    /* background-color: lightgray; */
	}
	
	/* travel card css */
	/*본문*/
	.travel-card-container {
	    /* border : solid 1px black; */
	    display : inline-block;
	    width : 285px;
	    height : 250px;
	    border-radius : 10px;
	    overflow : hidden;
	}
	
	.travel-card-top {
	    position : relative;
	    width : 100%;
	    height : 200px;
	    overflow : hidden;
	    border-radius : 10px;
	}
	
	.travel-card-img img{
	    width : 100%;
	    height : 200px;
	    display : inline-block;
	    filter: grayscale(0%);
	}
	
	.travel-card-img img:hover {
	    filter: grayscale(100%);
	    transform : scale(1.3);
	    transition: all ease-in-out 0.07s 0.07s;
	}
	
	.travel-card-location {
	    position : absolute;
	    width: 100%;
	    left : 5px;
	    top : 5px;
	}
	
	.small {
	    width:24px;
	}
	
	.travel-location-icon {
	    position: absolute;
	    top: 5px;
	    left: 5px;
	}
	
	.card-city-code {
	    font-size : 16pt;
	    font-weight : 700;
	    color:var(--color-main); 
	    text-shadow: -1px 0px white, 0px 1px white, 1px 0px white, 0px -1px white ;
	    display : inline-block;
	    position: absolute;
	    top: 20px;
	    left: 27px;
	}
	
	.card-region-code {
	    font-size : 10pt;
	    color : white;
	    position: absolute;
	    top: 5px;
	    left: 30px;
	}
	
	.travel-card-bottom {
		height:50px;
	}
	
	.travel-card-button {
		height:100%;
	    padding:20px;
	    line-height: 0;
	    background-color:transparent;
	    color: #3F3D3A;
	    border: none;
	    font-size:20px;
	}
	
	.travel-card-button:hover {
	    padding:20px;
	    line-height: 0;
	    background-color:var(--color-main);
	    color: white;
	    border: none;
	    border-radius: 10px;
	    transition: all ease-in-out 0.1s 0.1s;
	}
		
	
	/* search */
	.searchBar {
	    margin: 20px auto;
	    margin-top : 10px;
	    width: 1320px;
	    height: 80px;
	    /* background-color: black; */
	    position: relative;
	}
	
	.pagination-bar {
		width : 435px;
	}
	/* pagenation */
/* 	.pagination-box {
		background-color: black;
		margin: 0 auto;
		text-align:center;
	}
	
	.pagination-bar{
		margin: 0 auto;
		text-align:center;
	} */
</style>

<script>
	function movePage(div){
		//console.log(div);
		let param = div.id;
		let url = "${pageContext.request.contextPath}"+"/travel/list/id/" + param;
		//console.log(url);
		window.location.href=url;
	}
</script>
</head>

<body>
<!-- header -->
<jsp:include page="headerBoot.jsp"></jsp:include>

<div class="travelTab">
	<jsp:include page="/WEB-INF/views/tripTab.jsp"/>
</div>

<div class="searchBar">
	<jsp:include page="/WEB-INF/views/tripSearchBar.jsp"/>
</div>

<div class="container px-4">
	<div class="row row-cols-4 gx-5 gy-5">
		<!-- 카드 아이템 -->
		<c:forEach var="item" items="${list }">
			<div class="col" id=${item.trip_id } onclick="movePage(this)">
			<div class="travel-card-container ">
				<div class="travel-card-top">	
					<div class="travel-card-img">
						<img src=${item.thumbnail } alt=${item.title }/>
					</div> 
					
					<div class="travel-card-location"> 
						<img src="<c:url value="/resources/img/icon-location.png"/>" alt="location" class="travel-location-icon small"/>
						<div class="card-city-code"> ${item.city_code }</div>
						<div class="card-region-code"> ${item.region_code }</div>
					</div>
					<!-- <div class="travel-card-info">	
						<div class="travel-card-location"> 
							<img src="<c:url value="/resources/img/icon-location.png"/>" alt="location" class="travel-location-icon small"/>
							<div class="card-city-code"> ${item.city_code }</div>
							<div class="card-region-code"> ${item.region_code }</div>
						</div>
						<div class="travel-card-tag"> 해시태그 박스 </div>-->
					 
				</div>
				<div class="travel-card-bottom">
					<button type="button" class="travel-card-button col-12 mx-auto" value=${item.trip_id }>${item.title }</button>
				</div>
			</div>
			</div>
		</c:forEach>

	
	</div>
	
	<nav aria-label="Page navigation" class="pagination-box my-5">
		<ul class="pagination justify-content-center my-5 pagination-bar">
			<c:choose>
				<c:when test="${pageMaker.startPage-1 == 0}">
					<li class="page-item">
						<a class="page-link" href="<c:url value='/travel/list?page=1'/>" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</li>
				</c:when>
				
				<c:otherwise>
					<li class="page-item">
						<a class="page-link" href="<c:url value='/travel/list?page=${pageMaker.startPage-1 }'/>" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</li>
				</c:otherwise>
			</c:choose>
			
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				<li class="page-item">
					<a class="page-link" href="<c:url value='/travel/list?page=${pageNum }'/>">${pageNum }</a>
				</li>
			</c:forEach>	
			
			<c:choose>
				<c:when test="${pageMaker.next && pageMaker.endPage > 0 }">
					<li class="page-item">
						<a class="page-link" href="<c:url value='/travel/list?page=${pageMaker.endPage+1 }'/>" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
				</c:when>
				<c:otherwise>
				<li class="page-item">
					<a class="page-link" href="<c:url value='/travel/list?page=${pageMaker.endPage}'/>" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>
</div>

<!-- footer -->
<jsp:include page="footerBoot.jsp"></jsp:include>
</body>
</html>