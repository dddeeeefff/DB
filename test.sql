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

drop procedure if exists sp_t1_insert;
delimiter $$
create procedure sp_t1_insert(ic2 varchar(20), ic3 char(5))
begin
	insert into t1(c2, c3) values (ic2, ic3);
									-- in 은 생략가능
end $$
delimiter ;

call sp_t1_insert('test6', 'bbbbb');
call sp_t1_insert('test7', 'ccccc');
call sp_t1_insert('test8', 'ddddd');
call sp_t1_insert('test9', 'fffff');

-- t1테이블의 c3컬럼 데이터를 변경하는 sp_t1_update 프로시저 생성
-- update의 조건으로는 PK인 c2컬럼으로 작업
drop procedure if exists sp_t1_update;
delimiter $$
create procedure sp_t1_update(ic2 varchar(20), ic3 char(5))
begin
	update t1 set c3 = ic3 where c2 = ic2;
end $$
delimiter ;
call sp_t1_update('test6', 'zzzzz');
call sp_t1_update('test7', 'qqqqq');
select * from t1;

-- t1 테이블의 레코드를 하나 삭제하는 sp_t1_delete 프로시저 생성
drop procedure if exists sp_t1_delete;
delimiter $$
create procedure sp_t1_delete(ic2 varchar(20))
begin
	delete from t1 where c2 = ic2;
end $$
delimiter ;
call sp_t1_delete('test8');
select * from t1;

-- sp_t1_insert와 sp_t1_update, sp_t1_delete를 합친 sp_t1_manage 라는 프로시저 작성
-- 구분자를 따로 받아 구분자로 입력, 수정, 삭제를 구분하여 작업
drop procedure if exists sp_t1_manage;
delimiter $$
create procedure sp_t1_manage(
-- 매개변수를 뭘 받아오지?
	kind char(1), ic2 varchar(20), ic3 char(5)
    -- 구분자변수			변수1			변수2
)
begin
	if kind = 'i' then		-- insert 이면
		insert into t1(c2, c3) values (ic2, ic3);
	elseif kind = 'u' then	-- update 이면
		update t1 set c3 = ic3 where c2 = ic2;
    elseif kind = 'd' then	-- delete 이면
		delete from t1 where c2 = ic2;
    end if;
end $$
delimiter ;
call sp_t1_manage('i', 'test10', 'abcde');
call sp_t1_manage('u', 'test10', 'ooooo');
call sp_t1_manage('d', 'test10', null);
select * from t1;

-- sp_if_test 프로시저 작성
-- 점수를 score라는 매개변수로 받아와 학점을 출력하는 프로시저
-- 학점은 credit이라는 변수를 만들어 저장하고 그 값을 출력
-- 출력내용 : 점수 ==> ? | 학점 ==> ?
drop procedure if exists sp_if_test;
delimiter $$
create procedure sp_if_test(
	score int
)
begin
	declare credit char(1);
    
	if score >= 90 then
		set credit = 'A';
	elseif score >= 80 then
		set credit = 'B';
	elseif score >= 70 then
		set credit = 'C';
	elseif score >= 60 then
		set credit = 'D';
	else
		set credit = 'F';
	end if;
    select concat('점수 ==> ', score), concat('학점 ==> ', credit);
end $$
delimiter ;
call sp_if_test(77);

-- sp_if_test 프로시저를 case를 이용하여 작성 sp_case_test
drop procedure if exists sp_case_test;
delimiter $$
create procedure sp_case_test(
	score int
)
begin
	declare credit char(1);
    case
		when score >= 90 then
			set credit = 'A';
		when score >= 80 then
			set credit = 'B';
		when score >= 70 then
			set credit = 'C';
		when score >= 60 then
			set credit = 'D';
		else
			set credit = 'F';
    end case;
    select concat('점수 ==> ', score), concat('학점 ==> ', credit);
end $$
delimiter ;
call sp_case_test(77);


