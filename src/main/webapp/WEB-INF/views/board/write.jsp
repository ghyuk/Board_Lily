<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script>
    $(document).ready(function(){
    		$("#btnReset").click(function(){
    			window.location = "${path}/list.do";
    		})
        $("#btnSave").click(function(){
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
            
            
            /* var form = $('form')[0];
            var formData = new FormData(form);
            $.ajax({
            		url: '/insert.do',
            		data: formData,
            		processData: false,
            		contentType: false,
            		type:'POST',
            		success: function(data){
            			alert('Upload success');
            			
            		},
            		fail: function(data){
            			alert("Upload Fail");
            		}
            }); */
            document.form1.submit();
            
        });
    		
    });
</script>
</head>
<body>

<h2>게시글 작성</h2>
<form name="form1" method="post" action="${path}/insert.do" enctype="multipart/form-data">
    <div>
        제목
        <input width="300px" name="title" id="title" size="80" placeholder="제목을 입력해주세요">
         이름
        <input width="300px" name="writer" id="writer" placeholder="이름을 입력해주세요">
    </div>
    <div>
        내용
        <textarea name="content" id="content" rows="4" cols="80" placeholder="내용을 입력해주세요"></textarea>
    </div>
    <div>
       
    </div>
     <input type="file" name="file">
    <div style="width:650px; text-align: center;">
        <button type="button" id="btnSave">확인</button>
        <button type="button" id="btnReset">취소</button>
  
    </div>
</form>
</body>
</html>
