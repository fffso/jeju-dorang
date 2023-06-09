<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>  
	<link rel="stylesheet" type="text/css"  href="<c:url value="/resources/css/mateList.css"/>">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script src="<c:url value="/resources/js/mateList.js"/>"></script>
<title>동행 글 목록</title>
<script type="text/javascript">

$(document).ready(function(){
	

	sortMateList($("#sortBy").val(),${pm.cri.page});    
	
    //버튼 정렬 
    $(".sort-btn-group button").on("click",function(e){
    
    	e.preventDefault(); 
    	 $(".sort-btn-group button").removeClass("active");
    	 $(this).addClass("active");
    	 sortBy = $(this).data("btn");
    	 $("#sortBy").val(sortBy);
    	 var page = $("#page").val();
    	 
    	 if (sortBy === "sortByCount") { 
 	        page = ${pm.startPage};
 	        $("#page").val(page);
 	    }
    	 
    	 sortMateList(sortBy, page);

    });
    
 
 
  });
    var contextPath = "${pageContext.request.contextPath}";
    
    function sortMateList(sortBy,page) {

	    $.ajax({
		    url: "${contextPath}/mate/listSort",
		    method: "GET",
		    data:{
		        sortBy: sortBy,
		        page: page
		      },
		    dataType : "json",
		    success:function(data) {
		        displayMateList(data.mateList,data.userNickNames);   
		        var pm = data.pm;
		        var endPage = pm.endPage;
		        var startPage = pm.startPage;
		        var currentPage = pm.cri.page;
		        var hasNext = pm.next;
		        updatePagination(endPage, sortBy, startPage, currentPage, hasNext); 
		        $(".data-btn").removeClass("active");
	            $("[data-btn='" + sortBy + "']").addClass("active")
		      },
		    error: function() {
		      console.log("데이터 요청 실패");
		    }
		  }); 
   }//sortMateList
   
    function displayMateList(data,userNickNames) {
    
     $("#viewContent").empty();
     var itemHtml = ""; 
	   $.each(data, function(index,mt) {
		    var createdAt = new Date(mt.createdAt);  
	    	var formattedDate = createdAt.toLocaleDateString();
		    
		   itemHtml +=  "<div class='col '>"
		   itemHtml +=  "<a href='javascript:goContent("+mt.mate_code+")' class='card-link'>"
		   itemHtml +=  "<div class='mate-status'>"
		   itemHtml +=  "<p class='status_txt'>"+ mt.status + "</p>"
		   itemHtml +=  "<p class='count_txt'><span>조회수</span><span id='cnt"+mt.mate_code+"'>"+mt.count+"</span></p>"
		   itemHtml +=  "</div>"
		   itemHtml +=  "<div class='card h-100 shadow p-2'>"
		   itemHtml +=  "<h5 class='card-title'>"+mt.title+"</h5>"
		   itemHtml += "<p class='nick_name'>" + userNickNames[index] + "</p>";
		   itemHtml +=  "<p class='createAt'>작성일&nbsp;"+formattedDate +"</p>"  	
		   itemHtml +=  "<div class='card-top-tags justify-content-md-between mb-3'>"	
		   itemHtml +=  "<label class='card-tags'>"+mt.type+"</label>"
		   itemHtml +=  "<label class='card-tags'>"+mt.direction+"</label>"
		   itemHtml +=  "<label class='card-tags'>"+mt.number+"</label>"
		   itemHtml +=  "<label class='card-tags'>"+mt.gender+"</label>"
		   itemHtml +=  "</div>" 
		   itemHtml += "<div class='img_box'>"
		   itemHtml += "<img src='" + contextPath + "/resources/upload/mate/" + mt.image + "' class='card-img-top' alt='제주도모집이미지'>";
		   itemHtml +=  "</div>" 
		   itemHtml += "<div class='tags_strings' id='tags_strings'>'"+mt.tags +"</div>"
		   itemHtml += "<div class='card-bottom-tags mb-3' id='tags_list'>"
		   itemHtml += "<label class='card-tags'></label>"
		   itemHtml += "<label class='card-tags'></label>"
		   itemHtml += "<label class='card-tags'></label>"
		   itemHtml += "</div>"
		   itemHtml += "<div class='card-footer'>"
		   itemHtml += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill=''#3CB728' class='bi bi-calendar2-heart' viewBox='0 0 16 16'>"
		   itemHtml += "<path fill-rule='evenodd' d='M4 .5a.5.5 0 0 0-1 0V1H2a2 2 0 0 0-2 2v11a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-1V.5a.5.5 0 0 0-1 0V1H4V.5ZM1 3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v11a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V3Zm2 .5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h10a.5.5 0 0 0 .5-.5V4a.5.5 0 0 0-.5-.5H3Zm5 4.493c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z'/>"
		   itemHtml += "</svg>"
		   itemHtml +="<small class='daterange'>여행기간&nbsp;"+mt.daterange+"</small>"
		   itemHtml += "</div>"
		   itemHtml += "</div>"
		   itemHtml += "</a>"
		   itemHtml += "</div>"
	
	   }); 
		$("#viewContent").append(itemHtml);
		
  

   }//displayMateList
   
   
    function updatePagination(endPage, sortBy, startPage, currentPage, hasNext) {
		//console.log("sortBy" +sortBy);
		//console.log("currentPage" +currentPage);
		
		
		 var pageButtonsContainer = $(".pagination");

		   
		   var pageButtonsHtml = "";
		

		   // 이전 페이지 버튼
		   if (startPage > 1) {
		     pageButtonsHtml += "<li class='page-item paginate_button'>";
		     pageButtonsHtml += "<a  class='page-link' id='" + (startPage - 1) + "' aria-label='Previous'>";
		     pageButtonsHtml += "<span aria-hidden='true'>&laquo;</span>";
		     pageButtonsHtml += "</a>";
		    pageButtonsHtml += "</li>";
		   }
		   // 페이지 번호 버튼
		   for (var pageNum = startPage; pageNum <= endPage; pageNum++) {
			   
		     if (pageNum == currentPage) {
		      pageButtonsHtml += "<li class='page-item active paginate_button'>";
		     } else {
		       pageButtonsHtml += "<li class='page-item paginate_button'>";
		     }
		     pageButtonsHtml += "<a  class='page-link' id='"+pageNum+"'>" + pageNum + "</a>";
		     pageButtonsHtml += "</li>";
		   }

		   //다음 페이지 버튼
		   if (hasNext) {
		     pageButtonsHtml += "<li class='page-item paginate_button'>";
		     pageButtonsHtml += "<a  class='page-link' id='" + (endPage + 1) + "' aria-label='Next' >";
		     pageButtonsHtml += "<span aria-hidden='true'>&raquo;</span>";
		     pageButtonsHtml += "</a>";
		     pageButtonsHtml += "</li>";
		   }

		   // 페이지 버튼을 갱신
		   pageButtonsContainer.html(pageButtonsHtml);
		
		   $(".paginate_button a").on("click",function(e){
		    	e.preventDefault(); 
		    	
		    	
		    	var page = $(this).attr("id");
		        var sortBy = $("#sortBy").val();

		        $.ajax({
				    url: "${contextPath}/mate/listSort",
				    method: "GET",
				    data:{
				        sortBy: sortBy,
				        page: page,
				      },
				    dataType : "json",
				    success:function(data) {
				    	displayMateList(data.mateList,data.userNickNames);
				        var pm = data.pm;
				        var endPage = pm.endPage;
				        var startPage = pm.startPage;
				        var currentPage = pm.cri.page;
				        var hasNext = pm.next;

				        updatePagination(endPage, sortBy, startPage, currentPage, hasNext); 
				        $("#page").val(currentPage);
				        $(".data-btn").removeClass("active");
			            $("[data-btn='" + sortBy + "']").addClass("active")
				      },
				    error: function() {
				      console.log("데이터 요청 실패");
				    }
				  }); 
		    	
		   
		    	
		    });
		   
	}
   
    
    
     function goContent(mate_code) {
    	 var pageFrm = $("#pageFrm");
		 var tag="<input type='hidden' name='mate_code' value='"+mate_code+"'/>";
	     pageFrm.append(tag);
	     pageFrm.submit();
	     
	         $.ajax({
             url: "/dorang/mate/count/",
			 type : "POST",    			 
			 data: { mate_code: mate_code },
			 dataType : "json",
			 success : function(data){
				 $("#cnt"+mate_code).text(data.count);
			 },    			 
			 error : function(){ alert("error"); }
		 });
	     
	    
	}
     

    
    
