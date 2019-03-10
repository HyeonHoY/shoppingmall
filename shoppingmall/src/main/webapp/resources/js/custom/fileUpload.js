/**
 * FileRedaer 미리보기
 */
function addPreview(file, divId, width, height){
	
	console.log('file = ' +file);
	console.log('divId = ' +divId);
	console.log('width = ' +width);
	console.log('height = ' +height);
	
	// 인자로 값을 받지 못했을 경우 300px로 고정
	typeof width == "undefined" ? width = "300" : width;
	typeof height == "undefined" ? height = "300" : height;
	
	for(var i=0; i<file.length; i++) {
		
		var reader = new FileReader();
		
		reader.onload = function(e){
			$("#"+divId).append(
                "<img src=\"" + e.target.result + 
                "\"\ style='width:"+width+"px; height:"+height+"px'/>"
            );
		}
//		$("#"+divId+"_text").append(
//			file[i].name
//        );
		reader.readAsDataURL(file[i]);
	} // for
} // end