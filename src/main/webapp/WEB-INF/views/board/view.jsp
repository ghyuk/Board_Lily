<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script>
    $(document).ready(function(){
    	
    		$("#file").click(function(){
    			var bno = $("#bno").val();
    			var oriFile = $("#oriFile").val();
    			var serFile = $("#serFile").val();
    			window.location = "${path}/downloadFile.do?oriFile="+oriFile+"&&serFile="+serFile;
    			
    		})
    		
    	
    		$("#list").click(function(){
    			window.location = "${path}/list.do";
    		})
    	
        $("#btnDelete").click(function(){
            if(confirm("삭제하시겠습니까?")){
                document.form1.action = "${path}/delete.do";
                document.form1.submit();
            }
        });
        
        $("#btnUpdete").click(function(){
            //var title = document.form1.title.value; ==> name속성으로 처리할 경우
            //var content = document.form1.content.value;
            //var writer = document.form1.writer.value;
            var title = $("#title").val();
            var content = $("#content").val();
            var writer = $("#writer").val();
            if(title == ""){
                alert("제목을 입력하세요");
                document.form1.title.focus();
                return;
            }
            if(content == ""){
                alert("내용을 입력하세요");
                document.form1.content.focus();
                return;
            }
            if(writer == ""){
                alert("이름을 입력하세요");
                document.form1.writer.focus();
                return;
            }
            document.form1.action="${path}/update.do"
            // 폼에 입력한 데이터를 서버로 전송
            document.form1.submit();
        });
     
    });
</script>
</head>
<body>

<h2>게시글 보기</h2>
<form name="form1" method="post">
<table border="1" width="600px">
	<tr>
		<th>제목</th>
		<td><input name="title" id="title" size="80" value="${dto.title}" placeholder="제목을 입력해주세요"></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><input name="writer" id="writer" value="${dto.writer}" placeholder="이름을 입력해주세요"></td>
	</tr>
	<tr>
		<th>작성일자</th>
		<td><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
	</tr>
	<tr>
		<th>조회수</th>
		<td>${dto.viewcnt}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="content" id="content" rows="4" cols="80" placeholder="내용을 입력해주세요">${dto.content}</textarea></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td><a href="#" name="file" id="file" >"${dto.oriFile}"</a></td>
	</tr>
	<tr>
	<td><input type="button" id="btnUpdete" value="수정">
        <input type="button" id="btnDelete" value="삭제">
        <input type="button" id="list" value="목록"></td>
	</tr>
</table>
    
 	<div>
        <!-- 게시물번호를 hidden으로 처리 -->
        <input type="hidden" name="bno" id="bno" value="${dto.bno}">
        <input type="hidden" name="serFile" id="serFile" value="${dto.serFile }"/>
        <input type="hidden" name="oriFile" id="oriFile" value="${dto.oriFile }"/>
    </div>
</form>

</body>
</html>
