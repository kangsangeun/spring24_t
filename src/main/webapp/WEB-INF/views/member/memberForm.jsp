<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>

<meta charset="utf-8">
<head>
<!--__________________________________________________________________________________________[↓ CSS 링크 ]-->
<link href="${contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${contextPath}/resources/css/main.css" rel="stylesheet">

<!--__________________________________________________________________________________________[↓ 폰트 링크 ]-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@600&family=Orbit&display=swap"
	rel="stylesheet">

<!--__________________________________________________________________________________________[↓ JavaScript ]-->
<script defer
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style>
/* 추가적인 스타일이 필요한 경우 여기에 작성. */
.dot_line {
	/* 여기에 dot_line 클래스에 대한 스타일을 추가. */
	
}

.fixed_join {
	/* 여기에 fixed_join 클래스에 대한 스타일을 추가하세요. */
	
}


</style>
</head>

<body>
	<!-- <h3>필수입력사항</h3> -->
	<form action="${contextPath}/member/addMember.do" method="post"
		onsubmit="return canSubmitForm()">
		<div id="detail_table">
			<table>
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">아이디</td>
						<td>
							<div class="input-group">
								<input type="text" class="form-control" name="_member_id"
									id="_member_id" maxlength="16"
									pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}" size="20"
									placeholder="아이디를 입력해주세요." value="" oninput="validID()"
									required />
								<div class="input-group-append">
									<button class="btn btn-outline-secondary" type="button"
										id="btnOverlapped" onclick="fn_overlapped()">중복체크</button>
								</div>
							</div>
							<div id="idError"></div> <input type="hidden" name="member_id"
							id="member_id" />
						</td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">비밀번호</td>
						<td>
							<div class="input-group mb-3">
								<input name="member_pw"
									pattern="^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{8,20}$"
									type="password" class="form-control" maxlength="20" size="20"
									placeholder="비밀번호를 입력해주세요." oninput="validPW()" required />
							</div>
							<div id="pwError"></div>
						</td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">비밀번호 확인</td>
						<td>
							<div class="input-group mb-3">
								<input name="confirm_pw" type="password" class="form-control"
									maxlength="20" size="20" placeholder="비밀번호를 확인해주세요."
									oninput="validPW()" required />
							</div>
							<div id="confirmPWError"></div>
						</td>
					</tr>
					<tr class="dot_line">

						<td class="fixed_join">이름</td>

						<td>
							<div class="input-group mb-3">
								<input name="member_name" type="text" class="form-control"
									size="20" placeholder="이름을 입력해주세요." required />
							</div>
						</td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">성별</td>
						<td><input type="radio" name="member_gender" value="102" />
							여성<span style="padding-left: 120px"></span> <input type="radio"
							name="member_gender" value="101" checked />남성</td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">법정생년월일</td>
						<td><select name="member_birth_y">

								<c:forEach var="year" begin="1" end="100">
									<c:choose>
										<c:when test="${year==80}">
											<option value="${ 1920+year}" selected>${ 1920+year}
											</option>
										</c:when>
										<c:otherwise>
											<option value="${ 1920+year}">${ 1920+year}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>

						</select>년 <select name="member_birth_m">
								<c:forEach var="month" begin="1" end="12">
									<c:choose>
										<c:when test="${month==5 }">
											<option value="${month }" selected>${month }</option>
										</c:when>
										<c:otherwise>
											<option value="${month }">${month}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select>월 <select name="member_birth_d">
								<c:forEach var="day" begin="1" end="31">
									<c:choose>
										<c:when test="${day==10 }">
											<option value="${day}" selected>${day}</option>
										</c:when>
										<c:otherwise>
											<option value="${day}">${day}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select>일 <span style="padding-left: 50px"></span> <input type="radio"
							name="member_birth_gn" value="2" checked />양력 <span
							style="padding-left: 50px"></span> <input type="radio"
							name="member_birth_gn" value="1" />음력</td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">휴대폰번호</td>
						<td>
							<div class="input-group mb-3">
								<input type="text" name="hp1" placeholder="숫자만 입력해주세요."
									class="form-control" oninput="validatePhoneNumber(this)"
									required>
							</div> <input type="checkbox" name="smssts_yn" value="Y" checked />
							쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
						</td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">이메일<br>(e-mail)
						</td>
						<td>
							<div class="input-group flex-nowrap">
								<input size="10px" type="text" name="email1"
									placeholder="예: spring24" required /> @ <input size="10px"
									type="text" name="email2" placeholder="spring24"
									id="email2Input" /> <select class="form-select"
									name="email_domain" id="emailDomain" onChange="updateEmail()"
									title="직접입력">
									<option value="non">직접입력</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="naver.com">naver.com</option>
									<option value="hotmail.com">daum.com</option>
									<option value="nate.com">nate.com</option>
									<option value="google.com">google.com</option>
									<option value="gmail.com">gmail.com</option>
								</select>
							</div> <input type="checkbox" name="emailsts_yn" value="Y" checked />
							쇼핑몰에서 발송하는 e-mail을 수신합니다.
						</td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">주소</td>
						<td>
							<div class="input-group mb-3">
								<input type="text" id="zipcode" name="zipcode" size="10"
									class="form-control"> <a
									href="javascript:execDaumPostcode()" class="input-group-text">우편번호검색</a>
							</div>
							<div class="input-group input-group-sm mb-3">
								<span class="input-group-text" id="inputGroup-sizing-sm">도로명
									주소 : </span> <input type="text" id="jibunAddress" name="jibunAddress"
									size="50" class="form-control">
							</div>
							<div class="input-group input-group-sm mb-3">
								<span class="input-group-text" id="inputGroup-sizing-sm">나머지
									주소 : </span> <input type="text" name="namujiAddress" size="50"
									class="form-control" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear">
			<br> <br>
			<table style="margin: auto;">
				<tr>
					<td><input type="submit" value="회원 가입"> <!--  <input type="reset" value="다시입력"> -->
					</td>

				</tr>
			</table>
		</div>
	</form>


	<script>
		//=================ID 정규표현식==========================
		var idRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/;

		//=================Password 정규표현식==========================
		var pwRegex = /^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{8,20}$/;

		//=================Password 검증==========================
		var confirmPWError = document.getElementById('confirmPWError');

		//===================아이디 검증===========================

		function validID() {
			var memberId = document.getElementById('_member_id').value;
			var idError = document.getElementById('idError');

			if (!idRegex.test(memberId)) {
				idError.textContent = '6자 이상 16자 이하의 영문 혹은 영문과 숫자를 조합';
			} else {
				idError.textContent = '';
			}
		}

		//===================비밀번호 검증===========================
		function validPW() {
			var password = document.getElementsByName("member_pw")[0].value;
			var confirmPW = document.getElementsByName("confirm_pw")[0].value;
			var pwError = document.getElementById('pwError');

			if (!pwRegex.test(password)) {
				pwError.textContent = '영문,숫자,특수문자(공백 제외)를 2개 이상 조합,총 8자리 이상이어야 합니다.';
			} else {
				pwError.textContent = '';
			}

			if (password !== confirmPW) {
				confirmPWError.textContent = '비밀번호가 일치하지 않습니다.';

			} else {
				confirmPWError.textContent = '';

			}

		}

		//===================아이디 입력 칸이 비활성화된 경우 양식을 제출할 수 있는지 확인하는 함수==================
		function canSubmitForm() {
			var memberId = document.getElementById('_member_id').value;
			var btnOverlapped = document.getElementById('btnOverlapped');

			// 아이디가 비어있지 않고, 버튼이 비활성화된 경우 양식을 제출할 수 있도록 true 반환
			if (memberId !== '' && btnOverlapped.disabled) {
				return true; // 양식 제출 허용
			} else {
				alert('ID 중복 체크를 해주세요.');
				return false; // 양식 제출 방지
			}
		}

		//============================아이디중복체크를 위한 함수============================
		function fn_overlapped() {
			var _id = $("#_member_id").val();

			// ID가 비어있을 경우 경고창 출력 후 중지
			if (_id == '') {
				alert("ID를 입력하세요");
				return;
			}

			//=============================중복 체크하기 위한 AJAX=============================
			$.ajax({
				type : "post",
				async : false,
				url : "${contextPath}/member/overlapped.do",
				dataType : "text",
				data : {
					id : _id
				},
				success : function(data, textStatus) {
					if (data == 'false') {
						alert("사용할 수 있는 ID입니다.");
						//아이디 입력 칸과 중복 체크 버튼 비활성화
						$('#btnOverlapped').prop("disabled", true);
						$('#_member_id').prop("disabled", true);

						$('#member_id').val(_id);

					} else {
						alert("사용할 수 없는 ID입니다.");

					}
				},
				error : function(data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete : function(data, textStatus) {
					//alert("작업을 완료했습니다");
				}
			}); //end ajax	 
		}

		//=====================핸드폰 번호 숫자만(11자리) 입력할 수 있게 해주는 함수===================
		function validatePhoneNumber(input) {
			input.value = input.value.replace(/[^\d]/g, ''); // 숫자 이외의 문자 제거

			if (input.value.length > 11) {
				input.value = input.value.substring(0, 11); // 11자리까지만 남기고 잘라냄
			}
		}
		//========================email2를 적용하는 함수=======================
		function updateEmail() {
			var email2Input = document.getElementById('email2Input');
			var emailDomain = document.getElementById('emailDomain');
			var selectedDomain = emailDomain.options[emailDomain.selectedIndex].value;

			// 선택한 이메일 옵션을 email2Input에 설정
			if (selectedDomain === 'non') {
				email2Input.value = '';
			} else {
				email2Input.value = selectedDomain;
			}
		}

		//==============================도로명 주소 함수================================
		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 도로명 조합형 주소 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}
							// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
							if (fullRoadAddr !== '') {
								fullRoadAddr += extraRoadAddr;
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
							/* 	document.getElementById('roadAddress').value = fullRoadAddr; */
							document.getElementById('jibunAddress').value = data.jibunAddress;

							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								//예상되는 도로명 주소에 조합형 주소를 추가한다.
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;
								document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
										+ expRoadAddr + ')';

								/* 		} else if (data.autoJibunAddress) {
												var expJibunAddr = data.autoJibunAddress;
												document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
														+ expJibunAddr + ')';  */
							} else {
								document.getElementById('guide').innerHTML = '';
							}

						}
					}).open();
		}
	</script>
</body>
</html>