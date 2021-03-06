/* CAPTAIN LIVE IN JEJU */


/* 테이블 삭제 및 초기화 */
delete sequence MEMBER_SEQ;
delete sequence qna_seq;
delete sequence review_seq;
drop table qna;
drop table review;
drop table payment;
drop table member;
drop table product;
drop table package;
drop table hotel;
drop table flight;



/* 회원 */
CREATE TABLE MEMBER (
    MEMBER_NO     NUMBER         NOT NULL, /* 회원번호 */
    EMAIL         VARCHAR2(20)    NOT NULL, /* 이메일 */
    PWD           VARCHAR2(20)    NOT NULL, /* 비번 */
    NAME          VARCHAR2(20)    NOT NULL, /* 이름 */
    NICK          VARCHAR2(20)    NOT NULL, /* 닉네임 */
    PHONE         VARCHAR2(20)    NOT NULL, /* 번호 */
    RDATE         DATE            NOT NULL, /* 가입일 */
    TRIPNO        NUMBER(5)       NULL, /* 여행횟수 */
    BDATE         DATE            NULL, /* 생년월일 */
    WITHDRAWAL    VARCHAR2(20)     NOT NULL, /* 탈퇴여부 */
    CONSTRAINT MEMBER_PK PRIMARY KEY (MEMBER_NO)
);
create sequence MEMBER_SEQ increment by 1 start with 1 nocache; 
/* 후기게시판 */
CREATE TABLE REVIEW (
    ARTICLE_NO    NUMBER(10)      NOT NULL, /* 글번호 */
    MEMBER_NO     NUMBER(10)      CONSTRAINT REVIEW_FK REFERENCES MEMBER(MEMBER_NO), /* 회원번호 */
    NICK          VARCHAR2(20)      NOT NULL, /* 닉네임 */
    SUBJECT       VARCHAR2(30)      NOT NULL, /* 제목 */
    CONTENT       VARCHAR2(2000)    NOT NULL, /* 내용 */
    RDATE         DATE              NOT NULL, /* 작성일 */
    VIEWS         NUMBER(5),         
    RLIKE         NUMBER(5),        
    CONSTRAINT REVIEW_PK PRIMARY KEY (ARTICLE_NO) 
);
create sequence REVIEW_SEQ increment by 1 start with 1 nocache; 

/* 문의게시판 */
CREATE TABLE QNA (
    QNA_NO        NUMBER(10)      NOT NULL, /* 글번호 */
    MEMBER_NO     NUMBER(10)      CONSTRAINT QNA_FK REFERENCES MEMBER(MEMBER_NO), /* 회원번호 */
    SUBJECT       VARCHAR2(30)      NOT NULL, /* 제목 */
    CONTENT       VARCHAR2(2000)    NOT NULL, /* 내용 */
    RDATE         DATE              NOT NULL, /* 작성일 */
   QGROUP        NUMBER(5)         NOT NULL, /* 족번호 */
   QLEVEL        NUMBER(5)         NOT NULL, /* 깊이 */
   QORDER        NUMBER(5)         NOT NULL, /* 순번 */
   CONSTRAINT QNA_PK PRIMARY KEY (QNA_NO)
);
create sequence QNA_SEQ increment by 1 start with 1 nocache;


/* 항공 */
CREATE TABLE FLIGHT (
    FLIGHT_NO     VARCHAR2(20)   NOT NULL, 
    DEP_AIRPORT   VARCHAR2(20)   NOT NULL,
    DEP_FLIGHT    VARCHAR2(20)    NOT NULL, 
    DEP_DATE      DATE            NOT NULL,
    ARI_FLIGHT    VARCHAR2(20)    NOT NULL,  
    ARI_AIRPORT   VARCHAR2(20)   NOT NULL,
    ARI_DATE      DATE            NOT NULL, 
    CONSTRAINT FLIGHT_PK PRIMARY KEY (FLIGHT_NO)
);

/* 호텔 */
CREATE TABLE HOTEL (
    HOTEL_NO     VARCHAR2(20)    NOT NULL, 
    HOTELNAME    VARCHAR2(30)    NOT NULL, 
    HOTELTYPE    VARCHAR2(20)    NOT NULL, 
    MAX          NUMBER(2)       NOT NULL, 
    CHECKIN      DATE            NOT NULL, 
    CHECKOUT     DATE            NOT NULL, 
    CONSTRAINT HOTEL_PK PRIMARY KEY (HOTEL_NO)
);

