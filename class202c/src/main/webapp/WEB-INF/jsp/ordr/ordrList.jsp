<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="com.ohhoonim.vo.OrdrVo" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ page import="java.util.Calendar"%>

<%
	Calendar cal=Calendar.getInstance();
	String year=request.getParameter("search_end_year");
		if(year==null) year=cal.get(Calendar.YEAR)+"";
	String month=request.getParameter("search_end_month");
		if(month==null) month=cal.get(Calendar.MONTH)+1+"";
	String day=request.getParameter("search_end_date");
		if(day==null) day=cal.get(Calendar.DATE)+"";
%>

<%
	List<Map<String,Object>> ordrList = (List<Map<String,Object>>)request.getAttribute("ordrList");
	List<Map<String,Object>> ordroutgoingList = (List<Map<String,Object>>)request.getAttribute("ordroutgoingList");
	String ordrId = (String)request.getAttribute("ordrId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>더조은 총판</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="<%=contextPath %>/css/w3.css">
<link rel="stylesheet" href="<%=contextPath %>/css/common.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<%=contextPath%>/js/moment.js" type="text/javascript"></script>
<script src="<%=contextPath%>/js/mypage.js" type="text/javascript"></script>
<script>
	$(function() {
		init();
		selected_search_period('7D');
		
		$('.opt').change(function(){
			order_list_period();			
		})
	
		$('.inner').click(function() {
			order_list_period();
		})
		/*
		$("#datepicker").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$("#datepicker1").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$("#datepicker2").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$("#datepicker3").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		*/
	$('#chkAll').click(function(){
		if ($(this).prop("checked")){
			$("input[name=chk]").prop("checked",true);
		}else{
			$("input[name=chk]").prop("checked",false);
		}
	});
	
	$(function(){
		$('#selectConfirm').click(chkConfirm);
	});
	
	function chkConfirm(){
		
		var chkListOrdrId = [];
		var chkListPrdId = [];
		$('input[name="chk"]').each(function(){
			if($(this).is(":checked")){
				var tr = $(this).parent().parent();
				var ordrId = tr.find('td:nth-child(2)').text();
				var prdId = tr.find('td:nth-child(6)').text();
				
				chkListOrdrId.push(ordrId);
				chkListPrdId.push(prdId);
			}
		});
		alert(chkListOrdrId);
		alert(chkListPrdId);
		var form = document.form;
		form.ordrId.value = chkListOrdrId.join(',');
		form.prdId.value = chkListPrdId.join(',');
		form.submit();
	};
	
	$('#doSearch').click(function(){
		selectList();
	});
	
	$('#ordrId, #ptnrNm, #productNm').keydown(function(event ){
		if ( event.which == 13 ) {
			$('#doSearch').click();	
			return false;
		}				
	});	
	
});
	
	function sprintf(str) {
	    var args = arguments,
	      flag = true,
	      i = 1;
	  
	    str = str.replace(/%s/g, function() {
	      var arg = args[i++];
	  
	      if (typeof arg === 'undefined') {
	        flag = false;
	        return '';
	      }
	      return arg;
	    });
	    return flag ? str : '';
}

function selectList(){
	var a = '<tr><td><input type="checkbox" name="chk" %s/></td><td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+				
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td></tr>';
	$.ajax({
		url : '<%=contextPath%>/ordr/ordrSearch.do',
			data : {
				
				ordrId : $('#ordrId1').val(), ptnrNm : $('#ptnrNm').val(), productNm : $('#productNm').val()
				,startDate : $('#startDate').val(), endDate : $('#endDate').val()
				},
			method : "post",
			dataType : "json",
			success : function(data, status, jqXHR) {					
				var options='';
				var isDisabled = 'disabled';
				var list = data.result;
			      for (var i = 0; i < list.length; i++) {
			    	  isDisabled = 'disabled';
			    	  if (list[i].status == '1101') {
			    		  isDisabled = '';
			    	  }
			    	  options += sprintf(a,
			    			  isDisabled,
			    			  list[i].ordrId,
			    			  list[i].ordrDate, 
			    			  list[i].ptnrId, 
			    			  list[i].ptnrNm, 
			    			  list[i].productId, 
			    			  list[i].productNm, 
			    			  list[i].ptnrNm2, 
			    			  list[i].rstock, 
			    			  list[i].amnt, 
			    			  numberWithCommas(list[i].unitPrice), 
			    			  numberWithCommas(list[i].salesCost), 
			    			  numberWithCommas(list[i].total), 
			    			  numberWithCommas(list[i].profit), 
			    			  list[i].statusnm); 	  
			      }				     
			      $("#list tbody").html(options);
			      $("#list tbody tr").click(function(){
			  		var temp = $(this);
			  		selectList1(temp);
			  		
			  	});
			},
			error : function(jqXHR, status, errorThrown) {
				alert('ERROR: ' + JSON.stringify(jqXHR));
			}
		});
	
}

function selectList1(temp){
	
	var tdArr = new Array();
	var tr = temp;
	var td = tr.children();
	var ordrId = td.eq(1).text();
	
	td.each(function(i){
		tdArr.push(td.eq(i).text());
	});
	
	var a = '<tr><td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+				
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+																								
			'<td><input type="text" name="amnt2" id="amnt2" value="%s" ><span class="w3-btn w3-blue-grey btnChangeQty">수량변경</span></td> '+
			'<td>%s</td></tr>';
	$.ajax({
		url : '<%=contextPath%>/ordr/ordrSearch1.do',
			data : {
				
				ordrId : td.eq(1).text()
				},
			method : "post",
			dataType : "json",
			success : function(data, status, jqXHR) {					
				var options='';					
				var list = data.result1;
				
				if (list != null && list.length > 0) {
			      for (var i = 0; i < list.length; i++) {
			    	  options += sprintf(a,
			    			  list[i].ordrId,
			    			  list[i].count, 
			    			  list[i].ogDate, 
			    			  list[i].productId, 
			    			  list[i].productNm, 
			    			  list[i].ptnrNm2, 
			    			  list[i].rstock, 
			    			  list[i].amnt, 
			    			  list[i].amnt1, 
			    			  numberWithCommas(list[i].salesCost * list[i].amnt1)
			    			  ); 	  
			      }
			      var status = list[0].status;
			      console.log(status);
			      
					if(status === '1303'){
						$('#popup_open').hide();
						$('#ordrId').val("");
						}else{
							$('#popup_open').show();
							$('#ordrId').val(ordrId);
							
						}
			      $("#list1 tbody").html(options);
			      $('.btnChangeQty').click(function(){
				  		var amnt2 = $(this).parent().find('input').val();
				  		var ordrId = $(this).parent().parent().find('td:nth-child(1)').text();
				  		var productId = $(this).parent().parent().find('td:nth-child(5)').text();
				  		var count = $(this).parent().parent().find('td:nth-child(10)').text();
				  		
				  		$('#changeQtyFormAmnt2').val(amnt2);
				  		$('#changeQtyFormOrdrId').val(ordrId);
				  		$('#changeQtyFormProductId').val(productId);
				  		$('#changeQtyFormCount').val(count);
				  		
				  		document.changeQtyForm.submit();
				  	});
				} else {
					$("#list1 tbody").html('<tr><td colspan="10">데이터가 없습니다.</td></tr>');
				}
			},
			error : function(jqXHR, status, errorThrown) {
				alert('ERROR: ' + JSON.stringify(jqXHR));
				$("#list1 tbody").html("");	
				$('#popup_open').show();
				$('#ordrId').val(ordrId);
			}
		});
	
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function init(){     // 뒤에 날짜를 초기로 하는 펑션 
	
	var oYear=document.getElementById("search_end_year").options;
	//console.log(oYear);
		for(var i=1;i<oYear.length;i++){
	var val=oYear[i].value;	
		if('<%=year%>'==parseInt(val)){
			oYear.selectedIndex=i;
		break;
		}
	}

	
	var oMonth=document.getElementById("search_end_month").options;	
		for(var i=1;i<oMonth.length;i++){
	var val=oMonth[i].value;
		if('<%=month%>'==parseInt(val)){
			oMonth.selectedIndex=i;
		break;	
		}
	}
	

	var oDay=document.getElementById("search_end_date").options;	
		for(var i=1;i<oDay.length;i++){
	var val=oDay[i].value;	
	if('<%=day%>' == parseInt(val)) {
				oDay.selectedIndex = i;

				break;
			}
		}
	}   // 여기까지가 초기값 오늘로 설정 + 

	function order_list_period() {
		var startDate = $('#search_start_year').val()
				+ maker($('#search_start_month').val())
				+ maker($('#search_start_date').val()) + '000000';
		$('#startDate').val(startDate);
		console.log(startDate);
		var endDate = $('#search_end_year').val()
				+ maker($('#search_end_month').val())
				+ maker($('#search_end_date').val()) + '235959';
		$('#endDate').val(endDate);
		console.log(endDate);
	}

	function maker(a) {
		if (a.length == 1) {
			var b = '0' + a;
		} else {
			var b = a;
		}
		return b;
	}
	
	$(document).ready(function(){ 
		$("#popup_open").click(function(){ 
			$("#popup_wrap").css("display", "block"); 
			$("#mask").css("display", "block"); 
			ogAddView();
		}); 
		$("#popup_close").click(function(){ 
			$("#popup_wrap").css("display", "none"); 
			$("#mask").css("display", "none"); 
			$("#popup_title").find("span").text("");
			$("#popup_table tbody").html("");	
			$("#ogCount").val("");
		}); 
		$("#popup_confirm").bind('click', function() {
			ogAdd();	
			$("#popup_wrap").css("display", "none"); 
			$("#mask").css("display", "none"); 
			$("#popup_title").find("span").text("");
			$("#popup_table tbody").html("");	
			$("#ogCount").val("");
			
		});
	});
	
function ogAddView(ogPk){
	$("#popup_confirm").off('click');
		var a = '<tr>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td><input type="text" id="addOgAmnt" value=""></td>'+
				'</tr>';
				
		if(ogPk == null){
			var ordrId = $('#ordrId').val();
			var situation = '출고 등록';
			
			$("#popup_confirm").on('click', function() {
				ogAdd();	
			});
			
			
		}else{
			var ordrId = ogPk[0];
			var ogCount = ogPk[1];			
			var situation = '출고 수정';
			$('#ogCount').val(ogCount);			
			$("#popup_confirm").on('click', function() {
				ogModify();		
			});
		}
					
		$.ajax({
			url : '<%=contextPath%>/outgoing/outgoingAddView.do',
				data : {
					ordrId : $('#ordrId').val()
					},
				method : "post",
				dataType : "json",
				  
				success : function(data, status, jqXHR) {
					var options='';					
					var list = data.result;
					for (var i = 0; i < list.length; i++){	  
				    	  options += sprintf(a,
				    			  list[i].productId,
				    			  list[i].productNm,
				    			  numberWithCommas(list[i].amnt),
				    			  numberWithCommas(list[i].amntLo)				    			  							    			  
				    			  ); 
					}
					      $("#popup_title").find("span:nth-child(1)").text(list[0].ordrId);	
					      $("#popup_title").find("span:nth-child(2)").text(list[0].ptnrNm);				      
			  
				      $("#popup_table tbody").html(options);
				      
				},
				error : function(jqXHR, status, errorThrown) {
					alert('ERROR: 관리자문의');
					$("#popup_wrap").css("display", "none"); 
					$("#mask").css("display", "none"); 
					$("#popup_title").find("span").text("");
					$("#popup_table tbody").html("");	
				}
			});
		}


function ogAdd(){	
	$("#popup_confirm").off('click');
	var ogAddAmnt = $('#addOgAmnt').val();
	var ordrId = $('#ordrId').val();
	$.ajax({
		url : '<%=contextPath%>/outgoing/outgoingAdd.do',
			data : {
				'ordrId' : ordrId, 'ogAddAmnt' : $('#addOgAmnt').val()
				},
			method : "post",
			dataType : "json",
			success : function(data, status, jqXHR) {
				 //$("#popup_confirm").unbind('click');
				var chk = data.result;
				alert(chk);				
				selectList(ordrId);
				selectList1();
				popup_close();
				
			},
			error : function(jqXHR, status, errorThrown) {
				alert('ERROR: 관리자문의');

			}
		});
	}
	
function ogModify(){	
	$("#popup_confirm").off('click');
	var ogAddAmnt = $('#addOgAmnt').val();
	var ordrId = $('#ordrId').val();
	var ogCount = $('#ogCount').val();
	$.ajax({
		url : '<%=contextPath%>/outgoing/outgoingModify.do',
			data : {
				'ordrId' : ordrId, 'ogCount' : ogCount, 
				'ogAddAmnt' :ogAddAmnt
				},
			method : "post",
			dataType : "json",
			success : function(data, status, jqXHR) {
				 //$("#popup_confirm").unbind('click');
				var chk = data.result;
				alert(chk);				
				selectList(ordrId);
				selectList1();
				popup_close();
				
			},
			error : function(jqXHR, status, errorThrown) {
				alert('ERROR: 관리자문의');

			}
		});
	}

 


</script>
</head>
<style>
#popup_wrap {width:90%; height:270px; background:#fff; border: solid 1px #666666; position:fixed; top:30%; left:5%; z-index:9999; display:none;} 

#mask {width:100%; height:100%; position:fixed; background:rgba(0,0,0,0.7) repeat; top:0; left:0; z-index:999; display:none;} 
.popup_content {margin-left:10px;}
.popup-cont01 {width:478px; margin: 40px auto; text-align: center;}
.popup-cont01 button { width: 138px; height: 36px; line-height: 36px; background: #9f2f60; color: #ffffff; text-align: center; border: none; font-size: 16px;}

#popup_open {
	display:none;
	}	

#whole {
	width: 1500px;
	position: center;
	margin-left: auto;
	margin-right: auto;
}

#header {
	position: center;
	width: 1500px;
	margin-left: auto;
	margin-right: auto;
}

