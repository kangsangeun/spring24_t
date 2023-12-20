<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
	request.setCharacterEncoding("UTF-8");
%>

<!--__________________________________________________________________________________________[↓ CSS/JavaScript 링크 ]-->
<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${contextPath}/resources/css/main.css" rel="stylesheet">
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
 integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
 crossorigin="anonymous"></script>

<!--__________________________________________________________________________________________[↓ 폰트 링크 ]-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@600&family=Orbit&display=swap" rel="stylesheet">

<div id="ad_main_banner">
	<ul class="bjqs">
		<li><img width="1750" height="500"
			src="${contextPath}/resources/image/Spring24_banner01.png"></li>
		<li><img width="1750" height="500"
			src="${contextPath}/resources/image/Spring24_banner02.png"></li>
		<li><img width="1750" height="500"
			src="${contextPath}/resources/image/Spring24_banner03.png"></li>
	</ul>
</div>

<div class="main_book">
	<c:set var="goods_count" value="0" />
	<h3>베스트셀러</h3>
	<c:forEach var="item" items="${goodsList[category]}">
		<c:set var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a
				href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<img class="link" src="${contextPath}/resources/image/1px.gif">
			</a> <img width="121" height="154"
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">

			<div class="title">${item.goods_title }</div>
			<div class="price">
				<fmt:formatNumber value="${item.goods_price}" type="number"
					var="goods_price" />
				${goods_price}원
			</div>
		</div>
		<c:if test="${goods_count==15   }">
			<div class="book">
				<font size=20> <a href="#">more</a></font>
			</div>
		</c:if>
	</c:forEach>
</div>
<div class="clear"></div>

