DROP TABLE IF EXISTS  conversation_content;
DROP TABLE IF EXISTS  employee_data;

create table employee_data(
empo_id int  primary key auto_increment ,
empo_name varchar(10) ,
empo_account varchar(24) not null,
empo_password text not null,
empo_public_key text not null
);

create table conversation_content(
memb_id int  auto_increment ,
empo_id int ,
conv_speaking_time datetime(6) default current_timestamp(6),
conv_content varchar(255) not null,

Constraint fk_conversation_content_member_data_memb_id
foreign key (memb_id) references member_data(memb_id),

Constraint fk_conversation_content_employee_data_empo_id
foreign key (empo_id) references employee_data(empo_id)
);

