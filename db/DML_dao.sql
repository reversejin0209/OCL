------------------------------------------------------------------------------------
-----------------------------   STUDENT에 들어갈 query  ------------------------------
------------------------------------------------------------------------------------
-- (1) 회원 ID중복체크
SELECT * FROM STUDENT WHERE SID ='aaa';
SELECT * FROM STUDENT;
-- (2) 회원 email중복체크
SELECT * FROM STUDENT WHERE SEMAIL = 'kim@kim.com';

-- (3) 회원 join
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, SPHOTO, SGENDER, SADDRESS)
VALUES ('kim', '11', '김창연', '010-8888-8904', '2012-03-09', 'NO.PNG','kim@chang.com', 'm', '안동시 금곡동');

-- (4) 회원 LOGIN CHECK
SELECT * FROM STUDENT WHERE  SID='kim' AND SPW='11';

-- (5) 회원 SID로 STUDENT DTO 가져오기
SELECT * FROM STUDENT WHERE SID='bbb';

-- (6) 회원정보 수정
UPDATE STUDENT
    SET SPW = '11',
        SNAME = '김민석',
        SNUMBER = '010-8731-6080',
        SBIRTH = '96-03-07',
        SEMAIL = 'kim@samsung.com', 
        SPHOTO = 'KIM.PNG',
        SADDRESS = '서울시 강서구'
    WHERE SID = 'bbb';

-- (7) 회원 리스트 보기(top - n)
SELECT * FROM STUDENT ORDER BY SRDATE DESC;
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM STUDENT ORDER BY SRDATE DESC)A)
    WHERE RN BETWEEN 5 AND 10;

-- (8) 전체 등록된 회원 수
SELECT COUNT(*) CNT FROM STUDENT;

-- (9) 회원 탈퇴
DELETE FROM STUDENT WHERE SID = 'kim';
COMMIT;

------------------------------------------------------------------
------------------------------  TEACHER에 들어갈 query  ------------------------------
------------------------------------------------------------------------------------
-- (1) TEACHER 로그인
SELECT * FROM TEACHER WHERE TID='dbswls0209' AND TPW='1111';

-- (2) 로그인 후 세션에 넣을 용도 : TEACHER TID로 DTO 가져오기
SELECT * FROM TEACHER WHERE TID='dbswls0209';
COMMIT;

------------------------------------------------------------------------------------
-----------------------------  FILEBOARD에 들어갈 query  -----------------------------
------------------------------------------------------------------------------------
SELECT * FROM FILEBOARD ORDER BY FNO DESC;
-- (1) 게시판 글목록
SELECT * 
    FROM (SELECT ROWNUM RN, A.* FROM (SELECT F.*, MNAME FROM FILEBOARD F, MVC_MEMBER M
    WHERE F.MID=M.MID ORDER BY FGROUP DESC, FSTEP) A)
     WHERE RN BETWEEN 2 AND 4;
SELECT F.*,
    (SELECT SNAME FROM STUDENT WHERE F.SID = SID)SNAME,
    (SELECT TNAME FROM TEACHER WHERE F.TID = TID)TNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM FILEBOARD ORDER BY FGROUP DESC, FSTEP) B)F
    WHERE RN BETWEEN 1 AND 7;
    SELECT * FROM FILEBOARD ORDER BY FGROUP DESC, FSTEP;
-- (2) 게시판 글갯수
SELECT COUNT(*) FROM FILEBOARD;

-- (3) 게시판 글쓰기(원글쓰기), 선생
INSERT INTO FILEBOARD(FNO, TID, FTITLE, FCONTENT, FFILENAME, fGROUP, FSTEP, FINDENT, FIP)
    VALUES(FILEBOARD_SEQ.NEXTVAL, 'dbswls0209', '안녕얘들아', '진윤진선생님이야 잘부탁해', 'dbswls.png'
      , FILEBOARD_SEQ.CURRVAL, 0, 0, 0); 
-- (3-1) 게시판 글쓰기(원글쓰기), 학생
INSERT INTO FILEBOARD(FNO, SID, FTITLE, FCONTENT, FFILENAME, fGROUP, FSTEP, FINDENT, FIP)
    VALUES(FILEBOARD_SEQ.NEXTVAL, 'aaa', '잘부탁드립니다', '선생님', 'NO.IMG'
      , FILEBOARD_SEQ.CURRVAL, 0, 0, 0);

-- (4) 게시판 hit 1회 올리기
UPDATE FILEBOARD SET FHIT = FHIT +1
    WHERE FNO = '183';
SELECT * FROM FILEBOARD;

-- (5) 게시판 글번호(FNO)로 글 전체 내용 (BoardDto)가져오기
SELECT F.*,
    (SELECT SNAME FROM STUDENT WHERE F.SID = SID)SNAME,
    (SELECT TNAME FROM TEACHER WHERE F.TID = TID)TNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM FILEBOARD ORDER BY FRDATE DESC) B)F
    WHERE FNO='183';

-- (6) 게시판 글 수정하기
UPDATE FILEBOARD 
    SET FTITLE = '감사합니다',
        FCONTENT = '정말 잘부탁드립니다',
        Ffilename = 'NO.IMG',
        FIP = '163.1.1.1',
        FRDATE = SYSDATE
    WHERE FNO = '170';
