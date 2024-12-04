CREATE DATABASE FoodOrdering;
USE FoodOrdering;

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

CREATE TABLE restaurant (
    res_id INT AUTO_INCREMENT PRIMARY KEY,
    res_name VARCHAR(255),
    image VARCHAR(255),
    descs VARCHAR(255)
);

CREATE TABLE food_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(255)
);

CREATE TABLE food (
    food_id INT AUTO_INCREMENT PRIMARY KEY,
    food_name VARCHAR(255),
    image VARCHAR(255),
    price FLOAT,
    descs VARCHAR(255),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES food_type(type_id)
);

CREATE TABLE sub_food (
    sub_id INT AUTO_INCREMENT PRIMARY KEY,
    sub_name VARCHAR(255),
    sub_price FLOAT,
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE orders (
    user_id INT,
    food_id INT,
    amount INT,
    code VARCHAR(255),
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE rate_res (
    user_id INT,
    res_id INT,
    amount INT,
    date_rate DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

CREATE TABLE like_res (
    user_id INT,
    res_id INT,
    date_like DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

INSERT INTO user (full_name, email, password)
VALUES 
('Nguyen Van A', 'nguyenvana@example.com', 'password123'),
('Tran Thi B', 'tranthib@example.com', 'password456');

INSERT INTO restaurant (res_name, image, descs)
VALUES
('Restaurant A', 'image_a.jpg', 'Delicious food'),
('Restaurant B', 'image_b.jpg', 'Cozy place');

INSERT INTO food_type (type_name)
VALUES 
('Fast Food'),
('Vegan'),
('Dessert');

INSERT INTO food (food_name, image, price, descs, type_id)
VALUES 
('Burger', 'burger.jpg', 5.99, 'Tasty burger', 1),
('Salad', 'salad.jpg', 4.99, 'Fresh salad', 2),
('Ice Cream', 'icecream.jpg', 3.99, 'Sweet ice cream', 3);

INSERT INTO sub_food (sub_name, sub_price, food_id)
VALUES 
('Extra Cheese', 1.00, 1),
('Extra Dressing', 0.50, 2);

INSERT INTO orders (user_id, food_id, amount, code, arr_sub_id)
VALUES 
(1, 1, 2, 'A123', '1,2'),
(2, 3, 1, 'B456', '');

INSERT INTO rate_res (user_id, res_id, amount, date_rate)
VALUES 
(1, 1, 5, '2024-12-04 12:00:00'),
(2, 2, 4, '2024-12-03 18:00:00');

INSERT INTO like_res (user_id, res_id, date_like)
VALUES 
(1, 1, '2024-12-02 10:00:00'),
(2, 2, '2024-12-01 15:00:00');

SELECT like_res.user_id, COUNT(*) AS total_likes
FROM like_res
GROUP BY like_res.user_id
ORDER BY total_likes DESC
LIMIT 5;

SELECT like_res.res_id, COUNT(*) AS total_likes
FROM like_res
GROUP BY like_res.res_id
ORDER BY total_likes DESC
LIMIT 2;

SELECT orders.user_id, COUNT(*) AS total_orders