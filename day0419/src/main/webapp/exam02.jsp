<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String username = "c##madang";
	String password = "madang";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	int newOrderId = 1;

	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, username, password);

		// 1. 가장 큰 ORDERID 구하기
		String maxSql = "select max(orderid) maxid from orders";
		pstmt = conn.prepareStatement(maxSql);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			newOrderId = rs.getInt("maxid") + 1;
		}
		rs.close();
		pstmt.close();
	%>

	<h2>주문 등록</h2>
	<form action="exam02_insertOrder.jsp" method="post">
		<label>주문번호: <input type="text" name="orderid"
			value="<%=newOrderId%>" readonly>
		</label><br>
		<br> <label>도서명: <select name="bookid">
				<%
				// 2. 도서 목록 불러오기
				String bookSql = "select bookid, bookname from book";
				pstmt = conn.prepareStatement(bookSql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
				%>
				<option value="<%=rs.getInt("bookid")%>"><%=rs.getString("bookname")%></option>
				<%
				}
				rs.close();
				pstmt.close();
				%>
		</select>
		</label><br>
		<br> <label>고객명: <select name="custid">
				<%
				// 3. 고객 목록 불러오기
				String custSql = "select custid, name from customer";
				pstmt = conn.prepareStatement(custSql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
				%>
				<option value="<%=rs.getInt("custid")%>"><%=rs.getString("name")%></option>
				<%
				}
				rs.close();
				pstmt.close();
				conn.close();
				%>
		</select>
		</label><br>
		<br> <label>판매가: <input type="number" name="saleprice">
		</label><br>
		<br> <label>주문일: <input type="date" name="orderdate">
		</label><br>
		<br>

		<button type="submit">주문 등록</button>
	</form>

	<%
	} catch (Exception e) {
	out.println("에러 발생: " + e.getMessage());
	}
	%>

</body>
</html>
