-- 시퀀스 삭제
DROP SEQUENCE shop_cart_seq;

-- 시퀀스 생성
CREATE SEQUENCE shop_cart_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

-- PROCEDURE 삭제
DROP FUNCTION f_shop_cart;

-- PROCEDURE 생성
create or replace PROCEDURE p_cart_insert
(v_member_id IN VARCHAR2,
 v_product_id IN VARCHAR2,
 v_cart_count IN NUMBER)
IS
v_result NUMBER;
BEGIN

SELECT count(*)
  INTO v_result
  FROM shop_cart 
 WHERE product_id=v_product_id AND member_id = v_member_id;

 IF v_result = 0 THEN
INSERT INTO shop_cart(cart_num, member_id, product_id, cart_count, cart_date)
            VALUES(shop_cart_seq.nextval, v_member_id, v_product_id, v_cart_count, to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss'));
COMMIT;
ELSE
    INSERT INTO shop_cart(cart_num)
       VALUES(1);
END IF;

END;
/


-- 테이블 생성
CREATE TABLE shop_cart(	
        cart_num    NUMBER DEFAULT 0 NOT NULL, 
        member_id   VARCHAR2(20 BYTE) NOT NULL, 
        product_id  VARCHAR2(30 BYTE) NOT NULL, 
        cart_count  NUMBER DEFAULT 0 NOT NULL, 
        cart_date   VARCHAR2(23 BYTE) NOT NULL, 
        CONSTRAINT "SHOP_CART_PK" PRIMARY KEY (cart_num)
   );