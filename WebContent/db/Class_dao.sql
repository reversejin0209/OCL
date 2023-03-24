------------------------------------------------------------------------------------
-----------------------------   STUDENT에 들어갈 query  ------------------------------
------------------------------------------------------------------------------------
-- (1) 회원 ID중복체크
SELECT * FROM STUDENT;
SELECT * FROM STUDENT WHERE SID ='aaa';

-- (2) 회원 join
INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, SPHOTO, SGENDER, SADDRESS)
VALUES ('kim', '11', '김창연', '010-8888-8904', '2012-03-09', 'NO.PNG','kim@chang.com', 'm', '안동시 금곡동');

-- (3) 회원 LOGIN CHECK
SELECT * FROM STUDENT WHERE  SID='kim' AND SPW=11;

-- (4) 회원 SID로 STUDENT DTO 가져오기
SELECT * FROM STUDENT WHERE SID='bbb';

-- (5) 회원정보 수정
UPDATE STUDENT
    SET SPW = '11',
        SNAME = '김민석',
        SEMAIL = 'kim@samsung.com', 
        SBIRTH = '1995-03-03',
        SADDRESS = '서울시 강서구'
    WHERE SID = 'bbb';

-- (6) 회원 리스트 보기(top - n)
SELECT * FROM STUDENT ORDER BY SRDATE DESC;
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM STUDENT ORDER BY SRDATE DESC)A)
    WHERE RN BETWEEN 5 AND 10;

-- (7) 전체 등록된 회원 수
SELECT COUNT(*) CNT FROM STUDENT;

-- (8) 회원 탈퇴
DELETE FROM STUDENT WHERE SID = 'kim';
COMMIT;

------------------------------------------------------------------------------------
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
SELECT * FROM FILEBOARD;
-- (1) 게시판 글목록
SELECT F.*,
    (SELECT SNAME FROM STUDENT WHERE F.SID = SID)SNAME,
    (SELECT TNAME FROM TEACHER WHERE F.TID = TID)TNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM FILEBOARD ORDER BY FRDATE DESC) B)F
    WHERE RN BETWEEN 2 AND 4;
    
-- (2) 게시판 글갯수
SELECT COUNT(*) FROM FILEBOARD;

-- (3) 게시판 글쓰기(원글쓰기) 
INSERT INTO FILEBOARD(FNO, TID, FTITLE, FCONTENT, FFILENAME, fGROUP, FSTEP, FINDENT, FIP)
    VALUES(FILEBOARD_SEQ.NEXTVAL, 'dbswls0209', '안녕얘들아', '진윤진선생님이야 잘부탁해', 'dbswls.png'
      , FILEBOARD_SEQ.CURRVAL, 0, 0, 0);
      
-- (4) 게시판 hit 1회 올리기
UPDATE FILEBOARD SET FHIT = FHIT +1
    WHERE FNO = '2';
SELECT * FROM FILEBOARD;
-- (5) 게시판 글번호(FNO)로 글 전체 내용 (BoardDto)가져오기
SELECT * FROM FILEBOARD WHERE FNO='2';

-- (6) 게시판 글번호(FNO)로 글 전체 내용 (BoardDto)가져오기
SELECT F.*,
    (SELECT SNAME FROM STUDENT WHERE F.SID = SID)SNAME,
    (SELECT TNAME FROM TEACHER WHERE F.TID = TID)TNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM FILEBOARD ORDER BY FRDATE DESC) B)F
    WHERE FNO='7';

-- (7) 게시판 글 수정하기
UPDATE FILEBOARD 
    SET FTITLE = '감사합니다',
        FCONTENT = '정말 잘부탁드립니다',
        FIP = '163.1.1.1',
        FRDATE = SYSDATE
    WHERE SID = 'bbb';
SELECT * FROM FILEBOARD;

-- (8) 게시판 글 삭제하기(메인글을 지우면 모든 답변까지 삭제됨)
DELETE FROM FILEBOARD WHERE SID='ccc';
DELETE FROM FILEBOARD WHERE FGROUP=2 AND (FSTEP>=0 AND 
  FSTEP<(SELECT NVL(MIN(FSTEP),99999) FROM FILEBOARD WHERE FGROUP=0 AND FSTEP>0 AND FINDENT<=0));
-- (9) 게시판 답변글 저장전 작업
UPDATE FILEBOARD SET FSTEP = FSTEP + 1
    WHERE FGROUP = 3 AND FSTEP >0;
    
-- (10) 게시판 답변글 쓰기
SELECT * FROM FILEBOARD WHERE FGROUP='3';
INSERT INTO FILEBOARD(FNO, SID, TID, FTITLE, FCONTENT, FFILENAME, FGROUP, FSTEP, FINDENT, FIP)
    VALUES(FILEBOARD_SEQ.NEXTVAL, 'hhh', null,'감사합니다', '잘부탁드립니다', 'no.png', 3, 1, 1, '192.1.1.1');
-- (10-1)게시판 답변글 확인용
SELECT * FROM FILEBOARD ORDER BY FGROUP DESC, FSTEP;

-- (11) 회원 탈퇴시 발생하는 SID가 쓴 글 모두 삭제
DELETE FROM FILEBOARD WHERE SID='hhh';

------------------------------------------------------------------------------------
------------------------------  GALLERY에 들어갈 query  ------------------------------
------------------------------------------------------------------------------------
-- (1) 앨범등록
INSERT INTO GALLERY(GNO, TID, GTITLE, GCONTENT, GFILENAME, GIP)
    VALUES(GALLERY_SEQ.NEXTVAL,'dbswls0209', '겨울방학식', '겨울방학식', 'NO.PNG', '192.163.11.12');

-- (2) 앨범등록 리스트 (top - n)
SELECT * 
    FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM GALLERY ORDER BY GNO DESC)A)
    WHERE RN BETWEEN 2 AND 4;

-- (3) 앨범등록 갯수
SELECT COUNT(*) FROM GALLERY;

-- (4) 앨범등록 hit 1회 올리기
UPDATE GALLERY SET GHIT = GHIT +1
    WHERE GNO = '1';
    
-- (5) 앨범등록 상세보기
SELECT * FROM GALLERY WHERE TID = 'dbswls0209';

-- (6) 앨범등록 수정하기
UPDATE GALLERY 
    SET GTITLE = '봄이오나봐',
        GCONTENT = '개학전학교풍경',
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
    VALUES(NOTICE_SEQ.NEXTVAL, 'dbswls0209', '[3월22일(목)알림장]', '아침 8시30분까지 교실로 모여주세요', '192.163.11.12');

-- (2) 공지사항 리스트 (top - n)
SELECT * 
    FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM NOTICE ORDER BY NNO DESC)A)
    WHERE RN BETWEEN 2 AND 4;

-- (3) 공지사항 갯수
SELECT COUNT(*) FROM NOTICE;

-- (4) 공지사항 hit 1회 올리기
UPDATE NOTICE SET NHIT = NHIT +1
    WHERE NNO = '1';
    
-- (5) 공지사항 상세보기
SELECT * FROM NOTICE WHERE TID = 'dbswls0209';

-- (6) 공지사항 수정하기
UPDATE NOTICE 
    SET NTITLE = '[3월20일(수)알림장]',
        NCONTENT = '',
        
        NIP = '192.163.11.12'
    WHERE NNO = '4';
-- (7) 공지사항 삭제하기
DELETE FROM NOTICE WHERE NNO='6';