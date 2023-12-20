<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<div class="clear"></div>
<ul>
	<li><a href="#">회사소개</a></li>
	<li><a href="#">이용약관</a></li>
	<li><a href="#">개인정보취급방침</a></li>
	<li><a href="#">가맹점문의</a></li>
	<li><a href="#">광고센터</a></li>
	<li><a href="#">고객센터</a></li>
<%--	<li class="no_line"><a href="#">찾아오시는길</a></li>--%>
</ul>

<div class="clear"></div>
<div>
<a href="${contextPath}/main/main.do"><img width="160px"  height="40px" alt="Spring24" src="${contextPath}/resources/image/Spring24_logo.png" /></a>
<div style="padding-left:10px">
	 ㈜Spring24 <br>
	 대표이사: 김스프링 <br>
	 주소 : 우편번호 03133 서울시 종로구 종로3 <br>  
	 사업자등록번호 : 102-81-11111 <br>
	 서울특별시 통신판매업신고번호 : 제 666호 ▶사업자정보확인   개인정보보호최고책임자 : 김자바 privacy@google.co.kr <br>
	 대표전화 : 1544-1544 (발신자 부담전화)   팩스 : 0502-977-7777 (지역번호공통) <br>
	 COPYRIGHT(C) Spring24 ALL RIGHTS RESERVED.
</div></div>

