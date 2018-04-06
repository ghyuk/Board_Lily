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
    <div>        <!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
        작성일자 : <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/>
                <!-- 날짜 형식 => yyyy 4자리연도, MM 월, dd 일, a 오전/오후, HH 24시간제, hh 12시간제, mm 분, ss 초 -->
    </div>
    <div>
        조회수 : ${dto.viewcnt}
    </div>
    <div>
        제목
        <input name="title" id="title" size="80" value="${dto.title}" placeholder="제목을 입력해주세요">
    </div>
    <div>
        내용
        <textarea name="content" id="content" rows="4" cols="80" placeholder="내용을 입력해주세요">${dto.content}</textarea>
    </div>
    <div>
        이름
        <input name="writer" id="writer" value="${dto.writer}" placeholder="이름을 입력해주세요">
    </div>
    <div>
    		첨부파일
    		<a href="#" name="file" id="file" >"${dto.oriFile}"</a>
    </div>
    <div style="width:650px; text-align: center;">
        <!-- 게시물번호를 hidden으로 처리 -->
        <input type="hidden" name="bno" id="bno" value="${dto.bno}">
        <input type="hidden" name="serFile" id="serFile" value="${dto.serFile }"/>
        <input type="hidden" name="oriFile" id="oriFile" value="${dto.oriFile }"/>
        <button type="button" id="btnUpdete">수정</button>
        <button type="button" id="btnDelete">삭제</button>
        <input type="button" id="list" value="목록">
    </div>
</form>

</body>
</html>