h1 {
	font-family: "Trebuchet MS", Dotum, Arial;
	float: left;
	text-align: center;
	left: 50%;
}

h3 {
	font-family: "Trebuchet MS", Dotum, Arial;
	margin: 15px 0px;
}

#topMenu {
	height: 30px;
	width: 950px;
	text-align: center;
	float: left;
	margin-top: 40px;
}

#topMenu ul li {
	list-style: none;
	color: white;
	background-color: #2d2d2d;
	float: left;
	line-height: 30px;
	vertical-align: middle;
	text-align: center;
}

#topMenu .menuLink {
	text-decoration: none;
	color: white;
	display: block;
	width: 150px;
	font-size: 16px;
	font-weight: bold;
	font-family: "Trebuchet MS", Dotum, Arial;
	text-align: center;
}

#topMenu .menuLink:hover {
	color: #ff3;
	background-color: #4d4d4d;
}

#mainimg {
	float: left;
}

/* 날짜 */
.wrap_listsearch {
	display: block;
	padding: 14px 19px;
	border: 1px solid #ddd;
	background-color: #f9f9f9;
	zoom: 1;
	width: 750px;
	height: 100%;
}

.wrap_listsearch .fieldset {
	width: 750px;
	height: 100%;
}

.wrap_listsearch .tit_mypage {
	float: left;
	margin: 24px 0 24px 10px;
}

