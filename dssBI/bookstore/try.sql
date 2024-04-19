SET SQL_SAFE_UPDATES = 0;
UPDATE bookstore1.Title
SET Title.title_price = Title.title_price * 2.00
WHERE Title.title_type = "monograph";