-- 1 ~ 100 까지의 합을 출력하는 sp_white_test() 프로시저 생성
-- 출력 내용 : 1 ~ 100까지의 합 : 5050
-- 변수는 필요하면 선언하여 사용하고, 선언과 동시에 초기화시켜 사용
drop procedure if exists sp_white_test;
delimiter $$
-- 명령의 종료 표시를 ';'이 아닌 '$$'로 임시 변경한다는 의미
create procedure sp_white_test()
begin
	
	declare i int default 1;	-- 100까지 루프를 돌릴 때 사용할 변수
    declare sum int default 0;
	
	while(i <= 100) do
		set sum = sum + i;
        set i = i + 1;
    end while;
    select concat('1 ~ 100까지의 합 : ', sum);
end $$
delimiter ;
call sp_white_test();

-- 1 ~ 100 까지의 합을 출력하는 sp_white_test2() 프로시저 생성
-- 출력 내용 : 1 ~ 100까지의 합 : 5050
-- 7의 배수는 더하지 않고, 더한 값이 1000이 넘으면 루프를 빠져나와 출력
drop procedure if exists sp_white_test2;
delimiter $$
create procedure sp_white_test2()
begin
	declare i int default 0;	-- 100까지 루프를 돌릴 때 사용할 변수
    declare sum int default 0;
	
	chkLabel : while(i <= 100) do
		set i = i + 1;
		if i % 7 = 0 then
			iterate chkLabel;
            -- 더이상 실행하지 않고 chkLabel 이 지정된 반복문의 조건으로 이동
        end if;
		set sum = sum + i;
		if sum > 1000 then
			leave chkLabel;
            -- 더이상 실행하지 않고 chkLabel 이 지정된 반복문을 빠져나감
		end if;
    end while;
    select concat('1 ~ 100까지의 합 : ', sum);
end $$
delimiter ;
call sp_white_test2();


-- 특정 회원이 가입한지 며칠이 지났는지 출력하는 프로시저 sp_join_day()
-- 회원 ID를 매개변수로 받아 해당 회원의 가입기간을 출력 - id를 어떻게 받아오지? - id에 해당하는 회원의 날짜를 어떻게 뽑아오지? = select
-- 출력 : ??님은 가입한지 ??이 지났습니다.
drop procedure if exists sp_join_day;
delimiter $$
create procedure sp_join_day(miid varchar(20))
begin
	declare joinDate datetime;	-- 가입일을 저장할 변수
    declare curDate datetime;	-- 오늘 날짜를 저장할 변수
    declare dayCount int;		-- 가입기간(일단위)를 저장할 변수
    
    select mi_joindate into joinDate from t_member_info where mi_id = miid;
	-- 받아온 매개변수의 아이디를 이용해 회원가입일을 구해 joinDate 변수에 저장
	set curDate = now();
    set dayCount = datediff(curDate, joinDate);
		-- joinDate부터 curDate까지 가긴을 일수로 계산하여 dayCount 변수에 저장
	select concat(miid,'님은 가입한지 ', dayCount, '일이 지났습니다.');	
end $$
delimiter ;
call sp_join_day('test1');


-- 회원 주소록 테이블에 새로운 주소를 추가하는 프로시저 sp_member_addr_insert()
drop procedure if exists sp_member_addr_insert;
delimiter $$
create procedure sp_member_addr_insert(
	miid varchar(20), maname varchar(20), maphone varchar(13), mazip char(5), maaddr1 varchar(50), maaddr2 varchar(50), mabasic char(1)
)
begin
	if mabasic = 'y' then
	-- 추가하려는 주소를 기본주소로 설정하려면 기존의 기본주소를 일반 주소로 먼저 변경해야 함
		update t_member_addr set ma_basic = 'n'
			where ma_basic = 'y' and mi_id = miid;
    end if;

	insert into t_member_addr (mi_id, ma_name, ma_phone,  ma_zip, ma_addr1, ma_addr2, ma_basic)
    values (miid, maname, maphone, mazip, maaddr1, maaddr2, mabasic);
