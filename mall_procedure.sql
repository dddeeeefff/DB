use mall;


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


-- 게시판 관련 프로시저들
-- 공지사항 관리(입력(i), 수정, 삭제) 프로시저 sp_notice_manage(kind char(1))
drop procedure if exists sp_notice_manage;
delimiter $$
create procedure sp_notice_manage(kind char(1),
	bnidx int, bnctgr varchar(10), aiidx int, bntitle varchar(100), bncontent text, bnisview char(1)
)
begin
	if kind = 'i' then
		insert into t_bbs_notice (bn_idx, bn_ctgr, ai_idx, bn_title, bn_content, bn_isview) 
        values (bnidx, bnctgr, aiidx, bntitle, bncontent, bnisview);
    else
		update t_bbs_notice set bn_ctgr = bnctgr, bn_title = bntitle, bn_content = bncontent, bn_isview = bnisview 
        where bn_idx = bnidx;
    end if;
end $$
delimiter ;
/*
call sp_notice_manage('i','1','점검','1','서버오류','5시간 점검','n');
call sp_notice_manage('','','','','','','');
call sp_notice_manage('','','','','','','');
select * from sp_notice_manage;
select * from t_admin_info;
*/


-- QnA 관리(질문등록, 질문수정, 답변등록, 답변평가) 프로시저 sp_qna_manage()
drop procedure if exists sp_qna_manage;
delimiter $$
create procedure sp_qna_manage (kind char(1),
	bqidx int, miid varchar(20), bqctgr char(1), bqtitle varchar(100), bqcontent text, bqimg1 varchar(50), 
    bqimg2 varchar(50), bqip varchar(15), bqisanswer char(1), bqaiidx int, bqanswer text, bqsatis char(1), bqisview char(1)
)
begin
	if kind = 'i' then			-- 질문등록일 경우
		insert into t_bbs_qna(bq_idx, mi_id, bq_ctgr, bq_title, bq_content, bq_img1, bq_img2, bq_ip) 
        values (bqidx, miid, bqctgr, bqtitle, bqcontent, bqimg1, bqimg2, bqip);
	elseif kind = 'u' then		-- 질문수정일 경우(답변이 달리기 전에만 가능)
		update t_bbs_qna set bq_ctgr = bqctgr, bq_title = bqtitle, bq_content = bqcontent, bq_img1 = bq_img1, bq_img2 = bqimg2
        where bq_idx = bqidx and mi_id = miid;
    elseif kind = 'a' then						-- 답변등록일 경우
		update t_bbs_qna set bq_isanswer = bqisanswer, bq_ai_idx = bqaiidx, bq_answer = bqanswer, bq_satis = bqsatis, bq_adate = now(), bq_isview = bqisview
        where bq_idx = bqidx;
	else	
		update t_bbs_qna set bq_satis = bqsatis 
        where bq_idx = bqidx and mi_id = miid;
    end if;
end $$
delimiter ;
call sp_qna_manage ('i', 1, 'test1', 'a', '질문입니다.', '내용입니다.', null, null, '127.0.0.1', '', 0, '', '', '');
call sp_qna_manage ('u', 1, '', 'b', '질문 2', '내용입니다2.', null, null, '', '', 0, '', '', '');
call sp_qna_manage ('a', 1, '', '', '', '', null, null, '', 'y', 1, '답변입니다.', '', 'y');
call sp_qna_manage ('s', 1, 'test1', '', '', '', null, null, '', '', 0, '', 'c', '');
select * from t_bbs_qna;


-- 자유게시판 관리(입력, 수정, 삭제) 프로시저 sp_free_manage()
drop procedure if exists sp_free_manage;
delimiter $$
create procedure sp_free_manage(kind char(1),
bfidx int, bfismem char(1), bfwriter varchar(20), bfpw varchar(20), bfheader varchar(20), bftitle varchar(100), bfcontent text, 
bfip varchar(15)
)
begin
	if kind = 'i' then
		insert into t_bbs_free(bf_idx, bf_ismem, bf_writer, bf_pw, bf_header, bf_title, bf_content, bf_ip)
        values(bfidx, bfismem, bfwriter, bfpw, bfheader, bftitle, bfcontent, bfip);
    elseif kind = 'u' and bfismem = 'y' then 		-- 회원글이면 
				update t_bbs_free set bf_header = bfheader, bf_title = bftitle, bf_content = bfcontent
				where bf_idx = bfidx and bf_writer = bfwriter;
	elseif kind = 'u' and bfismem = 'n' then		-- 비회원글이면
				update t_bbs_free set bf_header = bfheader, bf_title = bftitle, bf_content = bfcontent
				where bf_idx = bfidx and bf_pw = bfpw;
	elseif kind = 'd' and bfismem = 'y' then		-- 회원글 삭제이면	
				update t_bbs_free set bf_isdel = 'y'
                where  bf_idx = bfidx and bf_writer = bfwriter;
	elseif kind = 'd' and bfismem = 'n' then		-- 비회원글 삭제이면	
				update t_bbs_free set bf_isdel = 'y'
				where bf_idx = bfidx and bf_pw = bfpw;
    end if;
