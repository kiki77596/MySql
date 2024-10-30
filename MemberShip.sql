DROP TABLE IF EXISTS  user_coupon;
DROP TABLE IF EXISTS  member_data;
DROP TABLE IF EXISTS  coupon_types;

CREATE TABLE coupon_type (
    coup_id INT PRIMARY KEY auto_increment,
    coup_code VARCHAR(50) NOT null,
    coup_discount Double NOT null,
    coup_description varchar(255)
);


CREATE TABLE user_coupon (
    coup_no INT PRIMARY KEY auto_increment,
    memb_id INT,  
    coup_id INT, 
    coup_issue_date TIMESTAMP, 
    coup_expiry_date TIMESTAMP, 
    coup_is_used TINYINT(1) DEFAULT 0,  
    CONSTRAINT fk_user_coupon_member_data_memb_id
        FOREIGN KEY (memb_id) REFERENCES member_data(memb_id), 
    CONSTRAINT fk_user_coupon_coupon_types_coup_id
        FOREIGN KEY (coup_id) REFERENCES coupon_type(coup_id) 
);


CREATE TABLE member_data (
    memb_id INT PRIMARY KEY auto_increment,
    memb_name VARCHAR(10) NOT null,
    memb_email VARCHAR(50) NOT null unique key,
    memb_tell VARCHAR(10),
    memb_address VARCHAR(80),
    memb_birthday date,
 	memb_password varchar(24) NOT null
 );