.wrap_listsearch .box_cont {
	float: left;
	margin-left: 20px;
}

.wrap_listsearch .box_cont .box_opt .btn_flexible03 .inner {
	min-width: 45px;
}

.wrap_listsearch .box_cont .box_radio, .wrap_listsearch .box_cont .box_opt
	{
	clear: both;
	display: block;
	overflow: hidden;
	padding: 5px 0;
}

.wrap_listsearch .box_radio .btn_label .inner {
	float: left;
	height: 100%;
	padding-left: 9px;
	font-size: 14px;
	line-height: 21px;
	color: #666;
	letter-spacing: 1px;
}

.wrap_listsearch .box_radio .on .inner {
	font-weight: bold;
	color: #F13;
}

.wrap_listsearch .box_opt select {
	height: 21px;
	border: 1px solid #ccc;
}

.wrap_listsearch .box_opt .txt {
	font-size: 12px;
	line-height: 21px;
	font-family: Gulim, '굴림';
	color: #666;
}

.wrap_listsearch .box_opt .opt_year {
	width: 68px;
}

.wrap_listsearch .box_opt .opt_month {
	width: 46px;
}

.wrap_listsearch .box_opt .opt_day {
	width: 46px;
}

.wrap_listsearch .box_opt .btn_flexible {
	margin-left: 5px;
	vertical-align: top
}



