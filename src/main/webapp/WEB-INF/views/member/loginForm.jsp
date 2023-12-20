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

	<!--────────────────────────────────────────────────────────────────────────────────────────────────────[ JavaScript ]-->
	<!--──────────────────────────────────────────────────[↓ 부트스트랩 ]-->
	<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
			crossorigin="anonymous"></script>

	<!--──────────────────────────────────────────────────[↓ 기본 ]-->
	<!-- <!DOCTYPE html >
    <html> -->
	<!-- <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> -->
	<c:if test='${not empty message }'>
		<script>
			window.onload = function () {
				result();
			}

			function result() {
				alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
			}
		</script>
	</c:if>
</head>


<!------------------------------------------------------------------------------------------------------------------------------------[ BODY ]-->
<body>
<H3><p>로그인</p></H3>
<%-- 	<DIV id="detail_table">
    <form action="${contextPath}/member/login.do" method="post">
        <TABLE>
            <TBODY>
                <TR class="dot_line">
                    <TD class="fixed_join">아이디</TD>
                    <TD><input name="member_id" type="text" size="20" /></TD>
                </TR>
                <TR class="solid_line">
                    <TD class="fixed_join">비밀번호</TD>
                    <TD><input name="member_pw" type="password" size="20" /></TD>
                </TR>
            </TBODY>
        </TABLE>
        <br>
        <br> <INPUT type="submit" value="로그인"> <INPUT
            type="button" value="초기화"> <Br>
        <br> <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a> | <a
            href="${contextPath}/member/addMember.do">회원가입</a> | <a href="#">고객
            센터</a>
    </form> --%>
<div id="testing">
	<form action="${contextPath}/member/login.do" method="post">
		<div class="mb-3 form-css01">
			<input type="text" class="form-control" id="exampleFormControlInput1" name="member_id" placeholder="아이디">
		</div>
		<div class="form-css01">
			<input type="password" class="form-control" id="inputPassword6" name="member_pw" placeholder="비밀번호">
		</div>

		<div class="d-grid gap-2 col-6 mx-auto form-css01 form-css03">
			<input type="submit" class="btn btn-primary" value="로그인">
			<%--<input type="button" class="btn btn-primary" value="회원가입">--%>
			<a href="${contextPath}/member/memberForm.do" class="btn btn-primary form-css02" value="회원가입">회원가입</a>
		</div>

		<div class="form-css01 form-css03">
			<a href="#">아이디 찾기</a> &nbsp&nbsp | &nbsp&nbsp <a href="#">비밀번호 찾기</a>
		</div>
	</form>
</div>
</body>
<!-- </html> -->