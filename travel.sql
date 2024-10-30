DROP TABLE IF EXISTS  travel_order;
DROP TABLE IF EXISTS  Ships_Schedule;
DROP TABLE IF EXISTS  route;

CREATE TABLE route (
    route_id INT PRIMARY KEY auto_increment,
    route_name VARCHAR(60),
    route_price int,
    route_depiction longtext,
    route_days INT
);

CREATE TABLE ships_schedule (
    ship_id INT PRIMARY KEY auto_increment,
    route_id INT,
    ship_status VARCHAR(20) NOT null,
    ship_shipping_time Datetime NOT null,
    ship_shipping_dock VARCHAR(60) NOT null,
    ship_rooms_booked INT NOT null,
    CONSTRAINT fk_Ships_Schedule_route_route_id
    FOREIGN KEY (route_id) REFERENCES route(route_id)
);

CREATE TABLE travel_order (
    trav_orde_id INT PRIMARY KEY auto_increment,
	memb_id INT,
	ship_id INT,
	coup_id INT,
	trav_orde_status VARCHAR(20) NOT null,
	room_amount INT NOT null,
	trav_orde_amount VARCHAR(20) NOT null,

	Constraint fk_travel_order_member_data_memb_id
	foreign key (memb_id) references member_data(memb_id),
	Constraint fk_travel_order_Ships_Schedule_ship_id
	foreign key (ship_id) references ships_schedule(ship_id),
	Constraint fk_travel_order_coupon_type_coup_id
	foreign key (coup_id) references coupon_type(coup_id)
);