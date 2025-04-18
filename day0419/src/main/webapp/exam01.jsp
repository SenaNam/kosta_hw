<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String publisher = request.getParameter("publisher");
	
	System.out.print(publisher);
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String username = "c##madang";
	String password = "madang";
	String sql = "select b.bookid, b.bookname, b.price, b.publisher, o.orderid, o.saleprice,o.orderdate from book b, orders o where b.bookid = o.bookid and b.publisher=? and TO_CHAR(o.orderdate,'YYYY/MM/DD') = '2025/03/21'";

	try {
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, username, password);
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, publisher);

		ResultSet rs = pstmt.executeQuery();
	%>
	<table border="1">
		<tr>
			<th>도서ID</th>
			<th>도서명</th>
			<th>가격</th>
			<th>출판사</th>
			<th>주문ID</th>
			<th>판매가격</th>
			<th>주문일</th>
		</tr>


		<%
		while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getInt("bookid")%></td>
			<td><%=rs.getString("bookname")%></td>
			<td><%=rs.getInt("price")%></td>
			<td><%=rs.getString("publisher")%></td>
			<td><%=rs.getInt("orderid")%></td>
			<td><%=rs.getInt("saleprice")%></td>
			<td><%=rs.getString("orderdate")%></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	rs.close();
	pstmt.close();
	conn.close();

	} catch (Exception e) {
	out.println("예외발생: " + e.getMessage());
	}
	%>

</body>
</html>