/* 패키지 */
CREATE TABLE PACKAGE (
    PACK_NO     VARCHAR2(20)    NOT NULL, 
   FLIGHT_NO   VARCHAR2(20)   CONSTRAINT PACKAGE_FK REFERENCES FLIGHT(FLIGHT_NO),
    HOTEL_NO    VARCHAR2(20)   CONSTRAINT PACKAGE_FK2 REFERENCES HOTEL(HOTEL_NO),
   DESTINATION VARCHAR2(20)   NOT NULL,
   DEP_DATE    DATE,
   ARI_DATE    DATE,
   CONSTRAINT PACKAGE_PK PRIMARY KEY (PACK_NO)
);

/* 상품 */
CREATE TABLE PRODUCT (
    PRODUCT_NO  VARCHAR2(20)    NOT NULL, 
   PACK_NO     VARCHAR2(20)    CONSTRAINT PRODUCT_FK REFERENCES PACKAGE(PACK_NO),
   DESTINATION VARCHAR2(20)   NOT NULL,
   PAYMENT     NUMBER(10)       NOT NULL,
    CONSTRAINT PRODUCT_PK PRIMARY KEY (PRODUCT_NO)
);

/* 결제 */
CREATE TABLE PAYMENT (
    PAY_NO       VARCHAR2(10)    NOT NULL, 
    MEMBER_NO    NUMBER          CONSTRAINT PAYMENT_FK REFERENCES MEMBER(MEMBER_NO), 
    PACK_NO      VARCHAR2(10)    CONSTRAINT PAYMENT_FK2 REFERENCES PACKAGE(PACK_NO), 
    SUM          NUMBER(10)      NOT NULL, 
    METHOD       VARCHAR2(20)    NULL, 
    BANK         VARCHAR2(20)    NULL, 
    PAYDATE      TIMESTAMP       NULL, 
    STATUS       NUMBER(20)      NOT NULL, 
    CONSTRAINT PAYMENT_PK PRIMARY KEY (PAY_NO)
);


/* INSERT */

/* 멤버 */
INSERT INTO MEMBER VALUES (MEMBER_SEQ.NEXTVAL, 'sunny@naver.com', '1234', '김도라', '도라에몽', '01012345678', sysdate, 1, sysdate, 'N');
INSERT INTO MEMBER VALUES (MEMBER_SEQ.NEXTVAL, 'june@naver.com', '1234', '김짱구', '짱구', '01023456789', sysdate, 2, sysdate, 'N');
INSERT INTO MEMBER VALUES (MEMBER_SEQ.NEXTVAL, 'april@naver.com', '1234', '이둘리', '둘리', '01034567890', sysdate, 3, sysdate, 'N');


/* 항공 */
INSERT INTO Flight VALUES ('FL-0001','인천공항', '대한항공', '2021-03-25', '대한항공', '바르셀로나공항', '2021-03-29');
INSERT INTO Flight VALUES ('FL-0002','인천공항', '대한항공', '2021-06-25', '대한항공', '바르셀로나공항', '2021-06-29');
INSERT INTO Flight VALUES ('FL-0003','인천공항', '대한항공', '2021-09-25', '대한항공', '바르셀로나공항', '2021-09-29');
INSERT INTO Flight VALUES ('FL-0004','인천공항', '아시아나항공', '2021-03-26', '대한항공', '노이바이공항', '2021-03-30');
INSERT INTO Flight VALUES ('FL-0005','인천공항', '아시아나항공', '2021-06-26', '대한항공', '노이바이공항', '2021-06-30');
INSERT INTO Flight VALUES ('FL-0006','인천공항', '아시아나항공', '2021-09-26', '대한항공', '노이바이공항', '2021-09-30');
INSERT INTO Flight VALUES ('FL-0007','김포공항', '이스타항공', '2021-03-27', '대한항공', '도쿄공항', '2021-03-31');
INSERT INTO Flight VALUES ('FL-0008','김포공항', '이스타항공', '2021-06-27', '대한항공', '도쿄공항', '2021-07-01');
INSERT INTO Flight VALUES ('FL-0009','김포공항', '이스타항공', '2021-09-27', '대한항공', '도쿄공항', '2021-10-01');

