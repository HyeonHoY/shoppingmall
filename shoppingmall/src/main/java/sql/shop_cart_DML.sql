INSERT INTO shop_cart VALUES(
    shop_cart_seq.nextval, 'spring12', '3333333', 1, to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')); 

SELECT * FROM shop_cart WHERE member_id='admin';  