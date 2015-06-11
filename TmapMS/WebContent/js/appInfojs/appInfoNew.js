$(document).ready(function() {
	
});

function excuteSave() {
	
	if($("#appName").val() == ""){
		alert("App명은 필수 입력 사항입니다.");
		return;
	}
	if($("#appVerName").val() == ""){
		alert("버전명은 필수 입력 사항입니다.");
		return;
	}
	
	if (confirm("등록하시겠습니까?")) {
		ContentsForm.action = "appInfoInsert.do";
		ContentsForm.submit();
	}
}
