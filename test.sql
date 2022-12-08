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
select * from t1;

-- delete from t1 where c1 = 3;
select * from t1;

select mid('abcdefg', 4, 3);
select replace('abcdefghij', 'cd', 'zz');
select year(now()), month(now()), day(now());
select left(now(), 10), right(now(), 8);

select count(*) from t1;
select * from t1;
select found_rows();