end $$
delimiter ;
call sp_member_addr_insert(
	'test3', '집주소', null, '11111', '경기도 수원시 권선구', '222-333', 'y'
);
call sp_member_addr_insert(
	'test3', '회사주소', null, '11222', '경기도 수원시 팔달구', '333-444', 'y'
);
select * from t_member_addr;


-- 회원 포인트 사용 내역 추가 프로시저 sp_member_point_insert()
drop procedure if exists sp_member_point_insert;
delimiter $$
create procedure sp_member_point_insert(
	miid varchar(20), mpsu char(1), mppoint int, mpdesc varchar(20), mpdetail varchar(20)
)
begin
	declare pnt int default mppoint;
    if mpsu = 'u' then
		set pnt = mppoint * -1;
    end if;
    -- 포인트 적립이 아닌 사용일 경우 사용된 포인트를 음수로 변경
	insert into t_member_point (mi_id, mp_su, mp_point, mp_desc, mp_detail) 
    values(miid, mpsu, pnt, mpdesc, mpdetail);
    -- update t_member_info set mi_point = mi_point + pnt where mi_id = miid;
    -- 오동작이 있을 경우 계속해서 잘못된 포인트를 보유할 위험이 있는 쿼리
    select sum(mp_point) into pnt from t_member_point where mi_id = miid;
    update t_member_info set mi_point = pnt where mi_id = miid;
end $$
delimiter ;
call sp_member_point_insert('test1', 's', 1500, '후기작성', '555');
call sp_member_point_insert('test1', 'u', 2000, '상품구매', '221215AN1001');
call sp_member_point_insert('test2', 's', 1500, '후기작성', '556');
call sp_member_point_insert('test2', 'u', 1000, '상품구매', '221215AG1002');

select * from t_member_point;
select * from t_member_info;

-- 'test1' 회원의 현재 보유 포인트를 't_member_point' 테이블에서 계산하여 출력


-- 회원 가입 프로시저 sp_member_info_insert()
-- 가입시 가입축하금 지급과 기본주소 등록도 같이 처리해야 함
drop procedure if exists sp_member_info_insert;
delimiter $$
create procedure sp_member_info_insert(
	miid varchar(20), mipw varchar(20), miname varchar(20), migender char(1), mibirth char(10), 
	miphone varchar(13), miemail varchar(50), mipoint int, maname varchar(20),maphone varchar(13),
    mazip char(5), maaddr1 varchar(50), maaddr2 varchar(50), mpdesc varchar(20)

)
begin

	-- 회원 정보 테이블에 insert
	insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_point)
    values(miid, mipw, miname, migender, mibirth, miphone, miemail, mipoint);   
    -- 회원 주소 테이블에 insert 
    call sp_member_addr_insert(miid, maname, maphone,  mazip, maaddr1, maaddr2, 'y');
/*
    insert into t_member_addr (mi_id, ma_name, ma_phone,  ma_zip, ma_addr1, ma_addr2, ma_basic)
    values (miid, maname, maphone, mazip, maaddr1, maaddr2, 'y');
*/
    -- 포인트 사용 내역 테이블에 insert
    call sp_member_point_insert(miid, 's', mipoint, mpdesc, '');
/*
	insert into t_member_point (mi_id, mp_su, mp_point, mp_desc, mp_detail) 
    values(miid, 's', mipoint, mpdesc, '');
*/
end $$
delimiter ;
call sp_member_info_insert('test12', '1111', '도우너', '여', '2000-02-02', '010-5552-3444', 'dounut111@test.com', '1000', 
'집', null, '33333', '경기도 파주시', '555-22', '가입축하금');
select * from t_member_info;
select * from t_member_addr;
select * from t_member_point;


