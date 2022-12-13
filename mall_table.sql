use mall;

create table t_admin_info (	 -- 관리자 정보 테이블
	ai_idx int auto_increment unique,	 	   -- 일련번호
	ai_id varchar(20) primary key,			   -- 아이디
	ai_qw varchar(20) not null,     		   -- 비밀번호
	ai_name	varchar(20) not null,      		   -- 이름
	ai_use char(1) default 'y',			   	   -- 사용여부
	ai_date	datetime default now() 			   -- 등록일
);

insert into t_admin_info (ai_id, ai_qw, ai_name) values('admin','1111','관리자');
select * from t_admin_info;


-- 회원 정보 테이블 
create table t_member_info ( -- 회원정보			
	mi_id varchar(20) primary key,	 		 -- 회원 ID
	mi_pw varchar(20) not null,				 -- 비밀번호
	mi_name	varchar(20)	not null,			 -- 이름
	mi_gender char(1) not null,				 -- 성별
	mi_birth char(10) not null,				 -- 생일
	mi_phone varchar(13) not null unique,	 -- 휴대폰
	mi_email varchar(50) not null,			 -- 이메일
	mi_point int default 0,					 -- 보유포인트
	mi_lastlogin datetime,					 -- 최종로그인일자
	mi_joindate	datetime default now(),		 -- 가입일
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
	ma_idx int primary key auto_increment, -- 일련번호
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

insert into t_member_addr(mi_id, ma_name, ma_zip, ma_addr1, ma_addr2, ma_basic)
value('test1', '집주소', '12345', '서울시 강남구 삼성동', '123-45', 'y');
insert into t_member_addr(mi_id, ma_name, ma_zip, ma_addr1, ma_addr2, ma_basic)
value('test1', '회사주소', '12344', '서울시 강남구 서초동', '999-45', 'n');
insert into t_member_addr(mi_id, ma_name, ma_zip, ma_addr1, ma_addr2, ma_basic)
value('test2', '집주소', '54321', '부산시 연제구 연산동', '222-33', 'y');
insert into t_member_addr(mi_id, ma_name, ma_zip, ma_addr1, ma_addr2, ma_basic)
value('test3', '집주소', '11223', '인천시 부평구 부평동', '11-33', 'y');
select * from t_member_addr;

-- 회원 포인트 사용내역
create table t_member_point( -- 회원포인트 내역			
	mp_idx int primary key auto_increment, -- 일련번호
	mi_id varchar(20), -- fk 회원 ID
	mp_su char(1) default 's', -- 사용/적립
	mp_point int default 0, -- 포인트
	mp_desc	varchar(20)	not null, -- 사용/적립내용
	mp_detail varchar(20) default '', -- 내역상세
	mp_date datetime default now(), -- 사용/적립일
	mp_admin int default 0, -- 관리자 번호
	constraint fk_member_point_mi_id foreign key (mi_id) references t_member_info(mi_id)
);
insert into t_member_point(mi_id, mp_su, mp_point, mp_desc) 
value('test1', 's', '1000', '가입축하금');
insert into t_member_point(mi_id, mp_su, mp_point, mp_desc) 
value('test2', 's', '1000', '가입축하금');
insert into t_member_point(mi_id, mp_su, mp_point, mp_desc) 
value('test3', 's', '1000', '가입축하금');
select * from t_member_point;

-- 회원 상태 변경 정보
create table t_member_status (	
	ms_idx int primary key auto_increment,	 -- 일련번호
	mi_id varchar(20),						 --  fk 회원 ID
	ms_status char(1) not null,				 -- 상태 변경값
	ms_reason varchar(200) not null,		 -- 사유
	ms_self	int default	0, 					 -- 본인여부
	ms_date	datetime default now(), 		 -- 일시
	constraint fk_member_status_mi_id foreign key (mi_id) references t_member_info(mi_id)
);
select * from t_member_status;

-- 상품 대분류
create table t_product_ctgr_big (			
	pcb_id	char(2)	primary key,	 -- 대분류 코드
	pcb_name varchar(20) not null	 -- 대분류 이름
);
insert into t_product_ctgr_big values ('AA', '구두');
insert into t_product_ctgr_big values ('BB', '운동화');
select * from t_product_ctgr_big;

-- 상품 소분류	
create table t_product_ctgr_small (		
	pcs_id	char(4)	primary key,	 -- 소분류 코드
	pcb_id	char(2),				 -- fk	대분류 코드
	pcs_name varchar(20) not null,	 -- 소분류 이름
	constraint fk_product_ctgr_small_pcb_id foreign key (pcb_id) references t_product_ctgr_big(pcb_id)
);
insert into t_product_ctgr_small values ('AA01', 'AA', '로퍼');
insert into t_product_ctgr_small values ('AA02', 'AA', '윙팁');
insert into t_product_ctgr_small values ('AA03', 'AA', '더비');
insert into t_product_ctgr_small values ('BB01', 'BB', '러닝화');
insert into t_product_ctgr_small values ('BB02', 'BB', '농구화');
insert into t_product_ctgr_small values ('BB03', 'BB', '스니커즈');
select * from t_product_ctgr_small;

-- 상품 브랜드
create table t_product_brand (			
	pb_id	char(2)	primary key, -- 브랜드 코드
	pb_name	varchar(20)	not null -- 브랜드 이름
);
insert into t_product_brand values ('B1', '랜드로버');
insert into t_product_brand values ('B2', '리갈');
insert into t_product_brand values ('B3', '나이키');
insert into t_product_brand values ('B4', '아디다스');
select * from t_product_brand;

-- 상품정보
create table t_product_info (		
	pi_id char(7) primary key,			 -- 상품 ID
	pcs_id char(4),						 -- fk 소분류 코드
	pb_id char(2),						 -- fk 브랜드 코드
	pi_name varchar(50)	not null,		 -- 상품명
	pi_price int default 0,				 -- 가격
	pi_cost int	default 0,				 -- 원가
	pi_dc int default 0,				 -- 할인율
	pi_com varchar(20) not null,		 -- 제조사
	pi_img1	varchar(50) not null,		 -- 상품 이미지1
	pi_img2	varchar(50)	default '',		 -- 상품 이미지2
	pi_img3	varchar(50)	default '',		 -- 상품 이미지3
	pi_desc	varchar(50)	not null,		 -- 설명 이미지
	pi_special varchar(4) default '',	 -- 특별 상품 여부
	pi_read	int	default 0,				 --  조회수
	pi_score float default 0,			 -- 평균평점
	pi_review int default 0,			 -- 리뷰개수
	pi_sale	int	default 0,				 -- 판매량
	pi_isview char(1) default 'n',		 -- 게시여부
	pi_date	datetime default now(),		 -- 등록일
	ai_idx int,							 -- fk 등록관리자
	pi_last	datetime default now(),		 -- 최종 수정일
	pi_ai_idx int default 0,			 -- 최종 수정자
	constraint fk_product_info_pcs_id foreign key (pcs_id) references t_product_ctgr_small(pcs_id),
	constraint fk_product_info_pb_id foreign key (pb_id) references t_product_brand(pb_id),
	constraint fk_product_info_ai_idx foreign key (ai_idx) references t_admin_info(ai_idx)
);
insert into t_product_info(pi_id, pcs_id, pb_id, pi_name, pi_price, pi_cost, pi_dc, pi_com, pi_img1, pi_desc, pi_isview, ai_idx) 
values ('AA01101', 'AA01', 'B1', '좋은 로퍼', 150000, 80000, 0, '좋은 회사', 'AA01101_1.jpg', 'AA01101_d.jpg', 'y', 1);
insert into t_product_info(pi_id, pcs_id, pb_id, pi_name, pi_price, pi_cost, pi_dc, pi_com, pi_img1, pi_desc, pi_isview, ai_idx) 
values ('AA02102', 'AA02', 'B2', '좋은 윙팁', 180000, 90000, 10, '좋은 회사', 'AA01102_1.jpg', 'AA02102_d.jpg', 'y', 1);
insert into t_product_info(pi_id, pcs_id, pb_id, pi_name, pi_price, pi_cost, pi_dc, pi_com, pi_img1, pi_desc, pi_isview, ai_idx) 
values ('BB01103', 'BB01', 'B3', '뛰는 러닝화', 130000, 70000, 0, '좋은 회사2', 'BB01103_1.jpg', 'BB01103_d.jpg', 'y', 1);
select * from t_product_info;

-- 상품 옵션별 재고
create table t_product_stock (			
	ps_idx int primary key auto_increment,	 -- 일련번호
	pi_id char(7),							 -- fk 상품 ID
	ps_size int	default 0,					 -- 사이즈
	ps_stock int default 0,					 -- 재고량
	ps_sale int	default 0,					 -- 판매량
	ps_isview char(1) default 'n' ,			 -- 게시여부
	constraint fk_product_stock_pi_id foreign key (pi_id) references t_product_info(pi_id)
);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA01101', 250, 100);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA01101', 255, 110);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA01101', 260, 120);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA01101', 265, 130);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA01101', 270, 140);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA01101', 275, 150);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA01101', 280, 160);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA02102', 220, 120);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA02102', 225, 125);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA02102', 230, 130);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA02102', 235, 135);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA02102', 240, 140);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA02102', 245, 145);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('AA02102', 250, 150);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('BB01103', 220, 115);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('BB01103', 230, 120);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('BB01103', 240, 125);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('BB01103', 250, 130);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('BB01103', 260, 135);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('BB01103', 270, 140);
insert into t_product_stock (pi_id, ps_size, ps_stock) values ('BB01103', 280, 145);
select * from t_product_stock;

