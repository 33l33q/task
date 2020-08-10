### Spring Framework 기반 자유게시판
: 로그인 및 회원 가입 없이 자유롭게 글을 작성할 수 있는 게시판
: 게시글 및 댓글 CRUD

### 개발환경 
jsp-api 2.0, Servlet api 3.2, HTML4, CSS3, jQuery, Ajax, JavaScript(ECMAScript3),
BootStrap4, JDK 1.7, Spring framework 3, Mybatis 3, Mybatis-spring 1.2, Oracle11g R 2 (AWS EC R2), 
파일업로드 api – cos.jar, Log4j 1.2, json, Apache Tomcat 8.0

### 테이블 정보
> 1. 글 정보 테이블(ldb_task_board)

컬럼ID		|	데이터 타입(크기)		|	컬럼명
----- 		|	--------		|	---
LNUM		|	VARCHAR2(11 BYTE) FK	|	글번호	
LID		|	VARCHAR2(20 BYTE)	|	글작성자	
LPW		|	VARCHAR2(20 BYTE)	|	글비밀번호	
LTITLE		|	VARCHAR2(100 BYTE)	|	비밀번호	
LCONTENT		|	VARCHAR2(4000 BYTE)	|	글내용	
LIMAGE		|	VARCHAR2(4000 BYTE)	|	글이미지	
LINSERTDATE		|	DATE	|	생성일	
LUPDATEDATE		|	DATE	|	수정일	
LDELETEYN		|	VARCHAR2(1 BYTE)	|	삭제유무	
LHITNUM		|	VARCHAR2(100 BYTE)	|	조회수						
						
> 2. 댓글 정보 테이블 (ldb_task_reply)						
						
컬럼ID		|	데이터 타입(크기)		|	컬럼명
----- 		|	--------		|	---
LRENUM		|	VARCHAR2(11 BYTE) FK	|	댓글번호	
LNUM		|	VARCHAR2(11 BYTE) PK	|	글번호	
LREID		|	VARCHAR2(20 BYTE)	|	댓글작성자	
LREPW		|	VARCHAR2(20 BYTE)	|	댓글비밀번호	
LRECONTENT		|	VARCHAR2(4000 BYTE)	|	댓글내용	
LREINSERTDATE		|	DATE	|	생성일	
LREUPDATEDATE		|	DATE	|	수정일	
LREDELETEYN		|	VARCHAR2(1 BYTE)	|	삭제유무	