-- 회원 정보 변경 프로시저 sp_member_info_update(kind char(1))
-- 정보 변경(i), 비밀번호 변경(p), 회원 탈퇴(c), 휴면계정 처리(b)
drop procedure if exists sp_member_info_update;
delimiter $$
create procedure sp_member_info_update(kind char(1),
	miid varchar(20), mipw varchar(20), miphone varchar(13), miemail varchar(50)
)
begin
	if kind = 'i' then			-- 회원 정보 변경일 경우
		update t_member_info set mi_phone = miphone, mi_email = miemail 
        where mi_id = miid;
	elseif kind = 'p' then		-- 비밀번호 변경일 경우
		update t_member_info set mi_pw = mipw where mi_id = miid;
    else
		update t_member_info set mi_status = kind where mi_id = miid;
    end if;
end $$
delimiter ;
call sp_member_info_update('i', 'test1', '', '010-1234-5678', 'gildong@test.com');
call sp_member_info_update('p', 'test1', '1111', '', '');
call sp_member_info_update('b', 'abcd', '', '', '');
call sp_member_info_update('c', 'abcd', '', '', '');
select * from t_member_info;

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
insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_point) 
values ('abcd', '1234', '둘리', '남', '1980-01-03', '010-8080-5555', 'dooley@test.com', 1000);
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

-- 회원 포인트 사용내역
create table t_member_point(		
	mp_idx int primary key auto_increment, -- 일련번호
	mi_id varchar(20), 					   -- 회원 ID
	mp_su char(1) default 's', 			   -- 사용/적립
	mp_point int default 0,				   -- 포인트
	mp_desc varchar(20) not null, 		   -- 사용/적립 내용
	mp_detail varchar(20) default '', 	   -- 내역상세
	mp_date datetime default now(), 	   -- 사용/적립일
	constraint fk_member_point_mi_id foreign key (mi_id) references t_member_info(mi_id)
);
-- 네 회원의 가입축하금 지급에 관한 포인트 내역 레코드 insert
insert into t_member_point(mi_id, mp_su, mp_point, mp_desc) 
value('test1', 's', '1000', '가입축하금');
insert into t_member_point(mi_id, mp_su, mp_point, mp_desc) 
value('test2', 's', '500', '관리자 직권');
insert into t_member_point(mi_id, mp_su, mp_point, mp_desc) 
value('test3', 's', '2000', '상품구매');
insert into t_member_point(mi_id, mp_su, mp_point, mp_desc) 
value('abcd', 's', '700', '게시글작성');

select * from t_member_point;

-- 회원별 주소 추출 쿼리(id, 회원명, 주소명, 주소1, 주소2 - 기본주소가 위에 있어야 함)
select a.mi_id, a.mi_name, b.ma_name, b.ma_addr1, b.ma_addr2 
from t_member_info a, t_member_addr b
where a.mi_id = b.mi_id
order by a.mi_id, b.ma_basic desc;

-- 회원별 등록된 주소의 개수를 출력(id, 회원명, 주소개수 - 가입일 순)
select a.mi_id, a.mi_name, count(b.ma_idx) cnt
from t_member_info a, t_member_addr b
where a.mi_id = b.mi_id
group by a.mi_id, a.mi_name
order by a.mi_joindate;

-- 회원별 등록된 주소의 개수를 출력(id, 회원명, 주소개수 - 가입일 순) : 주소가 없는 회원도 출력 outer join?
select a.mi_id, a.mi_name, concat(count(b.ma_idx), "개") cnt
from t_member_info a left join t_member_addr b on a.mi_id = b.mi_id
group by a.mi_id, a.mi_name
order by a.mi_joindate;

select mi_id, mi_name, mi_point from t_member_info
union
select '-', '-', '-'
union
select mi_id, mp_point, mp_desc from t_member_point
union
select mi_id, ma_name, ma_basic from t_member_addr;

-- 주소들 중에서 6대 광역시에 속하는 주소를 출력(우편번호, 주소1)
select ma_zip, ma_addr1 
from t_member_addr 
where left(ma_addr1, 2) in ('대전', '대구', '부산', '광주', '인천', '울산');

-- 주소들 중에서 6대 광역시에 속하지 않는 주소를 출력(우편번호, 주소1)
select ma_zip, ma_addr1 
from t_member_addr 
where left(ma_addr1, 2) not in ('대전', '대구', '부산', '광주', '인천', '울산');

