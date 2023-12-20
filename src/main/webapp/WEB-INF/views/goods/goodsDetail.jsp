<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goodsVO}" />
<c:set var="imageList" value="${goodsMap.imageList }" />

<%
	//치환 변수 선언합니다.
	//pageContext.setAttribute("crcn", "\r\n");		//개행문자
	pageContext.setAttribute("crcn" , "\n");		//Ajax로 변경 시 개행 문자
	pageContext.setAttribute("br", "<br/>");		//br 태그
%>


<html>
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

	<style>
		#layer {
			z-index: 2;
			position: absolute;
			top: 0px;
			left: 0px;
			width: 100%;
		}

		#popup {
			/*			z-index: 3;
                        position: fixed;
                        text-align: center;
                        left: 50%;
                        top: 45%;
                        width: 300px;
                        height: 200px;
                        background-color: #ccffff;
                        border: 3px solid #87cb42;*/
			z-index: 3;
			position: fixed;
			text-align: center;
			left: 48.35%;
			top: 485px;
			width: 280px;
			height: 120px;
			background-color: #ffffff;
			border: 1px solid #b41e22;
			border-radius: 10px;
		}

		#close {
			z-index: 4;
			float: right;
		}
	</style>

	<!--────────────────────────────────────────────────────────────────────────────────────────────────────[ JavaScript ]-->
	<!--──────────────────────────────────────────────────[↓ 부트스트랩 ]-->
	<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
			crossorigin="anonymous"></script>

	<!--─────────────────────────[↓ 장바구니에 담기 ]-->
	<script type="text/javascript">
		function add_cart(goods_id, cart_goods_qty) {

			$.ajax({
				type : "post",
				async : false,		//false인 경우 동기식으로 처리한다.
				url : "${contextPath}/cart/addGoodsInCart.do",
				data : {
					goods_id:goods_id,
					cart_goods_qty:cart_goods_qty
				},
				success : function(data, textStatus) {
					//alert(data);
					//$('#message').append(data);
					if(data.trim()=='add_success') {
						imagePopup('open', '.layer01');
					} else if(data.trim()=='already_existed'){
						alert("이미 카트에 등록된 상품입니다.");
					}
				},
				error : function(data, textStatus) {
					alert("에러가 발생했습니다."+data);
				},
				complete : function(data, textStatus) {
					//alert("작업을 완료했습니다");
				}
			});		//end ajax
		}

		function imagePopup(type) {
			if (type == 'open') {
				// 팝업창을 연다.
				jQuery('#layer').attr('style', 'visibility:visible');
				// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
				jQuery('#layer').height(jQuery(document).height());
			}
			else if (type == 'close') {
				// 팝업창을 닫는다.
				jQuery('#layer').attr('style', 'visibility:hidden');
			}
		}

		function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
			var _isLogOn=document.getElementById("isLogOn");
			var isLogOn=_isLogOn.value;
			if(isLogOn=="false" || isLogOn=='' ) {
				alert("로그인 후 주문이 가능합니다");
			}
			var total_price,final_total_price;
			var order_goods_qty=document.getElementById("order_goods_qty");
			var formObj=document.createElement("form");
			var i_goods_id = document.createElement("input");
			var i_goods_title = document.createElement("input");
			var i_goods_sales_price=document.createElement("input");
			var i_fileName=document.createElement("input");
			var i_order_goods_qty=document.createElement("input");

			i_goods_id.name="goods_id";
			i_goods_title.name="goods_title";
			i_goods_sales_price.name="goods_sales_price";
			i_fileName.name="goods_fileName";
			i_order_goods_qty.name="order_goods_qty";

			i_goods_id.value=goods_id;
			i_order_goods_qty.value=order_goods_qty.value;
			i_goods_title.value=goods_title;
			i_goods_sales_price.value=goods_sales_price;
			i_fileName.value=fileName;

			formObj.appendChild(i_goods_id);
			formObj.appendChild(i_goods_title);
			formObj.appendChild(i_goods_sales_price);
			formObj.appendChild(i_fileName);
			formObj.appendChild(i_order_goods_qty);

			document.body.appendChild(formObj);
			formObj.method="post";
			formObj.action="${contextPath}/order/orderEachGoods.do";
			formObj.submit();
		}
	</script>
