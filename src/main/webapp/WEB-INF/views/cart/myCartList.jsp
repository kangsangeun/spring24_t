<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="myCartList" value="${cartMap.myCartList}" />
<c:set var="myGoodsList" value="${cartMap.myGoodsList}" />

<c:set var="totalGoodsNum" value="0" />
<!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="0" />
<!-- 총 배송비 -->
<c:set var="totalDiscountedPrice" value="0" />
<!-- 총 할인금액 -->
<head>
<script type="text/javascript">
function calcGoodsPrice(bookPrice,obj){
	var totalPrice, final_total_price, totalNum;
	var goods_qty=document.getElementById("select_goods_qty");
	//alert("총 상품금액"+goods_qty.value);
	var p_totalNum=document.getElementById("p_totalNum");
	var p_totalPrice=document.getElementById("p_totalPrice");
	var p_final_totalPrice=document.getElementById("p_final_totalPrice");
	var h_totalNum=document.getElementById("h_totalNum");
	var h_totalPrice=document.getElementById("h_totalPrice");
	var h_totalDelivery=document.getElementById("h_totalDelivery");
	var h_final_total_price=document.getElementById("h_final_totalPrice");
	if(obj.checked==true){
	//	alert("체크 했음")
		
		totalNum = Number(h_totalNum.value) + Number(goods_qty.value);
		//alert("totalNum:"+totalNum);
		totalPrice = Number(h_totalPrice.value) + Number(goods_qty.value * bookPrice);
		//alert("totalPrice:"+totalPrice);
		final_total_price=totalPrice + Number(h_totalDelivery.value);
		//alert("final_total_price:"+final_total_price);

	}else{
	//	alert("h_totalNum.value:"+h_totalNum.value);
		totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
	//	alert("totalNum:"+ totalNum);
		totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value)*bookPrice;
	//	alert("totalPrice="+totalPrice);
		final_total_price=totalPrice-Number(h_totalDelivery.value);
	//	alert("final_total_price:"+final_total_price);
	}
	
	h_totalNum.value=totalNum;
	
	h_totalPrice.value=totalPrice;
	h_final_total_price.value=final_total_price;
	
	p_totalNum.innerHTML=totalNum;
	p_totalPrice.innerHTML=totalPrice;
	p_final_totalPrice.innerHTML=final_total_price;
}