-- 주소가 있는 회원 출력(아이디, 이름, 주소1) : 서브 쿼리 이용
select a.mi_id, a.mi_name, b.ma_addr1 
from t_member_info a, t_member_addr b
where a.mi_id = b.mi_id and 
	a.mi_id in (select mi_id from t_member_addr);

-- 주소가 없는 회원 출력(아이디, 이름, '주소없음') : 서브 쿼리 이용
select mi_id, mi_name, '주소 없음'
from t_member_info
where mi_id not in (select mi_id from t_member_addr);

show index from t_member_info;
show index from t_member_addr;
show index from t_member_point;

create index idx_member_info on t_member_info(mi_name);
drop index idx_member_info on t_member_info;


set global log_bin_trust_function_creators = 1;

-- 두 개의 정수를 받아 더한 후 리턴하는 함수 fn_add() 작성
drop function if exists fn_add;
delimiter $$
create function fn_add(num1 int, num2 int) returns int
begin
	declare sum int;
	set sum = num1 + num2;
	return sum;
end $$
delimiter ;
select fn_add(1, mi_point) from t_member_info;


-- 두 개의 정수를 받아 첫번째 정수를 두번째 정수로 나눈 후 소수 2자리로 리턴 fn_div()
drop function if exists fn_div;
delimiter $$
create function fn_div(num1 int, num2 int) returns float
begin
	declare result float;
	set result = truncate(num1 / num2, 2);
	return result;
end $$
delimiter ;
select fn_div(10, 3);


-- 회원 ID를 입력받아 해당 회원의 나이를 계산하여 리턴 fn_age()
drop function if exists fn_age;
delimiter $$
create function fn_age(miid varchar(20)) returns int
begin
	declare age int;				-- 나이를 저장할 변수
    -- ㅁㅁ mi_birth를 어떻게 뽑아오지?	--> select로 가져온다 ㅁㅁ
    declare nYear int;	-- 현재 연도를 저장할 변수
    declare bYear int;	-- 태어난 연도를 저장할 변수
    
    set nYear =  year(now());		-- 오늘 날짜에서 연도부분만 추출하여 저장
    select left(mi_birth, 4) into bYear from t_member_info where mi_id = miid;
    -- 받아온 회원ID에 해당하는 생일에서 태어난 연도 부분을 추출하여 bYear에 저장
    set age = nYear - bYear;
	return age;
end $$
delimiter ;
select fn_age('test1');
select * from t_member_info;


-- 모든 회원들의 정보 출력(ID, 이름, 생일, ??살, 상태-정상회원, 탈퇴회원, 휴면계정)
drop function if exists fn_mem;
delimiter $$
create function fn_mem(mistatus char(1)) returns varchar(10)
begin
	declare mem varchar(10);
    if mistatus = 'a' then
		set mem = '정상회원';
	elseif mistatus = 'b' then
		set mem = '휴면회원';
	elseif mistatus = 'c' then
		set mem = '탈퇴회원';
	end if;
	return mem;
end $$
delimiter ;
select mi_id, mi_name, mi_birth, concat(fn_age(mi_id), '살'), fn_mem(mi_status) from t_member_info;
select mi_id, mi_name, mi_birth, concat(fn_age(mi_id), '살'), if(mi_status = 'a', '정상회원', 
if(mi_status = 'b', '휴면회원', '탈퇴회원')) from t_member_info;


-- 상품ID를 받아 해당 상품이 할인율이 있으면 할인가를 없으면 정상가를 리턴 fn_price()
drop function if exists fn_price;
delimiter $$
create function fn_price(piid char(7)) returns int
begin
	declare price int;		-- 가격을 저장할 변수
    declare dc int;			-- 할인율을 저장할 변수
    select pi_price into price from t_product_info where pi_id = piid;
    select pi_dc into dc from t_product_info where pi_id = piid;
	
	return price - price * (dc / 100);
end $$
delimiter ;
select fn_price('AA02102');
select pi_price, concat(pi_dc, '%'), fn_price(pi_id) from t_product_info;