</script>

</head>
<body>

<jsp:include page="../headerBoot.jsp"></jsp:include>
 <div class="container" >
 	<h3>동행 목록</h3>
 		<div class="container-top d-flex justify-content-between mb-5">
	 		<div class="sort-btn-group">
	 			<button type="button" class="btn" data-btn="sortByDate">날짜순</button>
                <button type="button" class="btn" data-btn="sortByCount">조회순</button>
	 		</div>
	 		<div class="insertMate-btn d-flex align-items-center">
		 		<span>
		 			<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#FB7A51" class="bi bi-arrow-right-circle" viewBox="0 0 16 16">
		  				<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
					</svg>
		 		</span>
		 	<c:choose>
		 		<c:when test="${sessionScope.user ne null}">
		 			<a href="${contextPath}/mate/writeform" class="insertMate-title hoverable">동행모집글쓰기</a>
		 		</c:when>
		 		<c:otherwise>
		 			<a href="javascript:void(0);" onclick="alert('로그인이 필요합니다'); window.location.href = 'https://kauth.kakao.com/oauth/authorize?client_id=a62a2c16a4182ec20a1185a3f707c2b1&redirect_uri=http://localhost:8080/dorang/user/kakaoCallback&response_type=code&prompt=login';" class="insertMate-title">동행모집글쓰기</a>
		 		</c:otherwise>
		 	</c:choose>
	 		</div>
 	    </div>
        <div class="container-content">
             <div class="row row-cols-1 row-cols-md-3 g-5" id="viewContent">
             <!-- 동행리스트 -->
		    </div>
        </div>
  <!-- 페이징 -->
    
	
 <div class="container d-flex justify-content-center">
  <div style="text-align: center;">
	 <nav aria-label="Page navigation example">
	  <ul class="pagination" >
	  </ul>
	</nav>
  </div>
  </div>
  <!-- end -->

  <form id="pageFrm" action="${contextPath}/mate/select"  method="get">
  		<input type="hidden" id="page" name="page" value="${pm.cri.page}" />
  		<input type="hidden" id="perPageNum"  name="perPageNum" value="${pm.cri.perPageNum}" />
 		<input type="hidden" id="sortBy" name="sortBy" value="${pm.cri.sortBy}" />
  </form>
 </div>
  <jsp:include page="../footerBoot.jsp"></jsp:include>
</body>
</html>