-- 장바구니
create table t_order_cart (		
	oc_idx int primary key auto_increment,	 -- 일련번호
	mi_id varchar(20),						 -- fk 회원 ID
	pi_id char(7),							 -- fk 상품 ID
	ps_idx int,								 -- fk 옵션별 재고 ID
	oc_cnt int default 0 ,					 -- 개수
	oc_date	datetime default now(),			 -- 등록일
	constraint fk_order_cart_mi_id foreign key (mi_id) references t_member_info(mi_id),
	constraint fk_order_cart_pi_id foreign key (pi_id) references t_product_info(pi_id),
	constraint fk_order_cart_ps_idx foreign key (ps_idx) references t_product_stock(ps_idx)
);
-- insert into t_order_cart (mi_id, pi_id, oc_cnt) values ('test1', 'AA01101', '0');
select * from t_order_cart;

-- 주문정보	
create table t_order_info (
	oi_id char(12) primary key,		 -- 주문번호
	mi_id varchar(20),				 -- fk 회원 ID
	oi_name	varchar(20)	not null,	 -- 수취인명
	oi_phone varchar(13) not null,	 -- 배송지 전화번호
	oi_zip char(5) not null,		 -- 배송지 우편번호
	oi_addr1 varchar(50) not null,	 -- 배송지 주소1
	oi_addr2 varchar(50) not null,	 -- 배송지 주소2
	oi_memo	varchar(50),			 -- 요청사항
	oi_payment char(1) default 'a',	 -- 결제수단
	oi_pay int default 0,			 -- 결제액
	oi_upoint int default 0,		 -- 사용 포인트
	oi_spoint int default 0,		 -- 적립 포인트
	oi_invoice varchar(50),			 -- 송장번호
	oi_status char(1) default 'a',	 -- 주문상태
	oi_date	datetime default now(),	 -- 주문일
	constraint fk_order_info_mi_id foreign key (mi_id) references t_member_info(mi_id)
);
select * from t_order_info;