select pi_price, concat(pi_dc, '%'), ceil(pi_price - pi_price * (pi_dc / 100)) from t_product_info;
-- select pi_price, concat(pi_dc, '%'), if(pi_dc = 0, pi_price, ceil(pi_price - pi_price * (pi_dc / 100))) from t_product_info;
select * from t_product_info;


-- 트리거 사용 예제
create table test_tr (
	tt_c1 int auto_increment primary key,
    tt_c2 varchar(10) not null,
    tt_c3 varchar(10) default '',
    tt_c4 datetime default now()
);
insert into test_tr(tt_c2, tt_c3) values ('a','b');

create table test_tr2 (
	tt2_c1 int auto_increment primary key,
    tt2_c2 varchar(10) not null,
    tt2_c3 varchar(10) default '',
    tt2_c4 datetime default now()
);

-- test_tr 테이블에 update가 일어나면  test_tr2 테이블에 tt2_c2 컬럼의 값이 'aaa'인 레코드를 삽입하는
-- 트리거 tr_test 생성
drop trigger if exists tr_test;
delimiter $$
create trigger tr_test after update on test_tr for each row
begin
	insert into test_tr2 (tt2_c2) values ('aaa');
end $$
delimiter ;
select * from test_tr;
update test_tr set tt_c2 = 'a', tt_c3 = 'z' where tt_c1 = 1;
select * from test_tr2;


-- test_tr 테이블에 update가 일어나면 tt_c2와 tt_c3의 값들을
-- test_tr2 테이블의 tt2_c2, tt2_c3 컬럼에 저장하는 트리거 tr_test2 생성
drop trigger if exists tr_test2;
delimiter $$
create trigger tr_test2 after update on test_tr for each row
begin
	declare c2 varchar(10);
    declare c3 varchar(10);
    set c2 = old.tt_c2;
    set c3 = old.tt_c3;
	insert into test_tr2 (tt2_c2, tt2_c3) values (c2, c3);
end $$
delimiter ;

select * from test_tr;
update test_tr set tt_c2 = 'w', tt_c3 = 'v' where tt_c1 = 1;
select * from test_tr2;






-- 상품 가격 테이블
create table test_pdt(
	tp_id char(6) primary key,
    tp_name varchar(10) not null,
    tp_price int default 0
);
insert into test_pdt values('aa0101', '좋은 상품', 150000);
insert into test_pdt values('aa0102', '나쁜 상품', 180000);
insert into test_pdt values('aa0103', '보통 상품', 120000);
select * from test_pdt;


-- 상품 가격 변동 히스토리 테이블
create table test_pdt_history(
	tph_idx int auto_increment primary key, -- 일련번호
	tp_id char(6), -- 상품ID
	tph_old int default 0, -- 이전 가격
	tph_new int default 0, -- 변경 가격
	tph_date datetime default now(), -- 변경 일시	
    constraint fk_pdt_history_tp_id foreign key(tp_id) references test_pdt(tp_id)
);

-- 상품테이블에서 가격 변동시 변경전 가격과 변경후 가격을 history 테이블에 저장
drop trigger if exists tr_price;
delimiter $$
create trigger tr_price after update on test_pdt for each row
begin
    declare old_price, new_price int;
    declare tpid char(6);
    
    set old_price = old.tp_price;	-- update전 상품가격
    set new_price = new.tp_price;	-- update후 상품가격
	set tpid = old.tp_id;			-- update되는 상품 id
    if old_price != new_price then	-- update로 가격이 변동될 경우 / 다르다 '<>'도 가능
		insert into test_pdt_history (tp_id, tph_old, tph_new) values (tpid, old_price, new_price);
	end if;
end $$
delimiter ;
select * from test_pdt;
update test_pdt set tp_price = 130000 where tp_id = 'aa0101';
update test_pdt set tp_price = 150000 where tp_id = 'aa0102';
update test_pdt set tp_price = 130000 where tp_id = 'aa0103';
select * from test_pdt_history;










