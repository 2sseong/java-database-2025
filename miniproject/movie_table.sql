-- DROP TABLES (역순으로 drop해야 FK 충돌 없음)
DROP TABLE IF EXISTS "TicketSeat";
DROP TABLE IF EXISTS "TicketInfo";
DROP TABLE IF EXISTS "SeatInfo";
DROP TABLE IF EXISTS "Schedule";
DROP TABLE IF EXISTS "Pay";
DROP TABLE IF EXISTS "Gallery";
DROP TABLE IF EXISTS "MovieInfo";
DROP TABLE IF EXISTS "CnmTheater";
DROP TABLE IF EXISTS "GenreInfo";
DROP TABLE IF EXISTS "Role";

-- CREATE TABLES

CREATE TABLE "Role" (
    "role_id"       NUMBER NOT NULL,
    "role_name"     VARCHAR2(100) DEFAULT 'guest',
    CONSTRAINT "PK_ROLE" PRIMARY KEY ("role_id")
);

CREATE TABLE "GenreInfo" (
    "genre_id"      NUMBER NOT NULL,
    "genre"         VARCHAR2(300),
    CONSTRAINT "PK_GENREINFO" PRIMARY KEY ("genre_id")
);

CREATE TABLE "CnmTheater" (
    "cnmTheater_id" NUMBER NOT NULL,
    "theater_type"  VARCHAR2(100),
    "price"         NUMBER,
    CONSTRAINT "PK_CNMTHEATER" PRIMARY KEY ("cnmTheater_id")
);

CREATE TABLE "Gallery" (
    "user_id"       NUMBER NOT NULL,
    "name"          VARCHAR2(300),
    "phone_number"  VARCHAR2(50),
    "birth_date"    DATE NOT NULL,
    "gender"        VARCHAR2(100) NOT NULL,
    "role_id"       NUMBER NOT NULL,
    CONSTRAINT "PK_GALLERY" PRIMARY KEY ("user_id"),
    CONSTRAINT "FK_GALLERY_ROLE" FOREIGN KEY ("role_id") REFERENCES "Role" ("role_id")
);

CREATE TABLE "MovieInfo" (
    "movie_id"      NUMBER NOT NULL,
    "title"         VARCHAR2(300),
    "description"   VARCHAR2(1000),
    "director"      VARCHAR2(300),
    "opening_date"  DATE,
    "genre_id"      NUMBER NOT NULL,
    "country"       VARCHAR2(300) NOT NULL,
    "duration"      NUMBER NOT NULL,
    "age_rating"    NUMBER NOT NULL,
    CONSTRAINT "PK_MOVIEINFO" PRIMARY KEY ("movie_id"),
    CONSTRAINT "FK_MOVIEINFO_GENRE" FOREIGN KEY ("genre_id") REFERENCES "GenreInfo" ("genre_id")
);

CREATE TABLE "Schedule" (
    "schedule_id"   NUMBER NOT NULL,
    "movie_id"      NUMBER NOT NULL,
    "cnmTheater_id" NUMBER NOT NULL,
    "start_time"    DATE,
    "end_time"      DATE NOT NULL,
    "total_seat"    NUMBER NOT NULL,
    CONSTRAINT "PK_SCHEDULE" PRIMARY KEY ("schedule_id"),
    CONSTRAINT "FK_SCHEDULE_MOVIE" FOREIGN KEY ("movie_id") REFERENCES "MovieInfo" ("movie_id"),
    CONSTRAINT "FK_SCHEDULE_THEATER" FOREIGN KEY ("cnmTheater_id") REFERENCES "CnmTheater" ("cnmTheater_id")
);

CREATE TABLE "SeatInfo" (
    "seatInfo_id"   NUMBER NOT NULL,
    "user_id"       NUMBER NOT NULL,
    "seat_number"   VARCHAR2(100),
    "cnmTheater_id" NUMBER NOT NULL,
    CONSTRAINT "PK_SEATINFO" PRIMARY KEY ("seatInfo_id"),
    CONSTRAINT "FK_SEATINFO_GALLERY" FOREIGN KEY ("user_id") REFERENCES "Gallery" ("user_id"),
    CONSTRAINT "FK_SEATINFO_THEATER" FOREIGN KEY ("cnmTheater_id") REFERENCES "CnmTheater" ("cnmTheater_id")
);

CREATE TABLE "TicketInfo" (
    "ticket_id"         NUMBER NOT NULL,
    "ticket_code"       VARCHAR2(300),
    "schedule_id"       NUMBER NOT NULL,
    "user_id"           NUMBER NOT NULL,
    "personnel"         NUMBER,
    "reservation_time"  DATE DEFAULT SYSDATE,
    "pay_id"            NUMBER NOT NULL,
    CONSTRAINT "PK_TICKETINFO" PRIMARY KEY ("ticket_id"),
    CONSTRAINT "FK_TICKETINFO_SCHEDULE" FOREIGN KEY ("schedule_id") REFERENCES "Schedule" ("schedule_id"),
    CONSTRAINT "FK_TICKETINFO_GALLERY" FOREIGN KEY ("user_id") REFERENCES "Gallery" ("user_id")
);

CREATE TABLE "Pay" (
    "pay_id"        NUMBER NOT NULL,
    "payment_code"  VARCHAR2(100),
    "user_id"       NUMBER NOT NULL,
    "ticket_id"     NUMBER NOT NULL,
    "payment_date"  DATE,
    "amount"        NUMBER,
    CONSTRAINT "PK_PAY" PRIMARY KEY ("pay_id"),
    CONSTRAINT "FK_PAY_GALLERY" FOREIGN KEY ("user_id") REFERENCES "Gallery" ("user_id"),
    CONSTRAINT "FK_PAY_TICKET" FOREIGN KEY ("ticket_id") REFERENCES "TicketInfo" ("ticket_id")
);

ALTER TABLE "TicketInfo"
    ADD CONSTRAINT "FK_TICKETINFO_PAY" FOREIGN KEY ("pay_id") REFERENCES "Pay" ("pay_id");

CREATE TABLE "TicketSeat" (
    "ticket_id"    NUMBER NOT NULL,
    "seatInfo_id"  NUMBER NOT NULL,
    CONSTRAINT "PK_TICKETSEAT" PRIMARY KEY ("ticket_id", "seatInfo_id"),
    CONSTRAINT "FK_TICKETSEAT_TICKET" FOREIGN KEY ("ticket_id") REFERENCES "TicketInfo" ("ticket_id"),
    CONSTRAINT "FK_TICKETSEAT_SEAT" FOREIGN KEY ("seatInfo_id") REFERENCES "SeatInfo" ("seatInfo_id")
);

commit