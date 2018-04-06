<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 목록</title>
<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script>
    $(document).ready(function(){
        $("#btnWrite").click(function(){
            // 페이지 주소 변경(이동)
            location.href = "${path}/write.do";
        });
    });
</script>
</head>
<body>
<h2>게시글 목록</h2>
<table border="1" width="600px">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>이름</th>
        <th>작성일</th>
        <th>조회수</th>
    </tr>
    <c:forEach var="row" items="${list}">
    <tr>
        <td>${row.bno}</td>
        <td><a href="${path}/view.do?bno=${row.bno}">${row.title}</a></td>
        <td>${row.writer}</td>
        <td>
            <!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
            <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd"/>
        </td>
        <td>${row.viewcnt}</td>
    </tr>    
    </c:forEach>
</table>
<div style="width: 600px">
<div align="right">
<button type="button" id="btnWrite" >글쓰기</button>
</div>
</div>
</body>
</html>
