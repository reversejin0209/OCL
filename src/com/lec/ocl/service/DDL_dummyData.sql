------------------------------------------------------------------------------------
-----------------------------------   STUDENT   ------------------------------------
------------------------------------------------------------------------------------
-- DROP & CREATE
DROP TABLE STUDENT CASCADE CONSTRAINTS;
CREATE TABLE STUDENT(
    sID VARCHAR2(30) PRIMARY KEY,
    sPW VARCHAR2(30) NOT NULL,
    sNAME VARCHAR2(30) NOT NULL,
    sNUMBER VARCHAR2(30),
    sBIRTH DATE,
    sRDATE DATE DEFAULT SYSDATE,
    sEMAIL VARCHAR2(100),
    sPHOTO VARCHAR2(30) NOT NULL,
    sGENDER VARCHAR2(5) NOT NULL,
    sADDRESS VARCHAR2(100)
);
SELECT * FROM STUDENT;
-- DUMMY DATA
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('aaa', '11', '김동길', '010-7777-6666', '2012-11-12', 'kim@kim.com', 'NO.PNG', 'm', '서울시 서대문구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('bbb', '11', '신동길', '010-1111-1111', '2012-10-15', 'kim@kim.com', 'NO.PNG', 'm', '서울시 양천구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO,SGENDER, SADDRESS)
VALUES ('ccc', '11', '정동준', '010-1112-3333', '2012-02-08', 'kim@kim.com', 'NO.PNG', 'm', '서울시 서초구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('ddd', '11', '김예은', '010-4444-5555', '2012-12-15', 'kim@kim.com', 'NO.PNG', 'f', '서울시 강동구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('eee', '11', '하주한', '010-5555-3333', '2012-10-14', 'kim@kim.com', 'NO.PNG', 'm', '서울시 동작구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('fff', '11', '황석희', '010-2121-3333', '2012-02-16', 'kim@kim.com', 'NO.PNG', 'm', '서울시 강북구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('ggg', '11', '신원철', '010-7777-2727', '2012-03-21', 'kim@kim.com', 'NO.PNG', 'm', '서울시 강남구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('hhh', '11', '양우빈', '010-9999-9999', '2012-08-05', 'kim@kim.com', 'NO.PNG', 'm', '서울시 관악구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('iii', '11', '이종석', '010-6666-4545', '2012-08-08', 'kim@kim.com', 'NO.PNG', 'm', '서울시 영등포구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('jjj', '11', '임다솔', '010-9999-0000', '2012-01-27', 'kim@kim.com', 'NO.PNG', 'f', '서울시 도봉구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('kkk', '11', '이현주', '010-1111-2222', '2012-10-11', 'kim@kim.com', 'NO.PNG', 'f', '서울시 노원구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('lll', '11', '김양수', '010-8888-8888', '2012-05-08', 'kim@kim.com', 'NO.PNG', 'm', '서울시 마포구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('mmm', '11', '이현지', '010-4359-2359', '2012-03-20', 'kim@kim.com', 'NO.PNG', 'f', '서울시 구로구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('nnn', '11', '최준혁', '010-2222-2222', '2012-03-05', 'kim@kim.com', 'NO.PNG', 'm', '서울시 금천구');
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, sPHOTO, SGENDER, SADDRESS)
VALUES ('ooo', '11', '양희동', '010-2523-6189', '2012-06-06', 'kim@kim.com', 'NO.PNG', 'm', '서울시 서대문구');
COMMIT;

------------------------------------------------------------------------------------
-----------------------------------   TEACHER   ------------------------------------
------------------------------------------------------------------------------------
-- DROP * CREATE
DROP TABLE TEACHER CASCADE CONSTRAINTS;
CREATE TABLE TEACHER(
    tID VARCHAR2(30) PRIMARY KEY,
    tPW VARCHAR2(30) NOT NULL,
    tNAME VARCHAR2(30) NOT NULL
);
-- DUMMY DATA
INSERT INTO TEACHER (TID, TPW, TNAME) VALUES ('dbswls0209', '1111', '진윤진');
COMMIT;
------------------------------------------------------------------------------------
---------------------------------   FILEBOARD   ------------------------------------
------------------------------------------------------------------------------------
-- DROP * CREATE
DROP TABLE FILEBOARD CASCADE CONSTRAINTS;
CREATE TABLE FILEBOARD(
    fNO NUMBER(5) PRIMARY KEY,
    sID VARCHAR2(30) REFERENCES STUDENT(sID),
    tID VARCHAR2(30) REFERENCES TEACHER(tID),
    fTITLE VARCHAR2(100) NOT NULL,
    fCONTENT VARCHAR2(4000),
    fFILENAME VARCHAR2(100),
    fRDATE DATE DEFAULT SYSDATE,
    fHIT NUMBER(5) DEFAULT 0,
    fGROUP NUMBER(5),
    fSTEP NUMBER(5),
    fINDENT NUMBER(5),
    fIP VARCHAR2(30)
);
DROP SEQUENCE FILEBOARD_SEQ;
CREATE SEQUENCE FILEBOARD_SEQ MAXVALUE 99999 NOCACHE NOCYCLE;
-- DUMMY DATA (원글과 답변)
SELECT * FROM FILEBOARD;
INSERT INTO FILEBOARD (FNO, SID, FTITLE, FCONTENT, FFILENAME, FGROUP, FSTEP, FINDENT, FIP)
  VALUES (FILEBOARD_SEQ.NEXTVAL, 'aaa','제목','본문', null, 
    FILEBOARD_SEQ.CURRVAL, 0,0, '192.168.0.31');
INSERT INTO FILEBOARD (FNO, SID, FTITLE, FCONTENT, FFILENAME, FGROUP, FSTEP, FINDENT, FIP)
  VALUES (FILEBOARD_SEQ.NEXTVAL, 'bbb','title','content', 'a.docx', 
    FILEBOARD_SEQ.CURRVAL, 0,0, '196.168.0.1');
SELECT * FROM FILEBOARD ORDER BY FGROUP DESC, FSTEP;
-- 위 1 번글에 대한 답변글
UPDATE FILEBOARD SET FSTEP = FSTEP + 1 WHERE FGROUP=1 AND FSTEP>0;
INSERT INTO FILEBOARD (FNO, SID, FTITLE, FCONTENT, FFILENAME, FGROUP, FSTEP, FINDENT, FIP)
  VALUES (FILEBOARD_SEQ.NEXTVAL, 'ccc','reply',null, null, 
    1, 1, 1, '194.161.13.11');
UPDATE FILEBOARD SET FSTEP = FSTEP + 1 WHERE FGROUP=1 AND FSTEP>0;
INSERT INTO FILEBOARD (FNO, SID, FTITLE, FCONTENT, FFILENAME, FGROUP, FSTEP, FINDENT, FIP)
  VALUES (FILEBOARD_SEQ.NEXTVAL, 'hhh','reply2',null, null, 
    1, 1, 1, '194.161.13.11');
COMMIT;
SELECT * FROM FILEBOARD;
------------------------------------------------------------------------------------
------------------------------------  GALLERY  -------------------------------------
------------------------------------------------------------------------------------
-- DROP * CREATE
DROP TABLE GALLERY CASCADE CONSTRAINTS;
CREATE TABLE GALLERY (
    gNO NUMBER(5) PRIMARY KEY,
    sID VARCHAR2(30) REFERENCES STUDENT(sID),
    tID VARCHAR2(30) REFERENCES TEACHER(tID),
    gTITLE VARCHAR2(100) NOT NULL,
    gCONTENT VARCHAR2(4000) NOT NULL,
    gFILENAME VARCHAR2(100) NOT NULL,
    gRDATE DATE DEFAULT SYSDATE,
    gHIT NUMBER(5) DEFAULT 0,
    gIP VARCHAR2(30)
);
DROP SEQUENCE GALLERY_SEQ;
CREATE SEQUENCE GALLERY_SEQ MAXVALUE 99999 NOCACHE NOCYCLE;
-- DUMMY DATA
INSERT INTO GALLERY (GNO, TID, GTITLE, GCONTENT, gFILENAME, GIP) VALUES(GALLERY_SEQ.NEXTVAL,
                'dbswls0209', '개학식', '개학식기념', '학과대앞에서', '192.163.11.12');
INSERT INTO GALLERY (GNO, TID, GTITLE, GCONTENT, gFILENAME, GIP) VALUES(GALLERY_SEQ.NEXTVAL,
                'dbswls0209', '체험학습', '아이들과함께한첫체험학습', '첫체험학습', '192.163.11.12');
INSERT INTO GALLERY (GNO, TID, GTITLE, GCONTENT, gFILENAME, GIP) VALUES(GALLERY_SEQ.NEXTVAL,
                'dbswls0209', '장기자랑', '최우수상축하해', '장기자랑상장', '192.163.11.12');
INSERT INTO GALLERY (GNO, TID, GTITLE, GCONTENT, gFILENAME, GIP) VALUES(GALLERY_SEQ.NEXTVAL,
                'dbswls0209', '여름학교', '여름학교', '방학', '192.163.11.12');
INSERT INTO GALLERY (GNO, TID, GTITLE, GCONTENT, gFILENAME, GIP) VALUES(GALLERY_SEQ.NEXTVAL,
                'dbswls0209', '겨울맞이', '겨울축제', '겨울방학전', '192.163.11.12');
COMMIT;
SELECT * FROM GALLERY;
------------------------------------------------------------------------------------
-----------------------------------   NOTICE   -------------------------------------
------------------------------------------------------------------------------------
DROP TABLE NOTICE CASCADE CONSTRAINTS;
CREATE TABLE NOTICE (
    nNO NUMBER(5) PRIMARY KEY,
    sID VARCHAR2(30) REFERENCES STUDENT(sID),
    tID VARCHAR2(30) REFERENCES TEACHER(tID),
    nTITLE VARCHAR2(100) NOT NULL,
    nCONTENT VARCHAR2(4000) NOT NULL,
    nRDATE DATE DEFAULT SYSDATE,
    nHIT NUMBER(5) DEFAULT 0,
    nIP VARCHAR2(30)
);
DROP SEQUENCE NOTICE_SEQ;
CREATE SEQUENCE NOTICE_SEQ MAXVALUE 99999 NOCACHE NOCYCLE;
-- DUMMY DATA
INSERT INTO NOTICE (NNO, TID, NTITLE, NCONTENT, NIP) VALUES (NOTICE_SEQ.NEXTVAL,
                'dbswls0209', '[3월17일 알림장]', '가위, 딱풀, 색종이, 색연필, A4용지', '192.163.11.12');
INSERT INTO NOTICE (NNO, TID, NTITLE, NCONTENT, NIP) VALUES (NOTICE_SEQ.NEXTVAL,
                'dbswls0209', '[3월18일 알림장]', '추워진날씨 옷 따듯하게 입고 다니세요!', '192.163.11.12');
COMMIT;
SELECT * FROM NOTICE;