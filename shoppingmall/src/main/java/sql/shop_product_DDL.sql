DROP TABLE shop_product;

/**********************************/
/* Table Name: 쇼핑몰 상품 정보 테이블 */
/**********************************/
CREATE TABLE shop_product(
		product_id VARCHAR(50),
		main_category VARCHAR(50) NOT NULL,
		sub_category VARCHAR(50) NOT NULL,
		product_name VARCHAR(50) NOT NULL,
		product_price NUMBER NOT NULL,
		product_stock NUMBER NOT NULL ,
		product_title_img VARCHAR(100) NOT NULL,
  		product_explain_img VARCHAR(100) NOT NULL,
   		product_date VARCHAR(25) NOT NULL,
		order_count NUMBER  DEFAULT 0,
		discount_rate NUMBER DEFAULT 0
);


ALTER TABLE shop_product ADD CONSTRAINT IDX_shop_product_PK PRIMARY KEY (product_id);
ALTER TABLE shop_product ADD CONSTRAINT IDX_shop_product_name_UQ UNIQUE (product_name);


COMMIT;