function addComma(num) {
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}
function intChange(id) {
	
	return parseInt(id.text().trim().replace("원", "").replace(/,/gi, ""));
}
function submitData(form, num) {
	
	form.append("<input type='hidden' name='productId' value='"+$("#productId_"+num+"").text()+"'>");
	form.append("<input type='hidden' name='purchaseCount' value='"+$("#rowCartCount_"+num+"").val()+"'>");
	form.append("<input type='hidden' name='purchasePrice' value='"+$("#productPrice_"+num+"").val()*(100-$("#discountRate_"+num+"").val())*0.01+"'>");
}