function modify_cart_qty(goods_id, bookPrice, index){
	//alert(index);
   var length=document.frm_order_all_cart.cart_goods_qty.length;
   var _cart_goods_qty=0;
   
	if(length>1){ //카트에 제품이 여러개인 경우와 한개인 경우 나누어서 처리한다.
		_cart_goods_qty = document.frm_order_all_cart.cart_goods_qty[index].value;		
	}else{
		_cart_goods_qty = document.frm_order_all_cart.cart_goods_qty.value;
	}
		
	var cart_goods_qty = Number(_cart_goods_qty);
	//alert("cart_goods_qty:"+cart_goods_qty);
	//console.log(cart_goods_qty);
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/cart/modifyCartQty.do",
		data : {
			goods_id:goods_id,
			cart_goods_qty:cart_goods_qty
		},
		
		success : function(data, textStatus) {
			//alert(data);
			if(data.trim()=='modify_success'){
				
				alert("수량을 변경했습니다.");
				location.reload();
			}else{
				alert("다시 시도해 주세요.");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax	
}

function delete_cart_goods(cart_id){
	
	var cart_id=Number(cart_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_id";
	i_cart.value=cart_id;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
    formObj.submit();
}

function fn_order_each_goods(goods_id, goods_title, goods_price, fileName){
	var total_price, final_total_price, _goods_qty;
	var cart_goods_qty=document.getElementById("cart_goods_qty");
	
	_order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_price.name="goods_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=_order_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_price.value=goods_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
}

function fn_order_all_cart_goods(){
//	alert("모두 주문하기");
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty;
	var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
	var checked_goods=objForm.checked_goods;
	var length=checked_goods.length;
	
	
	//alert(length);
	if(length>1){
		for(var i=0; i<length;i++){
			if(checked_goods[i].checked==true){
				order_goods_id=checked_goods[i].value;
				order_goods_qty=cart_goods_qty[i].value;
				cart_goods_qty[i].value="";
				cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
				//alert(select_goods_qty[i].value);
				console.log(cart_goods_qty[i].value);
			}
		}	
	}else{
		order_goods_id=checked_goods.value;
		order_goods_qty=cart_goods_qty.value;
		cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
		//alert(select_goods_qty.value);
	}
		
 	objForm.method="post";
 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
	objForm.submit();
}

</script>
</head>
<body>
	<table class="list_view">
		<tbody align=center>
			<tr style="background: #beff9e">
				<td class="fixed">구분</td>
				<td colspan=2 class="fixed">상품명</td>
				<td>가격</td> <!-- (변경전)정가 (변경후)가격 -->
				<!-- 판매가:삭제 -->
				<td>수량</td>
				<td>합계</td>
				<td>주문</td>
			</tr>

			<c:choose>
				<c:when test="${ empty myCartList }">
					<tr>
						<td colspan=8 class="fixed"><strong>장바구니에 상품이 없습니다.</strong>
						</td>
					</tr>
				</c:when>
				
				<c:otherwise>
					<tr>
						<form name="frm_order_all_cart">
							<c:forEach var="item" items="${myGoodsList }" varStatus="cnt">
								<c:set var="cart_goods_qty"
									value="${myCartList[cnt.count-1].cart_goods_qty}" />
								<c:set var="cart_id" value="${myCartList[cnt.count-1].cart_id}" />
								
							<!-- 구분 -->
								<td><input type="checkbox" name="checked_goods" checked
									value="${item.goods_id }"
									onClick="calcGoodsPrice(${item.goods_price },this)"></td>
								<td class="goods_image"><a
									href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
										<img width="75" alt=""
										src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" />
								</a></td>
							<!-- 상품명 -->
								<td>
									<h2>
										<a
											href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
									</h2>
								</td>
							<!-- 가격 -->
								<td class="price"><span>${item.goods_price }원</span>
								</td>
							<!-- 판매가: 삭제(2023-12-15) -->
								<%-- <td><strong> <fmt:formatNumber
											value="${item.goods_sales_price*0.9}" type="number"
											var="discounted_price" /> ${discounted_price}원(10%할인)
								</strong></td> --%>
							<!-- 수량 -->
								<!-- 수량 입력란 -->
								<td><input type="text" id="cart_goods_qty"
									name="cart_goods_qty" size=3 value="${cart_goods_qty}"><br>
								<!-- 변경 버튼 -->
								<a
									href="javascript:modify_cart_qty(${item.goods_id }, ${item.goods_price}, ${cnt.count-1 });">
										<img width=25 alt=""
										src="${contextPath}/resources/image/btn_modify_qty.jpg">
								</a></td>
							<!-- 합계 -->
								<td class="total_price"> 
							
								<fmt:formatNumber
											value="${item.goods_price * cart_goods_qty}"
											type="number" var="total_price" />
										${total_price}원
							
								</td>
							<!-- 주문(가장 오른쪽 컬럼) -->
								<td><a
									href="javascript:fn_order_each_goods('${item.goods_id }','${item.goods_title }','${item.goods_price}','${item.goods_fileName}');">
										<img width="75" alt=""
										src="${contextPath}/resources/image/btn_order.jpg">
								</a><br> <a href="#"> <img width="75" alt=""
										src="${contextPath}/resources/image/btn_order_later.jpg">
								</a><br> <a href="#"> <img width="75" alt=""
										src="${contextPath}/resources/image/btn_add_list.jpg">
								</A><br> <a href="javascript:delete_cart_goods('${cart_id}');"">
										<img width="75" alt=""
										src="${contextPath}/resources/image/btn_delete.jpg">
								</a></td>
					</tr>
					
					<c:set var="totalGoodsPrice"
						value="${totalGoodsPrice + item.goods_price * cart_goods_qty }" />
					<c:set var="totalGoodsNum" value="${totalGoodsNum+1 }" />
					</c:forEach>
		</tbody>
	</table>

	<div class="clear"></div>
	</c:otherwise>
	</c:choose>
	<br>
	<br>

	<!-- ========================================================================== -->
	<!-- 화면 하단 보라색 영역 -->
	<!-- ========================================================================== -->

	<table width=80% class="list_view" style="background: #cacaff">
		<tbody>
			<tr align=center class="fixed">
				<td class="fixed">총 상품수</td>
				<td>총 상품금액</td>
				<td></td>
				<td>총 배송비</td>
			<!-- 빼기 그림이 들어가는 셀(td)과 총할인금액 셀(td)을 삭제 -->
				<!-- <td></td>
				<td>총 할인 금액</td> -->
				<td></td>
				<td>최종 결제금액</td>
			</tr>
			
			<tr cellpadding=40 align=center>
			<!-- 총 상품 수 -->
				<td id="">
					<p id="p_totalGoodsNum">${totalGoodsNum}개</p> <input
					id="h_totalGoodsNum" type="hidden" value="${totalGoodsNum}" />
				</td>
			<!-- 총 상품금액 -->
				<td>
					<p id="p_totalGoodsPrice">
						<fmt:formatNumber value="${totalGoodsPrice}" type="number"
							var="total_goods_price" />
						${total_goods_price}원
					</p> <input id="h_totalGoodsPrice" type="hidden"
					value="${totalGoodsPrice}" />
				</td>
			<!-- 더하기 그림 -->
				<td><img width="25" alt=""
					src="${contextPath}/resources/image/plus.jpg"></td>
			<!-- 총 배송비 -->
				<td>
					<p id="p_totalDeliveryPrice">${totalDeliveryPrice }원</p> <input
					id="h_totalDeliveryPrice" type="hidden"
					value="${totalDeliveryPrice}" />
				</td>
			<!-- 빼기 그림: 삭제 -->
				<%-- <td><img width="25" alt=""
					src="${contextPath}/resources/image/minus.jpg"></td> --%>
			<!-- 총 할인 금액: 삭제 -->
				<%-- <td>
					<p id="p_totalSalesPrice">${totalDiscountedPrice}원</p> <input
					id="h_totalSalesPrice" type="hidden" value="${totalSalesPrice}" />
				</td> --%>
			<!-- 이퀄사인 그림 -->
				<td><img width="25" alt=""
					src="${contextPath}/resources/image/equal.jpg"></td>
			<!-- 최종 결제금액 -->
				<td>
					<p id="p_final_totalPrice">
						<fmt:formatNumber
							value="${totalGoodsPrice + totalDeliveryPrice}"
							type="number" var="total_price" />
						${total_price}원
					</p> <input id="h_final_totalPrice" type="hidden"
					value="${totalGoodsPrice + totalDeliveryPrice}" />
				</td>
			</tr>
		</tbody>
	</table>
	
<!-- 주문하기 버튼, 쇼핑계속하기 버튼 -->
	<center>
		<br>
		<br> <a href="javascript:fn_order_all_cart_goods()"> <img
			width="75" alt=""
			src="${contextPath}/resources/image/btn_order_final.jpg">
		</a> <a href="#"> <img width="75" alt=""
			src="${contextPath}/resources/image/btn_shoping_continue.jpg">
		</a>
	<center>
</form>