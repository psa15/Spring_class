CREATE TABLE TBL_BOARD (
    BNO     NUMBER   CONSTRAINT PK_BOARD PRIMARY KEY,   --글번호
    TITLE   VARCHAR2(100)   NOT NULL, --제목
    CONTENT VARCHAR2(4000)  NOT NULL, --내용
    WRITER  VARCHAR2(100)   NOT NULL, --작성자
    REGDATE DATE    DEFAULT SYSDATE   --등록일
);

CREATE SEQUENCE SEQ_BOARD;

CREATE TABLE TBL_REPLY (
    RNO     NUMBER CONSTRAINT PK_REPLY PRIMARY KEY,
    BNO     NUMBER NOT NULL,    --게시판테이블의 글번호(FK)
    REPLY   VARCHAR2(500)   NOT NULL,   --댓글 내용
    REPLYER VARCHAR2(100)   NOT NULL,    --댓글 작성자
    REPLYDATE   DATE DEFAULT SYSDATE,
    UPDATEDATE   DATE DEFAULT SYSDATE,    
    CONSTRAINT FK_BOARD_REPLY_BNO FOREIGN KEY (BNO) REFERENCES TBL_BOARD(BNO) 
);

CREATE SEQUENCE SEQ_REPLY;