SELECT * FROM FILEBOARD;

-- (7) 게시판 글 삭제하기(메인글을 지우면 모든 답변까지 삭제됨)
DELETE FROM FILEBOARD WHERE SID='ccc';
DELETE FROM FILEBOARD WHERE FGROUP=2 AND (FSTEP>=0 AND 
  FSTEP<(SELECT NVL(MIN(FSTEP),99999) FROM FILEBOARD WHERE FGROUP=0 AND FSTEP>0 AND FINDENT<=0));
-- (8) 게시판 답변글 저장전 작업
UPDATE FILEBOARD SET FSTEP = FSTEP + 1
    WHERE FGROUP = 183 AND FSTEP >0;
COMMIT;
-- (9) 게시판 답변글 쓰기
SELECT * FROM FILEBOARD WHERE FNO = 3;
INSERT INTO FILEBOARD(FNO, SID, TID, FTITLE, FCONTENT, FFILENAME, FGROUP, FSTEP, FINDENT, FIP)
    VALUES(FILEBOARD_SEQ.NEXTVAL, 'hhh', null,'감사합니다', '잘부탁드립니다', 'no.png', 183, 1, 1, '192.1.1.1');
-- (9-1)게시판 답변글 확인용
SELECT * FROM FILEBOARD ORDER BY FGROUP DESC, FSTEP;

-- (10) 회원 탈퇴시 발생하는 SID가 쓴 글 모두 삭제
DELETE FROM FILEBOARD WHERE SID='hhh';

------------------------------------------------------------------------------------
------------------------------  GALLERY에 들어갈 query  ------------------------------
------------------------------------------------------------------------------------
-- (1) 앨범등록
INSERT INTO GALLERY(GNO, TID, GTITLE, GCONTENT, GFILENAME, GIP)
    VALUES(GALLERY_SEQ.NEXTVAL,'dbswls0209', '겨울방학식', '겨울방학식', 'NO.PNG', '192.163.11.12');

-- (2) 앨범등록 리스트 (top - n)
SELECT G.*,
    (SELECT SNAME FROM STUDENT WHERE G.SID = SID)SNAME,
    (SELECT TNAME FROM TEACHER WHERE G.TID = TID)TNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM GALLERY ORDER BY GRDATE DESC) B)G
    WHERE RN BETWEEN 2 AND 4;
-- (3) 앨범등록 갯수
SELECT COUNT(*) FROM GALLERY;

-- (4) 앨범등록 hit 1회 올리기
UPDATE GALLERY SET GHIT = GHIT +1
    WHERE GNO = '1';
    
-- (5) 앨범등록 상세보기
SELECT G.*,
    (SELECT SNAME FROM STUDENT WHERE G.SID = SID)SNAME,
    (SELECT TNAME FROM TEACHER WHERE G.TID = TID)TNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM GALLERY ORDER BY GRDATE DESC) B)G
    WHERE GNO='8';
-- (6) 앨범등록 수정하기
SELECT * FROM GALLERY;
UPDATE GALLERY 
    SET GTITLE = '봄이오나봐',
        GCONTENT = '개학전학교풍경',
        GFILENAME = '꽃샘추위',
        GIP = '163.1.1.1'
    WHERE GNO = '7';
-- (7) 앨범등록 삭제하기
DELETE FROM GALLERY WHERE GNO='10';

------------------------------------------------------------------------------------
------------------------------  NOTICE에 들어갈 query  -------------------------------
------------------------------------------------------------------------------------
SELECT * FROM NOTICE ORDER BY NNO DESC;
-- (1) 공지사항 등록
INSERT INTO NOTICE(NNO, TID, NTITLE, NCONTENT, NIP)
    VALUES(NOTICE_SEQ.NEXTVAL, 'dbswls0209', '[3월27일(월)알림장]', '꽃샘추위가 몰려오고 있어요 조심해주세요', '192.163.11.12');

-- (2) 공지사항 리스트 (top - n)
SELECT N.*,
    (SELECT SNAME FROM STUDENT WHERE N.SID = SID)SNAME,
    (SELECT TNAME FROM TEACHER WHERE N.TID = TID)TNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM NOTICE ORDER BY NRDATE DESC) B)N
    WHERE RN BETWEEN 2 AND 4;

-- (3) 공지사항 갯수
SELECT COUNT(*) FROM NOTICE;

-- (4) 공지사항 hit 1회 올리기
UPDATE NOTICE SET NHIT = NHIT +1
    WHERE NNO = '1';
    
-- (5) 공지사항 상세보기
SELECT N.*,
    (SELECT SNAME FROM STUDENT WHERE N.SID = SID)SNAME,
    (SELECT TNAME FROM TEACHER WHERE N.TID = TID)TNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM NOTICE ORDER BY NRDATE DESC) B)N
    WHERE NNO='3';

-- (6) 공지사항 수정하기    
UPDATE NOTICE 
    SET NTITLE = '[3월17일(금)알림장]',
        NCONTENT = '행복하세요',
        NIP = '163.1.1.1'
    WHERE NNO = '1';
SELECT * FROM NOTICE;
-- (7) 공지사항 삭제하기
DELETE FROM NOTICE WHERE NNO='6';