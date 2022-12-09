use world;

select * from city;
select * from country;
select * from countrylanguage;

-- 인구수가 500만 이상인 도시들의 이름과 나라 코드를 추출
-- 같은 나라 코드끼리 오름차순, 같은 나라 안에서 도시들 내림차순
select name, countrycode 
from city 
where population >= 5000000  
order by countrycode asc, name desc;

-- 인구수가 500만 대인 도시들의 전체 정보 추출, 도시명 순으로 정렬
select id, name, countrycode, district, population
from city
-- where population >= 5000000 and population < 6000000
where population between 5000000 and 5999999 
order by name;

-- 인구수가 가장 많은 도시 10개를 추출(도시명, 나라코드, 나라이름)
select city.name, countrycode, country.name 
from city inner join country on countrycode = code 
order by city.population desc 
limit 10;

-- select 가져올컬럼(들) from 테이블1, 테이블2, 테이블3 where 테이블1과2의결합조건 and 테이블3과1또는2의결합조건;
select a.name, a.countrycode, b.name 
from city a, country b
where a.countrycode = b.code 
order by a.population desc 
limit 10;

-- 나라명이 's'로 시작하는 나라들의 나라명, 인구수, 주언어 출력
select a.name, a.population, b.language 
from country a inner join countrylanguage b 
on a.Code = b.countrycode 
where a.name like 's%' and b.Percentage > 50;


