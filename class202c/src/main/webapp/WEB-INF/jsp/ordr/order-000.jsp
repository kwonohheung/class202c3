<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>

<%
	//List<ProductVo> itemList = (List<ProductVo>) request.getAttribute("itemList");
	String productNm = (String)request.getAttribute("productNm");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ ����</title>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/jquery.scrollfollow.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="/class202c/css/w3.css">
</head>
<script>
$(function(){
	$('#namesearch').click(function(){
		document.productForm.submit();
	});

});
</script>

<style>
#whole {
	position: center;
	width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

h1 {
	font-family: "Trebuchet MS", Dotum, Arial;
	float: left;
	text-align: center;
	margin-left: 100px;
}

#topMenu {
	height: 30px;
	width: 850px;
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


</style>

<body>
	<div id="whole">
		<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header2.jsp">
		<jsp:param name="" value=""/>
		</jsp:include>
		</div>
		<div>
			<form name="frm" action="" method="post">
				<div style="text-align: center">
					<H3>
						<B>��ǰ��ȸ/����(������ ������)</B>
					</H3>
				</div>
				<div class="w3-container  w3-right-align  w3-margin">
					<table>
						<tr>
							<td><select name="isapproval" value="�з�">
									<option>�з�</option>
									<option value="Y">CPU</option>
									<option value="N">VGA</option>
									<option value="N">RAM</option>
									<option value="N">MAIN BOARD</option>
									<option value="N">HDD</option>
									<option value="N">SSD</option>
							</select>&nbsp;&nbsp;</td>
							<td><select name="isapproval" value="�ߺз�">
									<option>�ߺз�</option>
									<option value="Y">NVIDIA</option>
									<option value="N">AMD</option>
							</select>&nbsp;&nbsp;</td>
							<td><select name="isapproval" value="�Һз�">
									<option>�Һз�</option>
									<option value="Y">GTX 1000��</option>
									<option value="N">GTX 900��</option>
									<option value="N">GTX 800��</option>
									<option value="N">GTX 700��</option>
									<option value="N">GTX 600��</option>
							</select>&nbsp;&nbsp;</td>
							<td><select name="isapproval" value="���з�2">
									<option>���з�2</option>
									<option value="Y">1080TI</option>
									<option value="N">1080</option>
									<option value="N">1070</option>
									<option value="N">1060TI</option>
									<option value="N">1060</option>
									<option value="N">1050</option>
							</select>&nbsp;&nbsp;</td>
							<td><select name="isapproval" value="�������з�">
									<option>�������з�</option>
									<option value="Y">1080TI</option>
									<option value="N">1080</option>
									<option value="N">1070</option>
									<option value="N">1060TI</option>
									<option value="N">1060</option>
									<option value="N">1050</option>
							</select></td>
						</tr>
					</table>
				</div>
				<br> <br> <div class="w3-container  w3-left-align  w3-margin">
						<form name="search" action="" method="post">
							<input type="text" name="productNm" value="<%=productNm%>">
							<input type="button" value="�˻�" id="nameSearch">
						</form>	
					</div>	
				<div class="w3-container  w3-right-align  w3-margin">
					<a href="" class="w3-btn w3-blue-grey">��ٱ���Ȯ��</a> <a href=""
						class="w3-btn w3-blue-grey">�ֹ�������ȸ</a>
				</div>
				<table border='1'
					class="table table-striped table-bordered table-hover">
					<tr>
						<th class="w3-blue-grey"><input type="checkbox"
							name="headerChk" value="" /></th>

						<th class="w3-blue-grey">��ǰID</th>
						<th class="w3-blue-grey">��ǰ��</th>
						<th class="w3-blue-grey">������</th>
						<th class="w3-blue-grey">�з�</th>
						<th class="w3-blue-grey">������</th>
						<th class="w3-blue-grey">�ǸŰ���</th>
						<th class="w3-blue-grey">���ż���</th>
						<th class="w3-blue-grey">���</th>
					</tr>

					<%
				//		for (ProductVo row : itemList) {
					%>
					<tr class="temp">
						<td><input type="checkbox" name="chk" value="" /></td>
						<td></td>
						<td><a href = "<%-- <%=contextPath%>/purchase/itemDetail.do?productId=<%=row.getProductId()%> --%>"></a></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><input type="number" name="amount" id="amount" value="0"></td>
						<td><input type="submit" id="damgi" value="���" class="w3-btn w3-blue-grey"></td>
					</tr>
					<%
				//		}
					%>
				</table>
			</form>
		</div>
	</div>
</body>

</html>