</head>


<!------------------------------------------------------------------------------------------------------------------------------------[ BODY ]-->
<body>
<hgroup>
	<h1><a href="${contextPath}/main/main.do">홈</a></h1>
	<h1>&#62;</h1>
	<c:choose>
		<c:when test="${goods.goods_status eq 'sandwich'}">
			<h1><a href="${contextPath}/goods/selectGoodsList.do?category=sandwich">도시락/샌드위치</a></h1>
		</c:when>
		<c:when test="${goods.goods_status eq 'noodle'}">
			<h1><a href="${contextPath}//goods/selectGoodsList.do?category=noodle">라면/면류</a></h1>
		</c:when>
		<c:when test="${goods.goods_status eq 'dairy'}">
			<h1><a href="${contextPath}/goods/selectGoodsList.do?category=dairy">유제품</a></h1>
		</c:when>
		<c:when test="${goods.goods_status eq 'drink'}">
			<h1><a href="${contextPath}/goods/selectGoodsList.do?category=drink">음료</a></h1>
		</c:when>
		<c:when test="${goods.goods_status eq 'snack'}">
			<h1><a href="${contextPath}/goods/selectGoodsList.do?category=snack">스낵</a></h1>
		</c:when>
		<c:when test="${goods.goods_status eq 'etc'}">
			<h1><a href="${contextPath}/goods/selectGoodsList.do?category=etc">생활잡화</a></h1>
		</c:when>
		<c:otherwise>>
			<h1></h1>
		</c:otherwise>
	</c:choose>
</hgroup>

<div id="goods_image">
	<figure>
		<img alt="HTML5 &amp; CSS3"
			 src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_fileName}">
	</figure>
</div>
<div id="detail_table">
	<table>
		<h3>${goods.goods_title }</h3>
		<tbody>
		<tr>
			<td class="fixed">정가</td>
			<td class="active"><span >
					   <fmt:formatNumber  value="${goods.goods_price}" type="number" var="goods_price" />
				         ${goods_price}원
					</span></td>
		</tr>
		<tr class="dot_line">
			<td class="fixed">판매가</td>
			<td class="active"><span >
					   <fmt:formatNumber  value="${goods.goods_price*0.9}" type="number" var="discounted_price" />
				         ${discounted_price}원(10%할인)</span></td>
		</tr>
		<tr>
			<td class="fixed">포인트적립</td>
			<td class="active">${goods.goods_point}P(10%적립)</td>
		</tr>
		<tr class="dot_line">
			<td class="fixed">포인트 추가적립</td>
			<td class="fixed">만원이상 구매시 1,000P, 5만원이상 구매시 2,000P추가적립 편의점 배송 이용시 300P 추가적립</td>
		</tr>
		<%--<tr>
            <td class="fixed">발행일</td>
            <td class="fixed">
               <c:set var="pub_date" value="${goods.goods_published_date}" />
               <c:set var="arr" value="${fn:split(pub_date,' ')}" />
               <c:out value="${arr[0]}" />
            </td>
        </tr>
        <tr>
            <td class="fixed">페이지 수</td>
            <td class="fixed">${goods.goods_total_page}쪽</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed">ISBN</td>
            <td class="fixed">${goods.goods_isbn}</td>
        </tr>--%>
		<tr>
			<td class="fixed">배송료</td>
			<td class="fixed"><strong>무료</strong></td>
		</tr>
		<tr>
			<td class="fixed">배송안내</td>
			<td class="fixed"><strong>[당일배송]</strong> 당일배송 서비스 시작!<br> <strong>[휴일배송]</strong>
				휴일에도 배송받는 Bookshop</TD>
		</tr>
		<tr>
			<td class="fixed">도착예정일</td>
			<td class="fixed">지금 주문 시 내일 도착 예정</td>
		</tr>
		<tr>
			<td class="fixed">수량</td>
			<td class="fixed">
				<select style="width: 60px;" id="order_goods_qty">
					<option>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
				</select>

