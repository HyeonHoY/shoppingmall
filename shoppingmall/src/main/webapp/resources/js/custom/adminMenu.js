/**
 * 
 */

function deleteConfirm(id, close) {
	
	if (confirm("정말 삭제하시겠습니까?") == true) {
		
		alert("삭제");
		window.open("delete.do?id="+id, "",
				    "left=100, top=100, " +
				    "width=300, height=300, " +
				    "resizable=no");
		
	} else {
		
		alert("삭제 취소");
	} // if
}

function updateConfirm(id, close) {
		
	if (confirm("정말 수정하시겠습니까?") == true) {
		
		window.open("updateForm.do?id="+id, "",
				    "left=100, top=100, " +
				    "width=700, height=500, " +
				    "resizable=no, scrollbars=yes");
	} else {
		
		alert("삭제 취소");
	} // if
}