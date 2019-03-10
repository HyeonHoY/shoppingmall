DROP TABLE shop_board;

DROP SEQUENCE shop_board_seq;

CREATE SEQUENCE shop_board_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE;

CREATE TABLE shop_board (
	board_num       NUMBER DEFAULT 0,
	board_writer    VARCHAR2(30)        NOT NULL,
	board_pw        VARCHAR2(15)        NOT NULL,
	board_subject   VARCHAR2(50)        NOT NULL,
	board_content   VARCHAR2(2000)      NOT NULL,
	board_file      VARCHAR2(50),
	board_re_ref    NUMBER              ,
	board_re_lev    NUMBER              ,
	board_re_seq    NUMBER              ,
	board_read_count NUMBER DEFAULT 0,
	board_date      DATE,
	PRIMARY KEY(board_num)
);

ALTER TABLE shop_board ADD CONSTRAINT FK_shop_board_product_id 
		FOREIGN KEY (product_id) REFERENCES shop_product(product_id);

COMMIT;

DROP PROCEDURE shop_board_dummy_gen_proc;

CREATE OR REPLACE PROCEDURE shop_board_dummy_gen_proc
IS
BEGIN

    FOR i IN 1..100 LOOP
        INSERT INTO shop_board VALUES 
        (
        	shop_board_seq.nextval,
        	'글쓴이'|| i,
        	'1234',
        	'글 제목'|| i,
        	'글 내용',
        	null,
        	shop_board_seq.nextval,
        	0,
        	0,
        	0,
        	TO_DATE('2018-11-16 12:34:56', 'YYYY-MM-DD HH24:MI:SS')
        );
     END LOOP;

    COMMIT;    
END;
/

EXECUTE shop_board_dummy_gen_proc;