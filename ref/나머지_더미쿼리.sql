-- 데이터 수정
ALTER TABLE "TicketInfo"
DROP CONSTRAINT "FK_TICKETINFO_PAY";


-- 1.권한 더미데이터
--INSERT ALL
--  INTO "Role" ("role_id", "role_name") VALUES (1, 'admin')
--  INTO "Role" ("role_id", "role_name") VALUES (2, 'member')
--  INTO "Role" ("role_id", "role_name") VALUES (3, 'guest')
--SELECT * FROM dual;
--
---- 2. 갤러리 더미데이터
--INSERT ALL
--  INTO "Gallery" ("user_id", "name", "phone_number", "birth_date", "gender", "role_id")
--  VALUES (101, '홍길동', '01012345678', TO_DATE('1990-01-01','YYYY-MM-DD'), '남', 1)
--  
--  INTO "Gallery" ("user_id", "name", "phone_number", "birth_date", "gender", "role_id")
--  VALUES (102, '김영희', '01098765432', TO_DATE('1995-05-15','YYYY-MM-DD'), '여', 2)
--  
--  INTO "Gallery" ("user_id", "name", "phone_number", "birth_date", "gender", "role_id")
--  VALUES (103, '이민호', '01055556666', TO_DATE('2000-09-09','YYYY-MM-DD'), '남', 3)
--SELECT * FROM dual;


-- 3. 상영자리 더미데이터
INSERT ALL
  INTO "SeatInfo" ("seatInfo_id", "user_id", "seat_number", "cnmTheater_id")
  VALUES (201, 101, 'A1', 1)
  INTO "SeatInfo" VALUES (202, 101, 'A2', 1)

  INTO "SeatInfo" VALUES (203, 102, 'B1', 2)
  INTO "SeatInfo" VALUES (204, 102, 'B2', 2)

  INTO "SeatInfo" VALUES (205, 103, 'C1', 3)
  INTO "SeatInfo" VALUES (206, 103, 'C2', 3)
SELECT * FROM dual;





-- 4. 예매정보 더미데이터
INSERT ALL
  INTO "TicketInfo" ("ticket_id", "ticket_code", "schedule_id", "user_id", "personnel", "pay_id")
  VALUES (301, 'TICK001', 1, 101, 2, 401)

  INTO "TicketInfo" ("ticket_id", "ticket_code", "schedule_id", "user_id", "personnel", "pay_id")
  VALUES (302, 'TICK002', 2, 102, 2, 402)

  INTO "TicketInfo" ("ticket_id", "ticket_code", "schedule_id", "user_id", "personnel", "pay_id")
  VALUES (303, 'TICK003', 3, 103, 2, 403)

  INTO "TicketInfo" ("ticket_id", "ticket_code", "schedule_id", "user_id", "personnel", "pay_id")
  VALUES (304, 'TICK004', 4, 101, 2, 404)
SELECT * FROM dual;

-- 5. 결제 더미페이지
INSERT ALL
  INTO "Pay" ("pay_id", "payment_code", "user_id", "ticket_id", "payment_date", "amount")
  VALUES (401, 'PAY001', 101, 301, SYSDATE, 30000)
  
  INTO "Pay" VALUES (402, 'PAY002', 102, 302, SYSDATE, 36000)
  INTO "Pay" VALUES (403, 'PAY003', 103, 303, SYSDATE, 24000)
  INTO "Pay" VALUES (404, 'PAY004', 101, 304, SYSDATE, 30000)
SELECT * FROM dual;

-- TicketSeat 다중테이블 더미데이터
INSERT ALL
  INTO "TicketSeat" ("ticket_id", "seatInfo_id") VALUES (301, 201)
  INTO "TicketSeat" VALUES (301, 202)

  INTO "TicketSeat" VALUES (302, 203)
  INTO "TicketSeat" VALUES (302, 204)

  INTO "TicketSeat" VALUES (303, 205)
  INTO "TicketSeat" VALUES (303, 206)

  INTO "TicketSeat" VALUES (304, 201)
  INTO "TicketSeat" VALUES (304, 202)
SELECT * FROM dual;


COMMIT;

SELECT *
 FROM "Gallery" g 
