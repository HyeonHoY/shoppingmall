-------------------------------------------------------------------------------- 
							SELECT
--------------------------------------------------------------------------------

SELECT * FROM shop_member;

SELECT COUNT(*) shop_member;

SELECT COUNT(*) FROM shop_member WHERE id='admin';

SELECT COUNT(*) FROM shop_member WHERE id='admin' AND pw='123456';

select * from shop_member where phone='010-1111-1111';

select * from shop_member where email='asdf1234@nate.com';

SELECT * FROM( SELECT ROWNUM AS rnum,m.*
                    FROM(SELECT * FROM shop_member) m)
       			 WHERE rnum BETWEEN 1 AND 10;
       			 
SELECT * FROM shop_member
    	WHERE id like '%' || 'a' || '%'
				OR name like '%' || '리' || '%'
				OR email like '%' || '\\@' || '%'
				OR phone like '%' || '\\-' || '%'
    	order by id ASC 
    	
SELECT count(*) FROM shop_member
    	WHERE id like '%' || 'a' || '%'
				OR name like '%' || '리' || '%'
				OR email like '%' || '\\@' || '%'
				OR phone like '%' || '\\-' || '%'
    	order by id ASC;        			 

-------------------------------------------------------------------------------- 
							INSERT
--------------------------------------------------------------------------------

INSERT INTO SHOP_MEMBER 
			(id, pw, name,gender,phone,email,zip,address,birthday,joindate,UPDATEDATE)
		VALUES ('admin', '123456','관리자','남자','010-1234-1234','admin@naver.com','12345','서울시 구로구*aaaaaa','1991-01-01',sysdate,null);

INSERT INTO shop_member
			(id, pw, name, gender,phone, email, zip, address, birthday, joindate,UPDATEDATE)
		VALUES
			('asdfg1234','@Servlet1234', '홍길동','남자','010-1234-1234','asdf1234@naver.com','012345','경기도 부천시*aaaaaaa','1996-01-01',sysdate,sysdate);
			
INSERT INTO shop_member
			(id, pw, name, gender,phone, email, zip, address, birthday, joindate,UPDATEDATE)
		VALUES
			('asdfg1235','@Servlet1234', '홍길동','남자','010-1234-1234','asdf1234@naver.com','012345','경기도 부천시*aaaaaaa','1996-01-01',sysdate,sysdate);
			
INSERT INTO shop_member
			(id, pw, name, gender,phone, email, zip, address, birthday, joindate,UPDATEDATE)
		VALUES
			('asdfg1236','@Servlet1234', '홍길동','남자','010-1234-1234','asdf1234@naver.com','012345','경기도 부천시*aaaaaaa','1996-01-01',sysdate,sysdate);	

INSERT INTO shop_member_role (id_count, id, role)
		VALUES (shop_member_role_id_seq.nextval, 'admin', 'role_admin');
		
INSERT INTO shop_member_role (id_count, id, role)
		VALUES (shop_member_role_id_seq.nextval, 'asdfg1234', 'role_user');
		
INSERT INTO shop_member_role (id_count, id, role)
		VALUES (shop_member_role_id_seq.nextval, 'asdfg1235', 'role_user');
		
INSERT INTO shop_member_role (id_count, id, role)
		VALUES (shop_member_role_id_seq.nextval, 'asdfg1236', 'role_user');							

-------------------------------------------------------------------------------- 
							UPDATE
--------------------------------------------------------------------------------

UPDATE shop_member SET  pw='123'
		WHERE id='asdfg1234' AND name='홍길동';

update shop_member set joindate=sysdate where id='asdfg1235';

update shop_member set updatedate=sysdate where id='asdfg1235';

-------------------------------------------------------------------------------- 
							DELETE
--------------------------------------------------------------------------------
DELETE FROM shop_member;

delete shop_member_t where id='asdfg1235' AND pw='@Servlet1234';	

delete shop_member_t where id='asdfg1235'