-- Создание таблицы товаров
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL
);

-- Создание таблицы цен на товары
CREATE TABLE prices (
    price_id INT PRIMARY KEY,
    product_id INT,
    price_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Вставка данных в таблицу товаров
INSERT INTO products (product_id, product_name) VALUES
(1, 'Product A'),
(2, 'Product B'),
(3, 'Product C');

-- Вставка данных в таблицу цен
INSERT INTO prices (price_id, product_id, price_date, price) VALUES
(1, 1, '2023-05-01', 100.00),
(2, 1, '2023-05-02', 102.00),
(3, 1, '2023-05-03', 101.00),
(4, 1, '2023-05-04', 104.00),
(5, 1, '2023-05-05', 105.00),
(6, 2, '2023-05-01', 200.00),
(7, 2, '2023-05-02', 205.00),
(8, 2, '2023-05-03', 204.00),
(9, 2, '2023-05-04', 207.00),
(10, 2, '2023-05-05', 210.00),
(11, 3, '2023-05-01', 300.00),
(12, 3, '2023-05-02', 290.00),
(13, 3, '2023-05-03', 292.00),
(14, 3, '2023-05-04', 293.00),
(15, 3, '2023-05-05', 294.00);

-- Запрос для определения количества дней с устоявшейся ценой для каждого товара
WITH price_changes AS (
    SELECT 
        p.product_id, 
        p.product_name, 
        pr.price_date, 
        pr.price,
        COALESCE(
            ABS(pr.price - LAG(pr.price, 1) OVER (PARTITION BY p.product_id ORDER BY pr.price_date)) / 
            LAG(pr.price, 1) OVER (PARTITION BY p.product_id ORDER BY pr.price_date), 
            0
        ) * 100 AS price_change_percentage
    FROM products p
    JOIN prices pr ON p.product_id = pr.product_id
),
stable_days AS (
    SELECT 
        product_id, 
        product_name, 
        COUNT(*) AS stable_days_count
    FROM price_changes
    WHERE price_change_percentage <= 3
    GROUP BY product_id, product_name
)
SELECT 
    p.product_name,
    COALESCE(sd.stable_days_count, -1) AS days_num
FROM products p
LEFT JOIN stable_days sd ON p.product_id = sd.product_id;