end $$
delimiter ;
call sp_free_manage('i', 1, 'y', 'test1', '', '스포츠', '월드컵 16강 탈락', '짜증나', '127.0.0.1');
call sp_free_manage('u', 1, 'y', 'test1', '', '스포츠', '월드컵 16강 탈락', '짜증나!!', '127.0.0.1');
select * from t_bbs_free;


-- 자유게시판 댓글 관리(등록, 삭제) 프로시저 sp_free_reply_manage()
drop procedure if exists sp_free_reply_manage;
delimiter $$
create procedure sp_free_reply_manage(kind char(1),
	bfridx int, bfidx int, bfrismem char(1), bfrwriter varchar(20), bfrpw varchar(20), bfrcontent varchar(200), 
    bfrip varchar(15), bfrisdel char(1)
)
begin
	if kind = 'i' then 
		insert into t_bbs_free_reply(bf_idx, bfr_ismem, bfr_writer, bfr_pw, bfr_content, bfr_ip) 
        values(bfidx, bfrismem, bfrwriter, bfrpw, bfrcontent, bfrip);
        
        update t_bbs_free set bf_reply = bf_reply + 1 where bf_idx = bfidx;
        -- 원본 게시글의 댓글 개수를 1 증가시키는 쿼리
        
	elseif kind = 'a' then				-- 관리자가 삭제할 경우
		update t_bbs_free_reply set bfr_isdel = 'a' where bfr_idx = bfridx;
        
        update t_bbs_free set bf_reply = bf_reply - 1 where bf_idx = bfidx and bf_reply > 0;
        -- 원본 게시글의 댓글 개수를 1 감소시키는 쿼리(음수가 되지 않도록 조건 추가)
	else								-- 본인이 삭제할 경우
		begin
			if bfrismem = 'y' then 		-- 회원이 등록한 댓글일 경우
				update t_bbs_free_reply set bfr_isdel = 'y'
                where bfr_idx = bfridx and bfr_writer = bfrwriter;
            else						-- 비회원이 등록한 댓글일 경우
				update t_bbs_free_reply set bfr_isdel = 'y'
                where bfr_idx = bfridx and bfr_pw = bfrpw;
            end if;
			update t_bbs_free set bf_reply = bf_reply - 1 where bf_idx = bfidx and bf_reply > 0;
	        -- 원본 게시글의 댓글 개수를 1 감소시키는 쿼리(음수가 되지 않도록 조건 추가)
        end;
	end if;
end $$
delimiter ;
call sp_free_reply_manage('i',0, 1, 'y', 'test2', '', '댓글입니다', '127.0.0.1', 'n');
call sp_free_reply_manage('i',0, 1, 'n', 'ㅇㅇ', '1111', '댓글2', '127.0.0.1', 'n');
call sp_free_reply_manage('y',7, 1, 'y', 'test2', '', '', '', 'y');
select * from t_bbs_free_reply;
delete from t_bbs_free_reply;



-- 주문처리 프로시저 sp_order_insert()
-- insert : t_order_info, t_order_detail
-- update : t_product_info, t_product_stock, t_member_info, t_member_point
-- delete : t_order_cart
/*
drop procedure if exists sp_order_insert;
delimiter $$
create procedure sp_order_insert(
oiid char(12), miid varchar(20), oiname varchar(20), oiphone varchar(13), oizip char(5), oiaddr1 varchar(50),oiaddr2 varchar(50), 
oimemo varchar(50), oipayment char(1), oipay int, oiupoint int, oispoint int, oiinvoice varchar(50), oistatus char(1)
)
begin
	insert into t_order_info (
    oi_id, oi_name, oi_name, oi_phone, oi_zip, oi_addr1, oi_addr2, oi_memo, oi_payment, oi_pay, oi_upoint, oi_spoint, oi_invoice, oi_status
    )
    values(
    oiid, oiname, oiname, oiphone, oizip, oiaddr1, oiaddr2, oimemo, oipayment, oipay, oiupoint, oispoint, oiinvoice, oistatus
    );
end $$
delimiter ;
*/

















