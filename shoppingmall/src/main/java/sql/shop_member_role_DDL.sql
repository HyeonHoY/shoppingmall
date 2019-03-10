
-------------------------------------------------------------------------------- 

 -- 롤 테이블 생성 --

DROP TABLE shop_member_role;

DROP SEQUENCE shop_member_role_id_seq;

--------------------------------------------------------------------------------
 
CREATE SEQUENCE shop_member_role_id_seq
	start with 1
	increment by 1
	maxvalue 99999
    nocycle ;

CREATE TABLE shop_member_role (
  id_count number NOT NULL,
  id varchar(45) UNIQUE,
  role varchar(45) DEFAULT 'role_user',
  PRIMARY KEY (id_count),
  CONSTRAINT fk_id FOREIGN KEY (id) 
     REFERENCES shop_member (id)   
);

-------------------------------------------------------------------------------- 
							-- DUMMY DATA --
--------------------------------------------------------------------------------

DROP PROCEDURE dummy_shop_member_gen_proc;

DROP PROCEDURE dummy_member_role_gen_proc;

-------------------------------------------------------------------------------- 

CREATE OR REPLACE PROCEDURE dummy_shop_member_gen_proc
IS
BEGIN

    FOR i IN 1..100 LOOP
        INSERT INTO shop_member VALUES 
        ('spring' || (i),
         'A!qwer1234', 
         '스프링' || (i),
         '남자',
         '010-1234-' || (1112+i),  
         'spring' || i || '@naver.com', 
         '12345',
         '경기도 부천시 신흥로 56번길 25 * 부천대학교',
         '1991-01-01',
         SYSDATE,
         NULL);
     END LOOP;

    COMMIT;    
END;
/

EXECUTE dummy_shop_member_gen_proc;

-------------------------------------------------------------------------------- 

CREATE OR REPLACE PROCEDURE dummy_member_role_gen_proc
IS
BEGIN

    FOR i IN 1..100 LOOP
        INSERT INTO shop_member_role VALUES 
        (shop_member_role_id_seq.NEXTVAL,
         'spring' || i,
         'role_user');
     END LOOP;

    COMMIT;    
END;
/

EXECUTE dummy_member_role_gen_proc;

-------------------------------------------------------------------------------- 