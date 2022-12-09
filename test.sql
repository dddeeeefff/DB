use test;

/*
t1이라는 테이블 생성
컬럼 : c1, c2, c3, c4
c1 : 정수를 저장하며 자동증가로 제액조건
c2 : 최대 20자의 문자열을 저장할 컬럼으로 PK로 지정
c3 : 무조건 5자의 문자열을 저장할 컬럼으로 지정
c4 : insert시 오늘 날짜 및 시간을 자동으로 저장할 컬럼으로 지정
*/
create table t1(
	c1 int auto_increment unique,    /* primary key가 따로 존재하는 경우 unique 사용 */
    c2 varchar(20) primary key,
    c3 char(5) not null,
    c4 datetime default now()
);

-- t1테이블의 c2 컬럼 뒤에 c22 최대 20자의 문자열을 저장할 컬럼으로 c22 컬럼(필수입력) 추가
alter table t1 add c22 varchar(20) not null after c2;

-- t1 테이블 삭제
drop table t1;

insert into t1(c2, c3) values ('test', 'abc');
insert into t1(c2, c3) values ('test2', 'abcde');
insert into t1(c2, c3, c4) values ('test4', 123, '2022-12-08 23:59:58');
select * from t1;
update t1 set c2 = 'test1' where c2 = 'test';
update t1 set c3 = 'aaaaa' where c3 = 'abcde';
-- c3의 값이 123인 레코드의 c2컬럼의 값을 'test33'으로 변경하는 update문 작성
update t1 set c2 = 'test33' where c3 = '123';
select * from t1; -- select는 테이블 내의 데이터를 가져오는 것

-- delete from t1 where c1 = 3;
select * from t1;

select mid('abcdefg', 4, 3);
select replace('abcdefghij', 'cd', 'zz');
select year(now()), month(now()), day(now());
select left(now(), 10), right(now(), 8);

select count(*) from t1;
select * from t1;
select found_rows();

select version();

-- 회원 정보 테이블 생성 쿼리
create table t_member_info(
	mi_id varchar(20) primary key,			 -- 아이디
	mi_pw varchar(20) not null,				 -- 비밀번호
	mi_name varchar(20) not null,			 -- 이름
	mi_gender char(1) not null,				 -- 성별
	mi_birth char(10) not null,				 -- 생일
	mi_phone varchar(20) not null unique,	 -- 휴대폰
	mi_email varchar(50) not null unique,	 -- 이메일
	mi_point int default 0,					 -- 보유포인트
	mi_lastlogin datetime,					 -- 최종로그인일자
	mi_joindate datetime default now(),		 -- 가입일
	mi_status char(1) default 'a'			 -- 상태
);
insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_point) 
values ('test1', '1234', '홍길동', '남', '1988-05-20', '010-1234-5678', 'hong@test.com', 1000);
insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_point) 
values ('test2', '1234', '전우치', '남', '1989-10-02', '010-9876-5432', 'woo@test.com', 1000);
insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_point) 
values ('test3', '1234', '임꺽정', '남', '1995-11-02', '010-8888-5555', 'lim@test.com', 1000);
select * from t_member_info;

-- 회원 주소록 테이블 생성 쿼리
create table t_member_addr(					-- 회원주소록
	ma_idx int	primary key auto_increment, -- 일련번호
    mi_id varchar(20),						-- 회원 ID
	ma_name varchar(20) not null,			-- 주소이름
	ma_phone varchar(13),					-- 휴대폰
	ma_zip char(5) not null,	  			-- 우편번호
	ma_addr1 varchar(50) not null, 			-- 주소1
	ma_addr2 varchar(50) not null, 			-- 주소2
	ma_basic char(1) default 'y', 			-- 기본주소여부
	ma_date	datetime default now(), 		-- 등록일
	constraint fk_member_addr_mi_id foreign key (mi_id) references t_member_info(mi_id)
);
-- 홍길동의 주소(집, 회사) 두 개 등록
insert into t_member_addr(mi_id, ma_name, ma_phone, ma_zip, ma_addr1, ma_addr2, ma_basic)
value('test1', '집주소', null, '12345', '서울시 강남구 삼성동', '123-45', 'y');
insert into t_member_addr(mi_id, ma_name, ma_phone, ma_zip, ma_addr1, ma_addr2, ma_basic)
value('test1', '회사주소', null, '12344', '서울시 강남구 서초동', '999-45', 'n');
insert into t_member_addr(mi_id, ma_name, ma_phone, ma_zip, ma_addr1, ma_addr2, ma_basic)
value('test2', '집주소', null, '54321', '부산시 연제구 연산동', '222-33', 'y');
select * from t_member_addr;

-- 회원별 주소 추출 쿼리(id, 회원명, 주소명, 주소1, 주소2 - 기본주소가 위에 있어야 함)
select a.mi_id, a.mi_name, b.ma_name, b.ma_addr1, b.ma_addr2 
from t_member_info a, t_member_addr b
where a.mi_id = b.mi_id
order by a.mi_id, b.ma_basic desc;

-- 회원별 등록된 주소의 개수를 출력(id, 회원명, 주소개수 - 가입일 순)
select a.mi_id, a.mi_name 
from t_member_info a, t_member_addr b
where a.mi_id = b.mi_id
group by a.mi_id, a.mi_name
