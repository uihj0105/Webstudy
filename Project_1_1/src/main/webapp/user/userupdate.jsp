<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>CodePen - Login to Everdwell</title>
<link rel="stylesheet" href="../shadow/css/shadowbox.css">
<script type="text/javascript" src="../shadow/js/shadowbox.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Raleway'>
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="../etc/user/userupdate.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
Shadowbox.init({
	players:['iframe']
})
$(function(){	
	$('#postBtn').click(function(){
		Shadowbox.open({
			content:'../user/post.do',
			player:'iframe',
			title:'우편번호 검색',
			width:490,
			height:350
		})
	})
	$('#updateBtn').click(function(){
		let userID=$('#updateBtn').attr("data-update");
		let update_hno=$('#update_hno').attr("data-update-hno");
		if(update_hno.trim()==="0")
		{
			$('#update_hno').select();   //focus 이동하면서 입력한게 블록으로 선택됨
			return;
		}
		  
		let update_hintA=$('#update_hintA').attr("data-update-hintA")
		if(update_hintA.trim()==="0")
		{
			$('#update_hintA').focus();
			return;
		}
		$.ajax({
			type:'post',
			url:'../user/update_ok.do',
			data:{"update_hno":hno,"update_hintA":hintA},
			success:function(result)
			{
				let res=result.trim()
				if(res==='NO')
				{
					alert("질문이나 질문에 대한 답을 다시 입력해주세요.")
					$('#update_hintA').val("")
					$('#update_hno').select();
				}
				else
				{
					alert("회원 정보를 수정했습니다.")
					setTimeout("location.href='../main/main.do'",1000);
				}
			}
		})
	})
})
function update_check()
{
	if(ufrm.update_pwd1.value.length==0)
	{
		alert("비밀번호를 입력하세요.");
		ufrm.update_pwd1.focus();
		return false;
	}
	
	if(ufrm.update_pwd2.value.length==0)
	{
		alert("비밀번호 확인을 입력하세요.");
		ufrm.update_pwd2.focus();
		return false;
	}
	
	//if(ufrm.update_pwd1.value.length != ufrm.update_pwd2.value.lengh)
	//{
	//	alert("비밀번호가 일치하지 않습니다.");
	//	ufrm.update_pwd1.select();
	//	return false;
	//}
	
	if(ufrm.update_phone.value.length==0)
	{
		alert("전화번호를 입력하세요.");
		ufrm.update_pwd1.focus();
		return false;
	}
	
	if(ufrm.update_hno.value.length==0 || ufrm.update_hintA.value.length==0)
	{
		alert("질문을 입력하세요.");
		ufrm.update_hintA.focus();
		return false;
	}
}
// 질문 , 답 맞아야 수정가능

</script>
</head>
<body>
<form id="update_form" name="ufrm">
  <div class="heading">회원정보 수정</div>
  <div class="left">
    <input type="text" value="${uvo.userID }" name="update_id" id="update_id" style="margin-top:7%" readonly>
    <input type="password" placeholder="새 비밀번호" name="update_pwd1">
    <input type="password" placeholder="새 비밀번호 확인" name="update_pwd2">
    <input type="text" value="${uvo.name }" name="update_name" readonly>
    <c:if test="${uvo.email!=null }">
      <input type="email" value="${uvo.email }" name="update_email">
    </c:if>
    <c:if test="${uvo.email==null }">
      <input type="email" placeholder="이메일" name="update_email">
    </c:if>
    <input type="text" value="${uvo.post }" name="update_post" id="update_post" style="float:left;width:45.7%;" readonly>
    <input type=button value="우편번호검색" id="postBtn" style="cursor:pointer;width:23%;">
    <input type="text" value="${uvo.addr1 }" id="update_addr1" name="update_addr1" readonly>
    <c:if test="${uvo.addr2!=null }">
      <input type="text" value="${uvo.addr2 }" name="update_addr2" id="update_addr2">
    </c:if>
    <c:if test="${uvo.addr2==null }">
      <input type="text" placeholder="상세주소" name="update_addr2" id="update_addr2">
    </c:if>
    <input type="text" value="${uvo.phone }" name="update_phone" id="update_phone">
	<div class="row">
      <div class="col-half1" style="width:284px">
        <h2 style="margin-left:36.5%;margin-top:13%;">생년월일</h2>
          <div class="col-third">
            <input type="date" name="update_birthday" value="${uvo.birth }"style="margin-left:36.5%;width:180px;color:black" readonly>
          </div>
      </div>
      <div class="col-half1" style="width:380px">
        <h2 style="margin-top:9%;margin-left:13%;">성별</h2>
        <br>
        <c:if test="${uvo.gender!=null }">
        <c:if test="${uvo.gender=='남자' }">
          <input id="gender-male" type="radio" name="update_gender" value="남자" checked readonly>
          <label for="gender-male" id="male" style="cursor:pointer;color:black">남자</label>
          <input id="gender-female" type="radio" name="update_gender" value="여자" readonly>
          <label for="gender-female" id="female" style="cursor:pointer;color:black">여자</label>
        </c:if>
        <c:if test="${uvo.gender=='여자' }"> 
          <input id="gender-male" type="radio" name="update_gender" value="남자" readonly>
          <label for="gender-male" id="male" style="cursor:pointer;color:black">남자</label>
          <input id="gender-female" type="radio" name="update_gender" value="여자" checked readonly>
          <label for="gender-female" id="female" style="cursor:pointer;color:black">여자</label>
		</c:if>
		</c:if>
		<c:if test="${uvo.gender==null }">
		  <input id="gender-male" type="radio" name="update_gender" value="남자">
          <label for="gender-male" id="male" style="cursor:pointer;color:black" checked>남자</label>
          <input id="gender-female" type="radio" name="update_gender" value="여자">
          <label for="gender-female" id="female" style="cursor:pointer;color:black" checked>여자</label>
		</c:if>
       </div>
      </div>
    <h2 style="margin-left:14%;margin-top:6%">계정 확인 QnA</h2>
     <select style="cursor:pointer;width:70%;margin-left:14%" name="update_hno" id="update_hno" data-update-hno="${sessionScope.hno }">
       <option selected>질문선택</option>
       <c:forEach var="uvo" items="${hList}" varStatus="s">
         <option value="${s.index+1 }">${uvo }</option>
       </c:forEach>
     </select>
    <input type="text" placeholder="질문에 대한 답" id="update_hintA" name="update_hintA" data-update-hintA="${sessionScope.hintA }">
      <input type="button" value="수정" onclick="return update_check()" id="updateBtn" name="updateBtn" 
         data-update="${sessionScope.email }" style="cursor:pointer;float:left;margin-left:14%">
      <input type="button" onclick="javascript:history.back()" value="취소" style="cursor:pointer;margin-left:30%">
    <br><br><br>
    <h2 style="margin-left:5%">이용 약관</h2>
      <input id="terms" type="checkbox">
      <label for="terms" style="cursor:pointer;margin-left:5%">실명 인증된 아이디로 가입, 위치기반서비스 이용약관, 이벤트・혜택 정보 수신 동의를 포함합니다.</label>
      <br><br>
  </div>
</form>
<!-- partial -->
</body>
</html>