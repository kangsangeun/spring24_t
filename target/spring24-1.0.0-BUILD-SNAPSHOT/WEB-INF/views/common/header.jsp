<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<!------------------------------------------------------------------------------------------------------------------------------------[ HEAD ]-->
<head>
<!--────────────────────────────────────────────────────────────────────────────────────────────────────[ CSS ]-->
<!--──────────────────────────────────────────────────[↓ 부트스트랩/기본 ]-->
	<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="${contextPath}/resources/css/main.css" rel="stylesheet">
	
<!--──────────────────────────────────────────────────[↓ 구글 폰트 ]-->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@600&family=Orbit&display=swap" rel="stylesheet">
	
<!--──────────────────────────────────────────────────[↓ 홈/로고 모서리 라운딩 방지 ]-->
	<style>
		nav img {
			border-radius: 0px;
		}
	</style>
	
<!--────────────────────────────────────────────────────────────────────────────────────────────────────[ JavaScript ]-->
<!--──────────────────────────────────────────────────[↓ 부트스트랩 ]-->
   	<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	 integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	 crossorigin="anonymous"></script>

	<script type="text/javascript">
		var loopSearch = true;
		function keywordSearch() {
			if (loopSearch == false)
				return;
			var value = document.frmSearch.searchWord.value;
			$.ajax({
				type : "get",
				async : true,
				url : "${contextPath}/goods/keywordSearch.do",
				data : {
					keyword : value
				},
				success : function(data, textStatus) {
					var jsonInfo = JSON.parse(data);
					displayResult(jsonInfo);
				},
				error : function(data, textStatus) {
					alert("에러가 발생했습니다." + data);
				},
				complete : function(data, textStatus) {
					//alert("작업을 완료했습니다");	
				}
			}); //end ajax	
		}

		function displayResult(jsonInfo) {
			var count = jsonInfo.keyword.length;
			if (count > 0) {
				var html = '';
				for ( var i in jsonInfo.keyword) {
					html += "<a href=\"javascript:select('"
							+ jsonInfo.keyword[i] + "')\">"
							+ jsonInfo.keyword[i] + "</a><br/>";
				}
				var listView = document.getElementById("suggestList");
				listView.innerHTML = html;
				show('suggest');
			} else {
				hide('suggest');
			}
		}

		function select(selectedKeyword) {
			document.frmSearch.searchWord.value = selectedKeyword;
			loopSearch = false;
			hide('suggest');
		}

		function show(elementId) {
			var element = document.getElementById(elementId);
			if (element) {
				element.style.display = 'block';
			}
		}

		function hide(elementId) {
			var element = document.getElementById(elementId);
			if (element) {
				element.style.display = 'none';
			}
		}
	</script>
</head>


<!------------------------------------------------------------------------------------------------------------------------------------[ BODY ]-->
<body>
<!--────────────────────────────────────────────────────────────────────────────────────────────────────[ 최상단 메뉴 ]-->
	<div id="head_link">
		<ul>
			<c:choose>
				<c:when test="${isLogOn==true and not empty memberInfo }">
					<li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
					<li><a href="${contextPath}/mypage/myPageMain.do">마이페이지</a></li>
					<li><a href="${contextPath}/cart/myCartList.do">장바구니</a></li>
					<li><a href="#">주문배송</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${contextPath}/member/loginForm.do">로그인</a></li>
					<li><a href="${contextPath}/member/memberForm.do">회원가입</a></li>
				</c:otherwise>
			</c:choose>
<!-- 			<li><a href="#">고객센터</a></li> -->
			<c:if test="${isLogOn==true and memberInfo.member_id =='admin' }">
				<li class="no_line"><a
					href="${contextPath}/admin/goods/adminGoodsMain.do">관리자</a></li>
			</c:if>
		</ul>
	</div>

	<br>
	
<!--────────────────────────────────────────────────────────────────────────────────────────────────────[ 검색창 메뉴 ]-->
<!-- 스낵-snack 면류-noodle 유제품-dairy 음료-drink 도시락/샌드위치-sandwich 생활잡화-etc -->
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
    
<!--──────────────────────────────────────────────────[↓ 로고 ]-->
        <a class="navbar-brand" href="${contextPath}/main/main.do"><img src="${contextPath}/resources/image/Spring24_logo.png"></a>
      <!--   <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button> 햄버거인데 그냥 없앨 예정-->

<!--──────────────────────────────────────────────────[↓ 홈/카테고리/검색창 ]-->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            
<!--─────────────────────────[↓ 홈 버튼 ]-->
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="${contextPath}/main/main.do"><img src="${contextPath}/resources/image/Spring24_home.png"></a></li>
                
<!--─────────────────────────[↓ 카테고리 ]-->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">　카 테 고 리　</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="${contextPath}/goods/selectGoodsList.do?category=sandwich">도시락/샌드위치</a></li>
                        <li><a class="dropdown-item" href="${contextPath}//goods/selectGoodsList.do?category=noodle">라면/면류</a></li>
                        <li><a class="dropdown-item" href="${contextPath}/goods/selectGoodsList.do?category=dairy">유제품</a></li>
                        <li><a class="dropdown-item" href="${contextPath}/goods/selectGoodsList.do?category=drink">음료</a></li>
                        <li><a class="dropdown-item" href="${contextPath}/goods/selectGoodsList.do?category=snack">스낵</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${contextPath}/goods/selectGoodsList.do?category=etc">생활잡화</a></li>
                    </ul>
                </li>
            </ul>
            
<!--─────────────────────────[↓ 검색창 ]-->
            <form class="d-flex" role="search" name="frmSearch" action="${contextPath}/goods/searchGoods.do">
                <div class="input-group">
                    <input class="form-control" name="searchWord" type="search" onKeyUp="keywordSearch()" placeholder="검색할 내용을 입력해주세요" aria-label="Search">
                    <button class="btn btn-outline-success" name="search" type="submit">Search</button>
                </div>
            </form>       
       
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 custom-nav">     
				<c:choose>
					<c:when test="${header_menu=='admin_mode' }">
						<li class="nav-item"><a class="nav-link" href="${contextPath}/admin/goods/adminGoodsMain.do">상품관리</a></li>
       					<li class="nav-item"><a class="nav-link" href="${contextPath}/admin/order/adminOrderMain.do">주문관리</a></li>
						<li class="nav-item"><a class="nav-link" href="${contextPath}/admin/member/adminMemberMain.do">회원관리</a></li>
					</c:when>
					<c:when test="${header_menu=='my_page' }">
						<li class="nav-item"><a class="nav-link" href="${contextPath}/mypage/listMyOrderHistory.do">주문내역/배송조회</a></li>
						<li class="nav-item"><a class="nav-link" href="${contextPath}/mypage/myDetailInfo.do">회원정보관리</a></li>
					</c:when>
				</c:choose>	
       		</ul>
       		
        </div>
        
    </div>
</nav>

<%-- 	<div id="search">
		<form name="frmSearch" action="${contextPath}/goods/searchGoods.do">
			<input name="searchWord" class="main_input" type="text" onKeyUp="keywordSearch()">
			<input type="submit" name="search" class="btn1" value="검 색">
		</form>
	</div> --%>
	
<!-- 	<div id="suggest">
		<div id="suggestList"></div>
	</div> -->
</body>