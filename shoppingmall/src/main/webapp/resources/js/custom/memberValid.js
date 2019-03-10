/**
 * 달력 및 폼 점검
 */

$(function() {

   $("#birthday").datepicker();

   // $("#birthday").datepicker("option", "dateFormat", "yy-mm-dd");
   // $("#birthday").datepicker("option", "ko", "yy-mm-dd");

});

// 가입일 자동 입력
function outputDate() {

   var date = new Date();
   
   var month = (date.getMonth()+1) < 10 ? "0"+ (date.getMonth()+1) : date.getMonth()+1;
   
   
   var today = "20" + date.getYear().toString().substring(1, 3) + "-"
            + month + "-" + date.getDate();
   //+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
   //var today = getFullYear()+ "-"
      

   document.all["joindate"].readOnly = true; // 임의 입력방지
   document.all["joindate"].value = today;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

//이메일 조합 및 연락처 조합
function combineEmail() {
   
   var email1 = document.getElementById("email1");
   var email2 = document.getElementById("email2");
   var email3 = document.getElementById("email3");
   var email = document.getElementById("email");
   
   // 사용자 이메일 도메인(非포털)
   if (email2.value == "사용자 직접 입력") {
      email.value = email1.value.trim() 
                  + "@" 
                  + email3.value.trim();
      // alert("email_val1 : "+email.value);
   // 포털 메일 도메인   
   } else { 
      // 사용자 메일 도메인 초기화
      email3.value = "";
      email.value = email1.value.trim() 
                 + "@" 
                 + email2.value;
      // alert("email_val2 : "+email.value);
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
   phone.value = phone1.value.trim()+"-"+phone2.value.trim() +"-"+phone3.value.trim() 
   // alert("phone : "+phone.value);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////

function selectEmail(email2) {

    var len = document.all["email2"].length; 
    // var len = document.all["fruit"].options.length;
    // alert(len);
    
    var selectedIdx = 0; // 선택된 항목의 index
    
    // 항목에 해당하는 순번(index)값 검색
    for (i=0; i<len; i++) {
        
        if (document.all["email2"][i].text == email2)
            selectedIdx = i;
    } // for
    
    // 선택항목 재설정(re-select)
    document.all["email2"].selectedIndex = selectedIdx;
    
   /* alert("선택된 항목 index : " + selectedIdx + "\n"+
          "선택된 항목 : " + email);*/
}

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

// 페이지 로딩시 시작할 부분
window.onload = function() {
   selectEmail('직접 입력');//실행 시 이메일 기본 값
   outputDate(); // 가입일 생성 표시
}