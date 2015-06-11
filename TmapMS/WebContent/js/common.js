/*******************************************************************************
 * # CheckBox 전체 선택/해제 - disabled이면 체크/체크해제 하지 않는다.
 * <form name="ContentsForm" method="post">
 * <input type="checkbox" name="choiceAll" onclick="checkAll('ContentsForm','choiceAll', 'choice');"/>
 * <input type="checkbox" name="choice"/>
 ******************************************************************************/
function checkAll(formName, chkCtrl, chkBoxName) {// 체크박스 이름까지 기술한다. 예)
	var chkCtrl = eval("document." + formName + "." + chkCtrl);
	var chkBox = eval("document." + formName + "." + chkBoxName);
	if(chkCtrl.checked) {
		if (chkBox == undefined) {
			return;
		} else if (chkBox.length == undefined) {
			chkBox.checked = true;
		} else {
			for(var i = 0; i < chkBox.length; i++) {
				if (chkBox[i].disabled) {
					continue;
				}
				chkBox[i].checked = true;
			}
		}
	} else {
		if (chkBox == undefined) {
			return;
		} else if (chkBox.length == undefined) {
			chkBox.checked = false;
		} else {
			for(var i = 0; i < chkBox.length; i++) {
				if (chkBox[i].disabled) {
					continue;
				}
				chkBox[i].checked = false;
			}
		}
	}

}
/*******************************************************************************
 * # CheckBox 선택 유무
 ******************************************************************************/
function isChecked(formName, chkBoxName) {// 체크박스 이름까지 기술한다. 예)
											// exampleForm.exapleCheckBox
	var f = eval("document." + formName + "." + chkBoxName);
	
	if (f == undefined) {
		return false;
	} else if (f.length == undefined) {
		if(f.checked) {
			return true;
		}
	} else {
		for(var i = 0; i < f.length; i++) {
			if(f[i].checked) {
				return true;
			}
		}
	}

	return false;
}
/*******************************************************************************
 * # CheckBox 하나만 선택
 ******************************************************************************/
function onlyOne(checkBox, checkBoxName) {
	var obj = document.getElementsByName(checkBoxName);
	for (var i = 0; i < obj.length; i++) {
		if (obj[i] != checkBox) {
			obj[i].checked = false;
		}
	}
}
/*******************************************************************************
 * # location 설정
 ******************************************************************************/
function goToAction(actionName) {
	location.href = actionName + '.action';
}

function goToPageAction() {
	document.test.submit();
}

function goToLocation(actionName, currentPage) {
	location.href = actionName + '.action?currentPage='+currentPage;
}

function goToLocationParams(actionName, params) {// 조건절을 붙여준다.
													// 예)currentPage=1
	location.href = actionName + '.action?'+params;
}
/*******************************************************************************
 * # 
 ******************************************************************************/
if (document.all) {
	layerview='document.all';
	styleview='.style.';
}
else if (document.layers) {
	layerview='document.layers';
	styleview='.';
}

function show(){
	eval(layerview+'["Layer"]'+styleview+'visibility="visible"');
}
function hide(){
	eval(layerview+'["Layer"]'+styleview+'visibility="hidden"');
} 
function showTmapRS() {
	document.ContentsForm.target = "rsViewer";
	document.ContentsForm.action = document.ContentsForm.isConnectingFromTmapMS.value;
	document.ContentsForm.submit();
	
	eval(layerview+'["TmapRS"]'+styleview+'width='+document.body.scrollWidth);
	eval(layerview+'["TmapRS"]'+styleview+'height='+document.body.scrollHeight);
	eval(layerview+'["TmapRS"]'+styleview+'display=""');
}
function hideTmapRS() {
	eval(layerview+'["TmapRS"]'+styleview+'display="none"');
}
function pageLoading() {
	eval(layerview+'["pageLoading"]'+styleview+'width='+document.body.scrollWidth);
	eval(layerview+'["pageLoading"]'+styleview+'height='+document.body.scrollHeight);
	eval(layerview+'["pageLoading"]'+styleview+'display=""');
}
/*******************************************************************************
 * # 배경색 지정 기능
 ******************************************************************************/
