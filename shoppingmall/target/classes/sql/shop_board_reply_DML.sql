INSERT INTO shop_board_reply
(
	reply_no, board_num, reply_content, reply_writer, regdate, user_writer)
	VALUES 
	(reply_no_seq.NEXTVAL, 103, '1', 
	'1', sysdate, '1'
);    
 
SELECT * FROM shop_board_reply WHERE board_num=?;    

DELETE FROM shop_board_reply
WHERE 
board_num=104 AND reply_no=4;