</style>
<body>
		<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header1.jsp">
		<jsp:param name="" value=""/>
</jsp:include>
		</div>
		<br> <br><br><br><br>
		<div id="whole">
		    <div id="title" style="text-align: center">
					<H3><B>판매 내역 확인 페이지</B></H3>
			</div>
		<div id="contents">
			<div id="search">
			<form name="ordrForm" action="" method="post">
			<div class="wrap_listsearch">
								<fieldset>
									<legend class="hide">조회기간 검색</legend>
									<strong class="tit_mypage tit_inquiry_period">조회기간</strong>
									<div class="box_cont">
										<div class="box_radio">
												<label id="search_period_7D"class="btn_label search_period fst on" onclick="selected_search_period('7D');">
												<input type="button" class="inner" value="1주일"></label>
												
												<label id="search_period_15D" class="btn_label search_period " onclick="selected_search_period('15D');">
												<input type="button" class="inner" value="15일"></label>
												
												<label id="search_period_1M" class="btn_label search_period " onclick="selected_search_period('1M');">
												<input type="button" class="inner" value="1개월"></label>
												
												<label id="search_period_3M" class="btn_label search_period lst " onclick="selected_search_period('3M');">
												<input type="button" class="inner" value="3개월"></label>
										</div>

										<div class="box_opt">

											<input type="hidden" id="startDate" name="startDate" value="">
											<input type="hidden" id="endDate" name="endDate" value="">

											<select id="search_start_year" name="search_start_year" class="opt">
												<option value="2010">2010</option>
												<option value="2011">2011</option>
												<option value="2012">2012</option>
												<option value="2013">2013</option>
												<option value="2014">2014</option>
												<option value="2015">2015</option>
												<option value="2016">2016</option>
												<option value="2017">2017</option>
												<option value="2018">2018</option>
											</select>
											<span class="txt">년</span>
											
											<select id="search_start_month" name="search_start_month" class="opt">
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
												<option value="9">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
											</select>
											<span class="txt">월</span>
											
											<select id="search_start_date" name="search_start_date" class="opt">
												<option value="1">01</option>
												<option value="2">02</option>
												<option value="3">03</option>
												<option value="4">04</option>
												<option value="5">05</option>
												<option value="6">06</option>
												<option value="7">07</option>
												<option value="8">08</option>
												<option value="9">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
												<option value="24">24</option>
												<option value="25">25</option>
												<option value="26">26</option>
												<option value="27">27</option>
												<option value="28">28</option>											
												<option value="29">29</option>
												<option value="30">30</option>
												<option value="31">31</option>
											</select>
											<span class="txt">일</span>									
											
											<span class="txt_bar"> ~ </span>


											<select id="search_end_year" name="search_end_year" class="opt">
												<option value="2010">2010</option>
												<option value="2011">2011</option>
												<option value="2012">2012</option>
												<option value="2013">2013</option>
												<option value="2014">2014</option>
												<option value="2015">2015</option>
												<option value="2016">2016</option>
												<option value="2017">2017</option>
												<option value="2018">2018</option>
											</select>
											<span class="txt">년</span>
											
											<select id="search_end_month"name="search_end_month" class="opt">
												<option value="1">01</option>
												<option value="2">02</option>
												<option value="3">03</option>
												<option value="4">04</option>
												<option value="5">05</option>
												<option value="6">06</option>
												<option value="7">07</option>
												<option value="8">08</option>
												<option value="9">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
											</select>
											<span class="txt">월</span>
											
											<select id="search_end_date" name="search_end_date" class="opt">
												<option value="1">01</option>
												<option value="2">02</option>
												<option value="3">03</option>
												<option value="4">04</option>
												<option value="5">05</option>
												<option value="6">06</option>
												<option value="7">07</option>
												<option value="8">08</option>
												<option value="9">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
												<option value="24">24</option>
												<option value="25">25</option>
												<option value="26">26</option>
												<option value="27">27</option>
												<option value="28">28</option>
												<option value="29">29</option>
												<option value="30">30</option>
												<option value="31">31</option>
											</select>
											<span class="txt">일</span>
										</div>
									</div>
								</fieldset>
							</div>
				<label class="w3-label">주문id</label>&nbsp;&nbsp;<input type="text" name="ordrId1" id="ordrId1">&nbsp; 
				<label class="w3-label">소매처이름</label>&nbsp;&nbsp;<input type="text" name="ptnrNm" id="ptnrNm">&nbsp;&nbsp;
				<label class="w3-label">부품명</label>&nbsp;&nbsp;<input type="text" name="productNm" id="productNm">&nbsp;&nbsp;
				<input type="button" value="검색" id="doSearch"><br>
				<!-- a href="" class="w3-btn w3-blue-grey">1주</a> 
				<a href="" class="w3-btn w3-blue-grey">1달</a> 
				<a href="" class="w3-btn w3-blue-grey">3달</a> 
				&nbsp;&nbsp;<input id="datepicker" type="text" value="2017-11-17" />~
				<input id="datepicker1" type="text" value="2017-11-17" /> -->
			</form>
			</div>
			<div id="buttons">
			<input type="button" value="선택확인" id="selectConfirm">
			</div>
		
			<table border='1'
				class="table table-striped table-bordered table-hover" id="list">
				<thead>
				<tr>
					<th><input type="checkbox" name="chkAll" id="chkAll" value="" /></th>
					<th class="w3-blue-grey">주문번호</th>
					<th class="w3-blue-grey">주문시간</th>
					<th class="w3-blue-grey">소매처ID</th>
					<th class="w3-blue-grey">소매처이름</th>
					<th class="w3-blue-grey">부품ID</th>
					<th class="w3-blue-grey">부품명</th>
					<th class="w3-blue-grey">제조사</th>
					<th class="w3-blue-grey">현재재고</th>
					<th class="w3-blue-grey">수량</th>
					<th class="w3-blue-grey">단가</th>
					<th class="w3-blue-grey">개당가격</th>
					<th class="w3-blue-grey">총합</th>
					<th class="w3-blue-grey">영업이익</th>
					<th class="w3-blue-grey">현재상황</th>
				</tr>
				</thead>
				<tbody>
				<%
					for (Map<String,Object> row : ordrList ){
				
						String isEnable = "disabled";
						
						if (row.get("status") != null && row.get("status").equals("1101")) {
							isEnable = "";
						}
				%>
				
				<tr class="temp">
				
					<td><input type="checkbox" name="chk" <%= isEnable %> /></td>
					<td><%=row.get("ordrId") %></td>
					<td><%=row.get("ordrDate") %></td>
					<td><%=row.get("ptnrId") %></td>
					<td><%=row.get("ptnrNm")%></td>
					<td><%=row.get("productId") %></td>
					<td><%=row.get("productNm") %></td>
					<td><%=row.get("ptnrNm2")%></td>
					<td><%=row.get("rstock") %></td>
					<td><%=row.get("amnt") %></td>
					<td><%=row.get("unitPrice") %></td>
					<td><%=row.get("salesCost") %></td>
					<td><%=row.get("total") %></td>
					<td><%=row.get("profit") %></td>
					<td><%=row.get("status")%></td>
				</tr>
				<%
					}
				%>
				</tbody>
			</table>

			
		</div>
		
	
		<div style="text-align: center">
			<H3>
				<B>출고내역</B>
			</H3>
		</div>
		<div id="contents">
		<div>
				
		<input type ="button" id="popup_open" value="출고등록">		
		<input type ="hidden" id="ordrId" name = "ordrId" value = "">
		
		
		</div>
		<form name="frm" action="<%=contextPath%>/ordr/ordroutgoingModify.do" method="post">
			<table border='1'
				class="table table-striped table-bordered table-hover" id="list1">
				<thead>
				<tr>

					<th class="w3-blue-grey">주문번호</th>
					<th class="w3-blue-grey">출고차수</th>
					<th class="w3-blue-grey">출고시간</th>
					<th class="w3-blue-grey">부품ID</th>
					<th class="w3-blue-grey">부품명</th>
					<th class="w3-blue-grey">제조사</th>
					<th class="w3-blue-grey">현재재고</th>
					<th class="w3-blue-grey">판매수량</th>
					<th class="w3-blue-grey">출고수량</th>
					<th class="w3-blue-grey">판매가격</th>
				</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
			</form>
			</div>
		</div>
		<!-- 출고등록 popup -->
	<div id="popup_wrap">
		<div id="popup_title">		
			<h2>[<span></span>] 판매에 대한 [<span></span>]에서의 출고 등록</h2>
		</div>
		<div class="popup_content">
			<table border='1' class="table table-striped table-bordered table-hover" id="popup_table">
				<thead>
					<tr>
						<th>부품ID</th>
						<th>부품명</th>
						<th>총 판매수량</th>
						<th>남은 판매수량</th>
						<th>출고수량</th>						
					</tr>
				</thead>
				<tbody>
				</tbody>		
			</table>
			<input type = "hidden" id="ogCount" value="">			
		</div>		
		<div class="popup-cont01">      
			<button id="popup_confirm">확인</button> 
        	<button id="popup_close">닫기</button> 
  		</div> 
	</div> 
	<div id="mask"></div> 
	<form name="form" method="post" action="<%=contextPath%>/ordr/updateConfirm.do">
		<input type="hidden" name="ordrId" value="">
		<input type ="hidden" id="prdId" name = "prdId" value = "">
	</form>
	<form name="changeQtyForm" method="post" id="changeQtyForm" action="<%=contextPath%>/ordr/ordroutgoingModify.do">
		<input type="hidden" name="amnt2" id="changeQtyFormAmnt2" value="">
		<input type="hidden" name="ordrId" id="changeQtyFormOrdrId" value="">
		<input type="hidden" name="productId" id="changeQtyFormProductId" value="">
		<input type="hidden" name="count" id="changeQtyFormCount" value="">
	</form>
</body>
</html>