/* 숙소 */
INSERT INTO HOTEL VALUES ('HT-0001', '알마낙 바르셀로나 호텔', '디럭스룸', 1, '2021-03-25', '2021-03-29');
INSERT INTO HOTEL VALUES ('HT-0002', '알마낙 바르셀로나 호텔', '디럭스룸', 1, '2021-06-25', '2021-06-29');
INSERT INTO HOTEL VALUES ('HT-0003', '알마낙 바르셀로나 호텔', '디럭스룸', 1, '2021-09-25', '2021-09-29');
INSERT INTO HOTEL VALUES ('HT-0004', '힐튼 하노이 오페라 호텔', '트윈룸', 2, '2021-03-26', '2021-03-30');
INSERT INTO HOTEL VALUES ('HT-0005', '힐튼 하노이 오페라 호텔', '트윈룸', 2, '2021-06-26', '2021-06-30');
INSERT INTO HOTEL VALUES ('HT-0006', '힐튼 하노이 오페라 호텔', '트윈룸', 2, '2021-09-26', '2021-09-30');
INSERT INTO HOTEL VALUES ('HT-0007', '하네다 호텔', '싱글룸', 3, '2021-03-27', '2021-03-31');
INSERT INTO HOTEL VALUES ('HT-0008', '하네다 호텔', '싱글룸', 3, '2021-06-27', '2021-07-01');
INSERT INTO HOTEL VALUES ('HT-0009', '하네다 호텔', '싱글룸', 3, '2021-09-27', '2021-10-01');

/* 패키지 */
INSERT INTO PACKAGE VALUES ('PK-0001', 'FL-0001', 'HT-0001', '스페인','2021-03-25', '2021-03-29');
INSERT INTO PACKAGE VALUES ('PK-0002', 'FL-0002', 'HT-0002', '스페인','2021-06-25', '2021-06-29');
INSERT INTO PACKAGE VALUES ('PK-0003', 'FL-0003', 'HT-0003', '스페인','2021-09-25', '2021-09-29');
INSERT INTO PACKAGE VALUES ('PK-0004', 'FL-0004', 'HT-0004', '하노이','2021-03-26', '2021-03-30');
INSERT INTO PACKAGE VALUES ('PK-0005', 'FL-0005', 'HT-0005', '하노이','2021-06-26', '2021-06-30');
INSERT INTO PACKAGE VALUES ('PK-0006', 'FL-0006', 'HT-0006', '하노이','2021-09-26', '2021-09-30');
INSERT INTO PACKAGE VALUES ('PK-0007', 'FL-0007', 'HT-0007', '도쿄', '2021-03-27', '2021-03-31');
INSERT INTO PACKAGE VALUES ('PK-0008', 'FL-0008', 'HT-0008', '도쿄', '2021-06-27', '2021-07-01');
INSERT INTO PACKAGE VALUES ('PK-0009', 'FL-0009', 'HT-0009', '도쿄', '2021-09-27', '2021-10-01');

/* 상품 */
INSERT INTO PRODUCT VALUES ('PR-0001','PK-0001', '스페인', '20000');
INSERT INTO PRODUCT VALUES ('PR-0002','PK-0002', '하노이', '30000');
INSERT INTO PRODUCT VALUES ('PR-0003','PK-0003', '도쿄', '40000');


/* 결제 */
INSERT INTO PAYMENT VALUES ('PAY-0001',51, 'PK-0001', 200000, '신용카드', '신한카드', sysdate, 1);
INSERT INTO PAYMENT VALUES ('PAY-0002',52, 'PK-0002', 300000, '체크카드', '우리은행', sysdate, 0);
INSERT INTO PAYMENT VALUES ('PAY-0003',53, 'PK-0003', 400000, '신용카드', '우리카드', sysdate, 1);

/* 리뷰 */
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 50, 'sunny', '도쿄 후기~', '이시국에 잘 놀다옵니다', sysdate, 1, 1);
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 51, 'snowman', '스페인 가족 여행', '믿고쓰는 수스투어', sysdate, 30, 41);
INSERT INTO REVIEW VALUES (REVIEW_SEQ.NEXTVAL, 52, 'jejusea', '제주도 한달살기', '팀장님보러제주도다녀옵니다', sysdate, 99, 98);

/* 문의게시글 */
insert into QNA values (QNA_SEQ.nextval, 50, '안늉', '내용~~', SYSDATE, 1, 0, 0);
insert into QNA values (QNA_SEQ.nextval, 50, '안늉', '내용~~', SYSDATE, 1, 1, 1);
insert into QNA values (QNA_SEQ.nextval, 51, '안늉', '내용~~', SYSDATE, 1, 2, 2);
insert into QNA values (QNA_SEQ.nextval, 52, '반갑', '내용입니다~~', SYSDATE, 2, 0 ,3);
insert into QNA values (QNA_SEQ.nextval, 52, '반갑', '내용입니다~~', SYSDATE, 2, 1 ,4);
insert into QNA values (QNA_SEQ.nextval, 53, '반갑', '내용입니다~~', SYSDATE, 2, 2 ,5);
insert into QNA values (QNA_SEQ.nextval, 53, '제목', '글 내용~~', SYSDATE, 3, 0, 5);