<%--				<!-- 예시: 상품 수량을 입력하는 input 요소 -->
				<input type="number" id="cart_goods_qty" value="1">
				<!-- 상품을 장바구니에 추가하는 버튼 -->--%>
		<%--		<button onclick="add_cart(${goods_id}, $('#quantityInput').val())">장바구니에 추가</button>--%>
				<!-- 예시: 상품 수량을 입력하는 input 요소 -->
				<input type="number" id="cart_goods_qty" value="1">
	<%--			<a href="javascript:add_cart('${goods.goods_id}', $('#cart_goods_qty').val())" role="button">장바구니</a>--%>

				<%--					<div class="prod-buy__quantity">
                                        <div class="prod-quantity__form">
                                            <input type="text" value="1" class="prod-quantity__input" maxlength="6" autocomplete="off">
                                            <div style="display:table-cell;vertical-align:top;">
                                                <button class="prod-quantity__plus" type="button">수량빼기</button>
                                                <button class="prod-quantity__minus" type="button">수량더하기</button>
                                            </div>
                                        </div>
                                    </div>--%>



			</td>
		</tr>
		</tbody>
	</table>
	<ul>
		<li><a class="buy btn btn-primary" href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title }','${goods.goods_sales_price}','${goods.goods_fileName}')" role="button">구매하기</a></li>
		<li><a class="cart btn btn-primary" href="javascript:add_cart('${goods.goods_id}', $('#cart_goods_qty').val())" role="button">장바구니에 담기</a></li>
		<%--			<li><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title }','${goods.goods_sales_price}','${goods.goods_fileName}');">구매하기 </a></li>--%>
		<%--			<li><a class="cart" href="javascript:add_cart('${goods.goods_id }')">장바구니</a></li>--%>
		<%--			<li><a class="wish" href="#">위시리스트</a></li>--%>
	</ul>
</div>
<div class="clear"></div>
<!-- 내용 들어 가는 곳 -->
<div id="container">
	<ul class="tabs">
		<li><a href="#tab1">상품소개</a></li>
		<!-- 		<li><a href="#tab2">저자소개</a></li>
                    <li><a href="#tab3">책목차</a></li>
                    <li><a href="#tab4">출판사서평</a></li>
                    <li><a href="#tab5">추천사</a></li>
                    <li><a href="#tab6">리뷰</a></li>-->
	</ul>
	<div class="tab_container">
		<div class="tab_content" id="tab1">
			<h4>책소개</h4>
			<p>${fn:replace(goods.goods_intro,crcn,br)}</p>
			<c:forEach var="image" items="${imageList }">
				<img src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${image.fileName}">
			</c:forEach>
		</div>
		<div class="tab_content" id="tab2">
			<h4>저자소개</h4>
			<p>
			<div class="writer">저자 : ${goods.goods_writer}</div>
			<p>${fn:replace(goods.goods_writer_intro,crcn,br) }</p>

		</div>
		<div class="tab_content" id="tab3">
			<h4>책목차</h4>
			<p>${fn:replace(goods.goods_contents_order,crcn,br)}</p>
		</div>
		<div class="tab_content" id="tab4">
			<h4>출판사서평</h4>
			<p>${fn:replace(goods.goods_publisher_comment ,crcn,br)}</p>
		</div>
		<div class="tab_content" id="tab5">
			<h4>추천사</h4>
			<p>${fn:replace(goods.goods_recommendation,crcn,br) }</p>
		</div>
		<div class="tab_content" id="tab6">
			<h4>리뷰</h4>
		</div>
	</div>
</div>
<div class="clear"></div>
<div id="layer" style="visibility: hidden">
	<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
	<div id="popup">
		<!-- 팝업창 닫기 버튼 -->
		<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');"><img src="${contextPath}/resources/image/close.png" id="close" /></a>

		<br>

		<p id="contents">상품이 장바구니에 담겼습니다.</p>

		<form id="cart_btn" action='${contextPath}/cart/myCartList.do'>
			<input type="submit" class="btn btn-primary" value="장바구니 보기">

			<br>

		</form>
	</div>
</div>
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>