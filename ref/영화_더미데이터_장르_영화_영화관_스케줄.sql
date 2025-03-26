-- 장르 정보 더미데이터
INSERT ALL
  INTO "GenreInfo" ("genre_id", "genre") VALUES (1, '드라마')
  INTO "GenreInfo" ("genre_id", "genre") VALUES (2, '애니메이션')
  INTO "GenreInfo" ("genre_id", "genre") VALUES (3, '스릴러')
  INTO "GenreInfo" ("genre_id", "genre") VALUES (4, 'SF')
SELECT * FROM dual;



-- 극장관 정보 더미데이터
INSERT ALL
  INTO "CnmTheater" ("cnmTheater_id", "theater_type", "price") VALUES (1, 'IMAX', 15000)
  INTO "CnmTheater" ("cnmTheater_id", "theater_type", "price") VALUES (2, '4DX', 18000)
  INTO "CnmTheater" ("cnmTheater_id", "theater_type", "price") VALUES (3, '일반', 12000)
SELECT * FROM dual;

-- 영화 정보 더미데이터
INSERT ALL
  INTO "MovieInfo" (
    "movie_id", "title", "description", "director",
    "opening_date", "genre_id", "country", "duration", "age_rating"
  ) VALUES (
    1, '승부', '바둑 천재들의 대결을 그린 드라마', '김형주',
    TO_DATE('2025-03-15', 'YYYY-MM-DD'), 1, '대한민국', 130, 12
  )
  INTO "MovieInfo" (
    "movie_id", "title", "description", "director",
    "opening_date", "genre_id", "country", "duration", "age_rating"
  ) VALUES (
    2, '진격의 거인 극장판 라스트 어택', '인류와 거인의 최후 전투를 그린 극장판 애니메이션', '이사야마 하지메',
    TO_DATE('2025-03-20', 'YYYY-MM-DD'), 2, '일본', 120, 15
  )
  INTO "MovieInfo" (
    "movie_id", "title", "description", "director",
    "opening_date", "genre_id", "country", "duration", "age_rating"
  ) VALUES (
    3, '로비', '정치 로비스트의 이야기를 다룬 스릴러 영화', '박정우',
    TO_DATE('2025-03-25', 'YYYY-MM-DD'), 3, '대한민국', 110, 15
  )
  INTO "MovieInfo" (
    "movie_id", "title", "description", "director",
    "opening_date", "genre_id", "country", "duration", "age_rating"
  ) VALUES (
    4, '미키 17', '복제 인간 미키의 우주 탐사 이야기', '봉준호',
    TO_DATE('2025-03-07', 'YYYY-MM-DD'), 4, '미국', 137, 15
  )
SELECT * FROM dual;



-- 스케줄 더미데이터
INSERT ALL
  INTO "Schedule" (
    "schedule_id", "movie_id", "cnmTheater_id", "start_time", "end_time", "total_seat"
  ) VALUES (
    1, 1, 1, TO_DATE('2025-03-26 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-26 16:10:00', 'YYYY-MM-DD HH24:MI:SS'), 200
  )
  INTO "Schedule" (
    "schedule_id", "movie_id", "cnmTheater_id", "start_time", "end_time", "total_seat"
  ) VALUES (
    2, 2, 2, TO_DATE('2025-03-26 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-26 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 180
  )
  INTO "Schedule" (
    "schedule_id", "movie_id", "cnmTheater_id", "start_time", "end_time", "total_seat"
  ) VALUES (
    3, 3, 3, TO_DATE('2025-03-26 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-26 21:50:00', 'YYYY-MM-DD HH24:MI:SS'), 150
  )
  INTO "Schedule" (
    "schedule_id", "movie_id", "cnmTheater_id", "start_time", "end_time", "total_seat"
  ) VALUES (
    4, 4, 1, TO_DATE('2025-03-26 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-27 00:17:00', 'YYYY-MM-DD HH24:MI:SS'), 200
  )
SELECT * FROM dual;

commit