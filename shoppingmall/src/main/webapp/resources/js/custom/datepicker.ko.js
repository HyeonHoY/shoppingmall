/**
 * jquery ui datepicker (korean format) : datepicker.ko.js
 */
jQuery(function($){
 $.datepicker.regional['ko'] = {
  autoSize : true,
  closeText: '닫기',
  prevText: '이전달',
  nextText: '다음달',
  currentText: '오늘',
  yearRange: "1930:2018", // 1930 ~ 2018
  // yearRange: "-36:-20", // 36년전부터 20년전까지
  monthNames: ['1월','2월','3월','4월','5월','6월',
  '7월','8월','9월','10월','11월','12월'],
  monthNamesShort: ['1월','2월','3월','4월','5월','6월',
  '7월','8월','9월','10월','11월','12월'],
  dayNames: ['일','월','화','수','목','금','토'],
  dayNamesShort: ['일','월','화','수','목','금','토'],
  dayNamesMin: ['일','월','화','수','목','금','토'],
  weekHeader: 'Wk',
  dateFormat: 'yy-mm-dd', // 날짜 포맷
  firstDay: 0,
  minDate: new Date(1970, 1 - 1, 1),
  isRTL: false,
  showMonthAfterYear: true,
  yearSuffix: '년'};
 $.datepicker.setDefaults($.datepicker.regional['ko']);
});