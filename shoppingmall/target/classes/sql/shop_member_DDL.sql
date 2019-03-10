-------------------------------------------------------------------------------- 
							-- CREATE TABLE --
--------------------------------------------------------------------------------
DROP TABLE shop_member;

CREATE TABLE SHOP_MEMBER
(
  ID        VARCHAR2(20 BYTE)              PRIMARY KEY,
  PW        VARCHAR2(20 BYTE)                ,
  NAME      VARCHAR2(20 BYTE)                  ,
  GENDER      VARCHAR2(20 BYTE)                  ,
  PHONE     VARCHAR2(20 BYTE)                 ,
  EMAIL     VARCHAR2(50 BYTE)                 ,
  ZIP       VARCHAR2(10 BYTE)                   ,
  ADDRESS   VARCHAR2(401 BYTE)                  ,
  BIRTHDAY  DATE                  ,
  JOINDATE  VARCHAR2(20 BYTE)                  ,
  UPDATEDATE VARCHAR2(20 BYTE)   
);

-------------------------------------------------------------------------------- 