function rowOnMouseOver(r) {
   r.style.backgroundColor = "#dcdcdc";
}

function rowOnMouseOut(r) {
	r.style.backgroundColor = "#FFFFFF";
}

function rowOnMouseOut2(r) {
	r.style.backgroundColor = "#F8F8F8";
}

function rowOnMouseOverColor(r, color) {
	r.style.backgroundColor = color;
}

function rowOnMouseOutColor(r, color) {
	r.style.backgroundColor = color;
}
var prev = null;
function rowOnClick(r) {
	if (prev == null) {
		prev = r;
		r.style.backgroundColor = "#dcdcdc";
	}
	
	if (prev != r) {
		prev.style.backgroundColor = "#FFFFFF";
		r.style.backgroundColor = "#dcdcdc";
		prev = r;
	}
}

/*******************************************************************************
 * # 아이디/비밀번호 확인창 - opener에서는 로그인 성공여부를 받을 수 있다.
 * - 확인창 띄우기 
 *   <input type="button" value="확인창 띄우기" onclick="openIdentityCheckForm();"/>
 * - opener에서 로그인 성공여부를 확인하는 방법
 * if (document.ContentsForm.identityState) {
 *   if(document.ContentsForm.identityState.value == 'Y') {
 *     alert('확인 완료');
 *   } else {
 *     alert('확인 실패');
 *   }
 * } else {
 *   alert('아이디/비밀번호 확인을 하지 않았습니다.');
 * }
 * - 아이디 확인 완료 후 다음 스크립트 실행하기
 *   <input type="hidden" name="nextScript" value="opener.executeSave(opener.document.ContentsForm);"/>
 ******************************************************************************/
function openIdentityCheckForm() {
	var windowWidth = 600;
	var windowHeight = 160;
	var openX = (screen.availWidth - windowWidth) / 2;
	var openY = (screen.availHeight - windowHeight) / 2;
	checkForm = window.open("IdentityCheckFormAction.action", "IdentityCheckForm", "top="+openY+",left="+openX+",width="+windowWidth+",height="+windowHeight+",location=no,directoryies=no,resizable=no,status=yes,toolbar=no,memubar=no", true);
}

/*******************************************************************************
 * # 전화번호에 - 붙이기
 * phoneFormat(document.ContentsForm.HP);
 ******************************************************************************/
function phoneFormat(obj) {
	var phone = obj.value;
	if (phone.indexOf('-') < 0) {
		var len = phone.length;
		if (len == 11) {
			//010 3221 2663
			obj.value = phone.substr(0, 3) + '-' + phone.substr(3, 4) + '-' + phone.substr(7, 4);
		} else if (len == 10) {
			//016 221 2663
			//02 2028 3434
			if (phone.substr(1, 1) == 2) {
				obj.value = phone.substr(0, 2) + '-' + phone.substr(2, 4) + '-' + phone.substr(6, 4);
			} else if (phone.substr(1, 1) > 2) {
				obj.value = phone.substr(0, 3) + '-' + phone.substr(3, 3) + '-' + phone.substr(6, 4);
			} else {
				obj.value = phone.substr(0, 3) + '-' + phone.substr(3, 3) + '-' + phone.substr(6, 4);
			}
		} else if (len == 9) {
			if (phone.substr(1, 1) == 2) {
				//02 852 3662
				obj.value = phone.substr(0, 2) + '-' + phone.substr(2, 3) + '-' + phone.substr(5, 4);
			}
		}
	}
}
/*******************************************************************************
 * # 숫자만 입력받기
 ******************************************************************************/
function onlyNumber() {
	// backspace(8),tab(9),del(46)
	if ( event.keyCode==8 || event.keyCode==9 || event.keyCode==46 ) return;
	// 숫자열 (0~9:48~57), 키패드 (0~9:96~105)
	else if ( event.keyCode >= 48 && event.keyCode <= 57 || event.keyCode >= 96 && event.keyCode <= 105) return;
	else event.returnValue = false;
}