-- 주문 상세 정보
create table t_order_detail (	
	od_idx int primary key auto_increment,	 -- 일련번호
	oi_id char(12),							 -- fk 주문번호
	pi_id char(7),							 -- fk 상품 ID
	ps_idx int,								 -- fk 옵션별 재고 ID
	od_cnt int default 0,					 -- 개수
	od_price int default 0,					 -- 단가
	od_name varchar(50)	not null,			 -- 상품명
	od_img varchar(50)	not null,			 -- 상품이미지
	od_size	int	default 0,					 -- 옵션명(사이즈)
	constraint fk_order_detail_oi_id foreign key (oi_id) references t_order_info(oi_id),
	constraint fk_order_detail_pi_id foreign key (pi_id) references t_product_info(pi_id),
	constraint fk_order_detail_ps_idx foreign key (ps_idx) references t_product_stock(ps_idx)
);
select * from t_order_detail;

-- 	공지사항
create table t_bbs_notice (			
	bn_idx int primary key,			 -- 글번호
	bn_ctgr varchar(10)	not null,	 -- 분류
	ai_idx int,						 -- fk 작성자
	bn_title varchar(100) not null,	 -- 제목
	bn_content text	not null,		 -- 내용
	bn_read	int default 0,			 -- 조회수
	bn_isview char(1) default 'n',	 -- 게시여부
	bn_date datetime default now(),	 -- 작성일
	constraint fk_bbs_notice_ai_idx foreign key (ai_idx) references t_admin_info(ai_idx)
);

-- QnA	
create table t_bbs_qna (		
	bq_idx int primary key,			 -- 글번호
	mi_id varchar(20),				 -- fk 회원 ID
	bq_ctgr char(1) default 'a',	 -- 질문 분류
	bq_title varchar(100) not null,	 -- 질문 제목
	bq_content text	not null,		 -- 질문 내용
	bq_img1	varchar(50),			 -- 이미지1
	bq_img2	varchar(50),			 -- 이미지2
	bq_ip varchar(15) not null,		 -- 질문자 IP
	bq_qdate datetime default now(), -- 질문일자
	bq_isanswer char(1) default	'n', -- 답변 여부
	bq_ai_idx int default 0,		 -- 답변 관리자
	bq_answer text,					 -- 답변 내용
	bq_satis char(1) default 'z',	 -- 답변 만족도
	bq_adate datetime,				 -- 답변일자
	bq_isview char(1) default 'y',	 -- 게시 여부
	constraint fk_bbs_qna_mi_id foreign key (mi_id) references t_member_info(mi_id)
);