/**
 * 회원 업데이트 관련 자바스크립트
 */

///////////////////////////////////////////////////////////////////////////////////////////////////////

//이메일 조합 및 연락처 조합
function combineEmail() {
   
   alert("업데이트 combineEmail 시작");
   
   var email1 = document.getElementById("email1");
   var email2 = document.getElementById("email2");
   var email3 = document.getElementById("email3");
   var email = document.getElementById("email");
   
   // 사용자 이메일 도메인(非포털)
   if (email2.value == "직접 입력") {
      email.value = email1.value.trim() 
                  + "@" 
                  + email3.value.trim();
      alert("email_val1 : "+email.value);
   // 포털 메일 도메인   
   } else { 
      // 사용자 메일 도메인 초기화
      email3.value = "";
      email.value = email1.value.trim() 
                 + "@" 
                 + email2.value;
      alert("email_val2 : "+email.value);
   }
}

function combinePhone() {
   
   var phone1 = document.getElementById("phone1");
   //alert("phone1 : "+phone1);
   var phone2 = document.getElementById("phone2");
   //alert("phone2 : "+phone2);
   var phone3 = document.getElementById("phone3");
   //alert("phone3 : "+phone3);

   var phone =document.getElementById("phone");
   phone.value = phone1.value.trim()+"-"+phone2.value.trim() +"-"+phone3.value.trim(); 
   alert("combinePhone phone : "+phone.value);
}


function combineAddress() {
      
      var address1 = document.getElementById("roadAddr1");
      var address2 = document.getElementById("roadAddr2");

      var address =document.getElementById("address");
      address.value = address1.value.trim()+"*"+address2.value.trim();
      alert("combineAddress address : "+address.value);
   }
//////////////////////////////////////////////////////////////////////////////////////////////////////

// 도로명 주소 검색
function road_Postcode() {
   new daum.Postcode({
      oncomplete : function(data) {
         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

         // 각 주소의 노출 규칙에 따라 주소를 조합한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         var fullAddr = ''; // 최종 주소 변수
         var extraAddr = ''; // 조합형 주소 변수

         // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
         fullAddr = data.roadAddress;

         // 법정동명이 있을 경우 추가한다.
         if (data.bname !== '') {
            extraAddr += data.bname;
         }
         // 건물명이 있을 경우 추가한다.
         if (data.buildingName !== '') {
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
                  : data.buildingName);
         }
         // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
         fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');

         // 주소 정보 전체 필드 및 내용 확인 : javateacher
         var output = '';
         for ( var key in data) {
            output += key + ":" + data[key] + "\n";
         }

         // alert(output);

         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('zip').value = data.zonecode; // 5자리 새우편번호
                                                   // 사용
         document.getElementById('roadAddr1').value = fullAddr;

         // 커서를 상세주소 필드로 이동한다.
         document.getElementById('roadAddr2').focus();
      }
   }).open();
}