CREATE TABLE member (
    member_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(120),
    email VARCHAR(160),
    status VARCHAR(20) DEFAULT 'active',
    join_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE trainer (
    trainer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(120),
    specialty VARCHAR(100),
    hourly_rate NUMERIC(10, 2) DEFAULT 0
);

CREATE TABLE group_class (
    class_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trainer_id INT REFERENCES trainer(trainer_id),
    title VARCHAR(120),
    category VARCHAR(60),
    capacity INT DEFAULT 10,
    session_date DATE,
    session_end_date DATE,
    fee NUMERIC(10, 2) DEFAULT 0,
    promo_discount NUMERIC(10, 2)
);

CREATE TABLE class_enrollment (
    enrollment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INT REFERENCES member(member_id),
    class_id INT REFERENCES group_class(class_id),
    enrolled_at DATE DEFAULT CURRENT_DATE
);
