CREATE TABLE SHOP_BOARD_REPLY 
(	
   	REPLY_NO NUMBER DEFAULT 0, 
	BOARD_NUM NUMBER, 
	REPLY_CONTENT 		VARCHAR2(400 BYTE), 
	REPLY_WRITER 		VARCHAR2(20 BYTE), 
	REGDATE DATE, 
	UPDATEDATE DATE, 
	SECURITY_REPLY 		VARCHAR2(20 BYTE), 
	USER_WRITER			VARCHAR2(30 BYTE)
)

DROP SEQUENCE reply_no_seq;

CREATE SEQUENCE reply_no_seq
	start with 1
	increment by 1
	maxvalue 99999
    nocycle ;
    
INSERT INTO shop_board_reply
		(reply_no, board_num, reply_content, reply_writer, regdate, user_writer)
		VALUES 
		(reply_no_seq.NEXTVAL, '1', '1', 
		'1', sysdate, '1');    
 
SELECT * FROM shop_board_reply WHERE board_num=?;    