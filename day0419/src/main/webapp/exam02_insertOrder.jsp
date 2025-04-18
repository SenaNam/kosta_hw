<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

// 폼에서 전달받은 데이터
int orderid = Integer.parseInt(request.getParameter("orderid"));
int bookid = Integer.parseInt(request.getParameter("bookid"));
int custid = Integer.parseInt(request.getParameter("custid"));
int saleprice = Integer.parseInt(request.getParameter("saleprice"));
String orderdate = request.getParameter("orderdate");

System.out.print(orderdate);

// DB 연결 정보
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String username = "c##madang";
String password = "madang";

Connection conn = null;
PreparedStatement pstmt = null;

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, username, password);

	// INSERT 쿼리
	String sql = "insert into orders (orderid, custid, bookid, saleprice, orderdate) "
	+ "values (?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'))";

	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, orderid);
	pstmt.setInt(2, custid);
	pstmt.setInt(3, bookid);
	pstmt.setInt(4, saleprice);
	pstmt.setString(5, orderdate);

	int result = pstmt.executeUpdate();

	if (result > 0) {
%>
<h2>주문이 성공적으로 등록되었습니다!</h2>
<p>
	주문번호:
	<%=orderid%></p>
<p>
	고객ID:
	<%=custid%></p>
<p>
	도서ID:
	<%=bookid%></p>
<p>
	판매가:
	<%=saleprice%></p>
<p>
	주문일:
	<%=orderdate%></p>
<%
} else {
%>
<h2>주문 등록 실패!</h2>
<%
}

pstmt.close();
conn.close();
} catch (Exception e) {
out.println("예외 발생: " + e.getMessage());
}
%>
