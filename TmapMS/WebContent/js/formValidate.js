/*
 * 작성자 : 이승구
 * 작성일 : 2010-11-24
 * 수정자 :
 * 수정일 :
 *
 * [validate 사용법]
 * 유효성검사가 필요한 input 요소에 해당하는 class를 추가해준다.
 *
 * error시 띄워주는 경고메시지창에 써줄 element 이름은 title을 기준으로 가져오며,
 * title값이 없을경우 해당 element의 id와 동일한 '<label for=' 값을 찾는다.
 * 만약 둘 다 없을경우 "" 값이 되니 폼 작성시 주의해야한다.
 *
 * 폼 전송시 예제와 같이 호출하여 유효성검사 error 발생 시 return false 가 되도록 한다.
 * ex) function doSubmit() { // submit 발생시 호출할 function
 *        if(!validate()) { return false; }
 *        // 유효성검사 성공시 submit전에 처리할 코드가 있다면 작성...
 *     }
 * ex2) jQuery 사용시
 * 		'form객체'.submit(function() {
 * 			if(!validate()) { return false; }
 * 			// 유효성검사 성공시 submit전에 처리할 코드가 있다면 작성...
 * 		});
 *
 * [지원되는 유효성검사 목록]
 * validate-req			: 필수입력
 * validate-digits		: 숫자만 입력
 * validate-tel-num		: 전화번호 형식(하이픈 '-' 포함 형식)
 * validate-telnum		: 전화번호 형식(하이픈 제외 형식)
 * validate-email		: 이메일 형식
 * validate-ssn			: 주민등록번호 형식
 * validate-companyno	: 사업자등록번호 형식
 * validate-birth		: 생년월일 형식 (820224)
 *
 * 필요할 경우 추가할것~
 */
