--    創建表單 -------------------------------------------------------
DROP TABLE IF EXISTS  products;
DROP TABLE IF EXISTS  order_detail;
DROP TABLE IF EXISTS  order_list;

CREATE TABLE products (
    prod_id INT PRIMARY KEY auto_increment,
    prod_name VARCHAR(50) NOT null,
    prod_category VARCHAR(50),
    prod_stock INT NOT null,
    prod_price INT NOT null,
    prod_img_1 varchar(100),
 	prod_img_2 varchar(100),
 	prod_img_3 varchar(100)
);


CREATE TABLE order_list(
	order_id int PRIMARY KEY auto_increment,
    memb_id int,
	order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
	order_status varchar(50) NOT null,
	order_payment varchar(50) NOT null,
	cust_name varchar(50) NOT null,
	cust_email varchar(100),
	cust_tell varchar(10) NOT null,
	del_addr  varchar(50) NOT null,
	order_amount int NOT null,
    CONSTRAINT fk_order_list_member_data_memb_id
    FOREIGN KEY (memb_id) REFERENCES member_data(memb_id)
);

CREATE TABLE order_detail(
	order_id int,
	prod_id  int NOT null,
	prod_qty int NOT null,
	prod_price int NOT null,
	CONSTRAINT fk_order_detail_order_list_order_id
    FOREIGN KEY (order_id) REFERENCES order_list(order_id),
    CONSTRAINT fk_order_detail_products_prod_id
    FOREIGN KEY (prod_id) REFERENCES products(prod_id)
);

--    預存指令 -------------------------------------------------------

-- 獲取所有商品跟圖片
DELIMITER //

CREATE PROCEDURE GetAllProductsWithImages()
BEGIN
    SELECT *FROM products;
END //

DELIMITER ;

 

-- 獲取指定商品跟圖片
DELIMITER //

CREATE PROCEDURE GetProductWithImagesById(IN input_prod_id INT)
BEGIN
    SELECT * FROM products
    WHERE prod_id = input_prod_id;
END //

DELIMITER ;


-- 新增商品跟圖片
DELIMITER //

CREATE PROCEDURE InsertProductAndImage(
    IN p_prod_name VARCHAR(255),
    IN p_prod_category VARCHAR(255),
    IN p_prod_qty INT,
    IN p_prod_price INT,
    IN p_prod_img_1 VARCHAR(255),
    IN p_prod_img_2 VARCHAR(255),
    IN p_prod_img_3 VARCHAR(255)
)
BEGIN
    DECLARE new_prod_id INT;

    -- 插入数据到 Products 表
    INSERT INTO products (prod_name, prod_category, prod_qty, prod_price,prod_id, prod_img_1, prod_img_2, prod_img_3)
    VALUES (p_prod_name, p_prod_category, p_prod_qty, p_prod_price,p_prod_img_1, p_prod_img_2, p_prod_img_3);
END //

DELIMITER ;

-- 修改
DELIMITER //

CREATE  PROCEDURE UpdateProductQty(
	IN p_prod_id int,
	IN p_prod_qty int
)
BEGIN

	UPDATE products 
	SET prod_qty = p_prod_qty
	WHERE prod_id  = p_prod_id;
END //

DELIMITER ;

DELIMITER //

CREATE  PROCEDURE UpdateProductPrice(
	IN p_prod_id int,
	IN p_prod_price int
)
BEGIN

	UPDATE products
	SET prod_price = p_prod_price 
	WHERE prod_id  = p_prod_id;
END //

DELIMITER ;

DELIMITER //

CREATE  PROCEDURE UpdateProductCategory(
	IN p_prod_id int,
	IN p_prod_category VARCHAR(255)
)
BEGIN

	UPDATE products
	SET prod_category = p_prod_category
	WHERE prod_id  = p_prod_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateProductImg(
    IN p_prod_id INT,
    IN p_img1 VARCHAR(255),
    IN p_img2 VARCHAR(255),
    IN p_img3 VARCHAR(255)
)
BEGIN
    -- 检查是否提供了新的图片1，如果有，则更新图片1
    IF p_img1 IS NOT NULL THEN
        UPDATE products
        SET prod_img_1 = p_img1
        WHERE prod_id = p_prod_id;
    END IF;
    
    -- 检查是否提供了新的图片2，如果有，则更新图片2
    IF p_img2 IS NOT NULL THEN
        UPDATE products
        SET prod_img_2 = p_img2
        WHERE prod_id = p_prod_id;
    END IF;
    
    -- 检查是否提供了新的图片3，如果有，则更新图片3
    IF p_img3 IS NOT NULL THEN
        UPDATE products
        SET prod_img_3 = p_img3
        WHERE prod_id = p_prod_id;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateProductName(
    IN p_prod_id INT,
    IN p_prod_name VARCHAR(255)
)
BEGIN
   UPDATE products
   SET 	  prod_name = p_prod_name
   WHERE  prod_id = p_prod_id;
END //

DELIMITER ;

-- --------------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE GetOrderList()
BEGIN
    SELECT * FROM order_list;
END //

DELIMITER ;

CALL GetOrderList();

DELIMITER //

CREATE PROCEDURE GetOrderDetail(
	IN o_order_id int
)

BEGIN
    SELECT * FROM order_detail od
   	WHERE od.order_id = o_order_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE InsertOrder(
	IN o_order_status VARCHAR(255),
	IN o_order_payment VARCHAR(255),
	IN o_order_cust_name VARCHAR(255),
	IN o_order_cust_email VARCHAR(255),
	IN o_order_cust_tell VARCHAR(255),
	IN o_order_del_addr VARCHAR(255),
	IN o_order_amount int,
	OUT get_order_id int
)

BEGIN
   INSERT INTO order_list(order_status,order_payment,cust_name,cust_email,cust_tell,del_addr,order_amount) VALUES
   (o_order_status,o_order_payment,o_order_cust_name,o_order_cust_email,o_order_cust_tell,o_order_del_addr,o_order_amount);
  	SET get_order_id = LAST_INSERT_ID(); 
END //

DELIMITER ;

  
DELIMITER //

CREATE PROCEDURE InsertOrderDetail(
	IN o_order_id int,
	IN o_order_prod_id int,
	IN o_order_prod_name VARCHAR(255),
	IN o_order_prod_category VARCHAR(255),
	IN o_order_prod_qty int,
	IN o_order_prod_price int
)
BEGIN
   INSERT INTO order_detail(order_id,prod_id,prod_name,prod_category,prod_qty,prod_price) VALUES
   (o_order_id,o_order_prod_id,o_order_prod_name,o_order_prod_category,o_order_prod_qty,o_order_prod_price);
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE UpdateOrderStatus(
	IN o_order_id int,
	IN o_oredr_satus varchar(200)
)

BEGIN
   UPDATE order_list 
   SET order_status = o_oredr_satus
   WHERE order_id = o_order_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateOrderCustomerName(
	IN o_order_id int,
	IN o_order_cust_name varchar(200)
)

BEGIN
   UPDATE order_list 
   SET cust_name = o_order_cust_name
   WHERE order_id = o_order_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateOrderCustomerTell(
	IN o_order_id int,
	IN o_order_cust_tell VARCHAR(255)
)

BEGIN
   UPDATE order_list 
   SET cust_tell = o_order_cust_tell
   WHERE order_id = o_order_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateOrderShippingAddress(
	IN o_order_id int,
	IN o_order_ship_addr VARCHAR(255)
)

BEGIN
   UPDATE order_list 
   SET ship_addr = o_order_ship_addr
   WHERE order_id = o_order_id;
END //

DELIMITER ;