function formValidate(obj) {
	var formElements = obj.elements;
	var hashSet = new Object();
	var key, element;
	var message = "";
	for ( var i = 0; i < formElements.length; i++) {
		element = formElements[i];
		key = element.id;
		if (key != null && key) {
			hashSet[i] = element;
			message += "id : " + key + ", value : " + element.value + "\n";
		}
	}
	var test = true;
	$.each( hashSet, function(i, o){
	
		var val = $(o).val();
		var classNames = $(o).attr('class');
		var objName = $(o).attr('title') != "" ? $(o).attr('title') : $('label[for='+$(o).attr('id')+']').text();
		
		
		
		if(/validate-req/.test(classNames)) { // 필수입력
			if(!val) {
				if(objName === undefined){
					alert("모든 항목은 필수입력 사항 입니다. 올바른 정보를 입력해 주세요.");
				}else{
				alert(objName+"(은)는 반드시 입력하셔야 합니다.");
				}
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-digits/.test(classNames)) { // 숫자만 입력
			if(isNaN(val) || /[^\d]/.test(val)) {
				var objName = $(o).attr('title') != "" ? $(o).attr('title') : $('label[for='+$(o).attr('id')+']').text();
				alert(objName+"(은)는 숫자만 입력하셔야 합니다.");
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-password/.test(classNames)) { // 숫자만 입력
      if(isNaN(val) || /[^\d]/.test(val)) {
        var objName = $(o).attr('title') != "" ? $(o).attr('title') : $('label[for='+$(o).attr('id')+']').text();
        alert(objName+"(은)는 숫자만 입력하셔야 합니다.");
        $(o).focus();
        test = false;
        return false;
      }
    }
		if(/validate-tel-num/.test(classNames)) { // 전화번호 형식(하이픈 제외)
			var pattern = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;

			if(!pattern.test(val)){
				alert(objName+"(은)는 형식이 올바르지 않습니다.\n하이픈(-)을 포함하여 입력해 주십시오.");
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-telnum/.test(classNames)) { // 전화번호 형식(하이픈 포함)
			var pattern = /^[0-9]{9,11}$/;

			if(!pattern.test(val)){
				alert(objName+"(은)는 형식이 올바르지 않습니다.\n숫자만 입력해 주십시오.");
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-email/.test(classNames)) { // 이메일 형식
			var pattern = /\w{1,}[@][\w\-]{1,}([.]([\w\-]{1,})){1,3}$/;

			if(!pattern.test(val)) {
				alert(objName+"(은)는 바른 이메일 주소를 입력하셔야 합니다.");
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-ssn/.test(classNames)) { // 주민등록번호 형식(하이픈 '-' 제외)
			var pattern = /(^[0-9]{13}$)/;

			if (!pattern.test(val)) {
				alert("주민등록번호를 13자리 숫자로 입력하십시오.");
				$(o).focus();
				test = false;
				return false;
			} else  {
				var sum_1 = 0;
				var sum_2 = 0;
				var at=0;
				var juminno= val;
				sum_1 = (juminno.charAt(0)*2)+
						(juminno.charAt(1)*3)+
						(juminno.charAt(2)*4)+
						(juminno.charAt(3)*5)+
						(juminno.charAt(4)*6)+
						(juminno.charAt(5)*7)+
						(juminno.charAt(6)*8)+
						(juminno.charAt(7)*9)+
						(juminno.charAt(8)*2)+
						(juminno.charAt(9)*3)+
						(juminno.charAt(10)*4)+
						(juminno.charAt(11)*5);
				sum_2 = sum_1 % 11;

				if (sum_2 == 0)
					at = 10;
				else  {
					if (sum_2 == 1)
						at = 11;
					else
						at = sum_2;
				}
				att = 11 - at;

				if (juminno.charAt(12) != att ||
					juminno.substr(2,2) < '01' ||
					juminno.substr(2,2) > '12' ||
					juminno.substr(4,2) < '01' ||
					juminno.substr(4,2) > '31' ||
					juminno.charAt(6) > 4)
				{
					alert("올바른 주민등록번호가 아닙니다.");
					$(o).focus();
					test = false;
					return false;
				}
			}
		}
		if(/validate-companyno/.test(classNames)) { // 사업자 등록번호 형식 (하이픈 '-' 제외)
			var pattern = /(^[0-9]{10}$)/;

			val = val.replace(/-/g, "");

			if (!pattern.test(val))  {
				alert("사업자등록번호를 10자리 숫자로 입력하십시오.");
				$(o).focus();
				test = false;
				return false;
			} else {
				var sum = 0;
				var at = 0;
				var att = 0;
				var saupjano= val;
				sum = (saupjano.charAt(0)*1)+
					  (saupjano.charAt(1)*3)+
					  (saupjano.charAt(2)*7)+
					  (saupjano.charAt(3)*1)+
					  (saupjano.charAt(4)*3)+
					  (saupjano.charAt(5)*7)+
					  (saupjano.charAt(6)*1)+
					  (saupjano.charAt(7)*3)+
					  (saupjano.charAt(8)*5);
				sum += parseInt((saupjano.charAt(8)*5)/10);
				at = sum % 10;
				if (at != 0)
					att = 10 - at;

				if (saupjano.charAt(9) != att)  {
					alert("올바른 사업자등록번호가 아닙니다.");
					$(o).focus();
					test = false;
					return false;
				}
			}
		}
		if(/validate-birth/.test(classNames)) { // 생년월일 형식 (820224)
			var pattern = /(^[0-9]{6}$)/;

			if (!pattern.test(val))	{
				alert("주민번호 앞자리 또는 생년월일 형식은 6자리 숫자로 입력하십시오.");
				$(o).val('');
				$(o).focus();
				test = false;
				return false;
			} else {
				var y = Number(val.substring(0,2));
				var m = Number(val.substring(2,4));
				var d = Number(val.substring(4,6));
				var bool = false;
				if(m > 12){
					bool = true;
				}
				if(d < 1 || d > 31){
					bool = true;
				}

				if(bool){
					alert("생년월일 형식이 올바르지 않습니다.");
					alert(val + "\n" + y + "\n"+ m + "\n" + d);
					$(o).focus();
					$(o).val('');
					test = false;
					return false;
				}
			}
		}
	});
	return test;	
}

function validatePWD(value){
  
  var result = false;
  // 비밀번호 유효성 검사
    // 입력값이 8자 이하인 경우
    if ( value.length < 10 )
    {
     msg = "비밀번호는 문자와 숫자를 조합하여 10자리 이상으로 입력하여야 합니다.";
     result = false;
    }
    // 입력값에 0~9를 제외한 문자가 포함되지 않은 경우, 즉 숫자만 입력된 경우
    else if ( value.match(/[^0-9]/g) == null )
    {
      msg = "비밀번호는 문자와 숫자를 조합하여 10자리 이상으로 입력하여야 합니다.";
     result = false;
    }
    // 입력값에 0~9에 해당하는 문자가 포함되지 않은 경우, 즉 문자만 입력된 경우
    else if ( value.match(/[0-9]/g) == null )
    {
      msg = "비밀번호는 문자와 숫자를 조합하여 10자리 이상으로 입력하여야 합니다.";
     result = false;
    }
    else
    {
     msg = "사용 가능한 비밀번호 입니다.";
     result = true;
    }
    
    // 동일한 문자가 4회 이상 반복되는 경우
    var val = value;
    var ch = '';
    var cnt = 0;
    for ( var i = 0 ; i < val.length ; i++ )
    {
     if ( ch == val.charAt(i) )
     {
      cnt++;
      
      if ( cnt > 3 )
      {
       msg = "동일한 문자가 4번이상 반복되었습니다.";
       result = false;
       break;
      }
     }
     else
     {
      ch = val.charAt(i);
      cnt = 1;
     }
    }
    alert(msg);
    return result;
}

function validate() {
	var test = true;
	
	$('.validate-req, .validate-digits, .validate-tel-num, .validate-email, validate-ssn, .validate-companyno, .validate-radio, .validate-password').each(function(i,o) {
		var val = $(o).val();
		var classNames = $(o).attr('class');
		var objName = $(o).attr('title') != "" ? $(o).attr('title') : $('label[for='+$(o).attr('id')+']').text();
		
		if(/validate-req/.test(classNames)) { // 필수입력
			if(!val) {
				if(objName === undefined){
					alert("모든 항목은 필수입력 사항 입니다. 올바른 정보를 입력해 주세요.");
				}else{
				alert(objName+"(은)는 반드시 입력하셔야 합니다.");
				}
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-digits/.test(classNames)) { // 숫자만 입력
			if(isNaN(val) || /[^\d]/.test(val)) {
				var objName = $(o).attr('title') != "" ? $(o).attr('title') : $('label[for='+$(o).attr('id')+']').text();
				alert(objName+"(은)는 숫자만 입력하셔야 합니다.");
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-password/.test(classNames)) { // password 확인
		  
//      if(isNaN(val) || !validatePWD(val)) {
//        var objName = $(o).attr('title') != "" ? $(o).attr('title') : $('label[for='+$(o).attr('id')+']').text();
//        alert(objName+"(은)영문, 숫자를 혼합하여 10자 이상 입력하세요.");
//        $(o).focus();
//        test = false;
//        return false;
//      }
		 return validatePWD(val); 
    }
		if(/validate-tel-num/.test(classNames)) { // 전화번호 형식(하이픈 제외)
			var pattern = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;

			if(!pattern.test(val)){
				alert(objName+"(은)는 형식이 올바르지 않습니다.\n하이픈(-)을 포함하여 입력해 주십시오.");
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-telnum/.test(classNames)) { // 전화번호 형식(하이픈 포함)
			var pattern = /^[0-9]{9,11}$/;

			if(!pattern.test(val)){
				alert(objName+"(은)는 형식이 올바르지 않습니다.\n숫자만 입력해 주십시오.");
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-email/.test(classNames)) { // 이메일 형식
			var pattern = /\w{1,}[@][\w\-]{1,}([.]([\w\-]{1,})){1,3}$/;

			if(!pattern.test(val)) {
				alert(objName+"(은)는 바른 이메일 주소를 입력하셔야 합니다.");
				$(o).focus();
				test = false;
				return false;
			}
		}
		if(/validate-ssn/.test(classNames)) { // 주민등록번호 형식(하이픈 '-' 제외)
			var pattern = /(^[0-9]{13}$)/;

			if (!pattern.test(val)) {
				alert("주민등록번호를 13자리 숫자로 입력하십시오.");
				$(o).focus();
				test = false;
				return false;
			} else  {
				var sum_1 = 0;
				var sum_2 = 0;
				var at=0;
				var juminno= val;
				sum_1 = (juminno.charAt(0)*2)+
						(juminno.charAt(1)*3)+
						(juminno.charAt(2)*4)+
						(juminno.charAt(3)*5)+
						(juminno.charAt(4)*6)+
						(juminno.charAt(5)*7)+
						(juminno.charAt(6)*8)+
						(juminno.charAt(7)*9)+
						(juminno.charAt(8)*2)+
						(juminno.charAt(9)*3)+
						(juminno.charAt(10)*4)+
						(juminno.charAt(11)*5);
				sum_2 = sum_1 % 11;

				if (sum_2 == 0)
					at = 10;
				else  {
					if (sum_2 == 1)
						at = 11;
					else
						at = sum_2;
				}
				att = 11 - at;

				if (juminno.charAt(12) != att ||
					juminno.substr(2,2) < '01' ||
					juminno.substr(2,2) > '12' ||
					juminno.substr(4,2) < '01' ||
					juminno.substr(4,2) > '31' ||
					juminno.charAt(6) > 4)
				{
					alert("올바른 주민등록번호가 아닙니다.");
					$(o).focus();
					test = false;
					return false;
				}
			}
		}
		if(/validate-companyno/.test(classNames)) { // 사업자 등록번호 형식 (하이픈 '-' 제외)
			var pattern = /(^[0-9]{10}$)/;

			val = val.replace(/-/g, "");

			if (!pattern.test(val))  {
				alert("사업자등록번호를 10자리 숫자로 입력하십시오.");
				$(o).focus();
				test = false;
				return false;
			} else {
				var sum = 0;
				var at = 0;
				var att = 0;
				var saupjano= val;
				sum = (saupjano.charAt(0)*1)+
					  (saupjano.charAt(1)*3)+
					  (saupjano.charAt(2)*7)+
					  (saupjano.charAt(3)*1)+
					  (saupjano.charAt(4)*3)+
					  (saupjano.charAt(5)*7)+
					  (saupjano.charAt(6)*1)+
					  (saupjano.charAt(7)*3)+
					  (saupjano.charAt(8)*5);
				sum += parseInt((saupjano.charAt(8)*5)/10);
				at = sum % 10;
				if (at != 0)
					att = 10 - at;

				if (saupjano.charAt(9) != att)  {
					alert("올바른 사업자등록번호가 아닙니다.");
					$(o).focus();
					test = false;
					return false;
				}
			}
		}
		if(/validate-birth/.test(classNames)) { // 생년월일 형식 (820224)
			var pattern = /(^[0-9]{6}$)/;

			if (!pattern.test(val))	{
				alert("주민번호 앞자리 또는 생년월일 형식은 6자리 숫자로 입력하십시오.");
				$(o).val('');
				$(o).focus();
				test = false;
				return false;
			} else {
				var y = Number(val.substring(0,2));
				var m = Number(val.substring(2,4));
				var d = Number(val.substring(4,6));
				var bool = false;
				if(m > 12){
					bool = true;
				}
				if(d < 1 || d > 31){
					bool = true;
				}

				if(bool){
					alert("생년월일 형식이 올바르지 않습니다.");
					alert(val + "\n" + y + "\n"+ m + "\n" + d);
					$(o).focus();
					$(o).val('');
					test = false;
					return false;
				}
			}
		}
	});
	return test;
}