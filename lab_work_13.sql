-- Практика 13. Форматування таблиць за допомогою printf і дат
-- Варіант 1. Використовується наявна база бібліотеки з Практик 4-12.
-- Структура бази не змінюється: лише SELECT-запити.
-- Файл слід запускати на копії lab_work_12.db.
-- Завдання 1. printf() для числової колонки.
-- У фактовій таблиці loans немає числової колонки з ціною/сумою/кількістю.
-- Для варіанта 1 за умовою використовується books.copies_count.
SELECT id, title, copies_count AS raw_copies,
       printf('%d прим.', copies_count) AS formatted_copies
FROM books
ORDER BY id;

-- Результат виконання:
-- id | title | raw_copies | formatted_copies
-- 1 | Тигролови | 6 | 6 прим.
-- 2 | Кобзар | 4 | 4 прим.
-- 3 | Лісова пісня | 3 | 3 прим.
-- 4 | Місто | 2 | 2 прим.
-- 5 | Захар Беркут | 3 | 3 прим.
-- 6 | Чорна рада | 2 | 2 прим.
-- 7 | Кайдашева сім'я | 2 | 2 прим.

-- Завдання 2. printf() із мінімальною шириною поля.
-- %05d: щонайменше 5 символів, коротші цілі числа доповнюються нулями зліва.
SELECT id, title, copies_count,
       printf('%05d', copies_count) AS aligned_copies
FROM books
ORDER BY id;

-- Результат виконання:
-- id | title | copies_count | aligned_copies
-- 1 | Тигролови | 6 | 00006
-- 2 | Кобзар | 4 | 00004
-- 3 | Лісова пісня | 3 | 00003
-- 4 | Місто | 2 | 00002
-- 5 | Захар Беркут | 3 | 00003
-- 6 | Чорна рада | 2 | 00002
-- 7 | Кайдашева сім'я | 2 | 00002

-- Завдання 3. Обчислення орієнтовної дати повернення.
-- У навчальному прикладі приймаємо стандартний строк позики 14 днів від loan_date.
SELECT id, book_id, loan_date,
       date(loan_date, '+14 days') AS estimated_return_date,
       return_date AS actual_return_date
FROM loans
ORDER BY id;

-- Результат виконання:
-- id | book_id | loan_date | estimated_return_date | actual_return_date
-- 1 | 1 | 2026-10-01 | 2026-10-15 | 2026-11-01
-- 2 | 2 | 2026-10-02 | 2026-10-16 | 2026-10-12
-- 3 | 3 | 2026-10-04 | 2026-10-18 | NULL
-- 4 | 4 | 2026-10-06 | 2026-10-20 | 2026-10-20
-- 5 | 5 | 2026-10-08 | 2026-10-22 | NULL
-- 6 | 6 | 2026-10-10 | 2026-10-24 | 2026-10-18
-- 8 | 3 | 2026-10-17 | 2026-10-31 | NULL

-- Завдання 4. Групування позик за місяцем оформлення.
SELECT strftime('%Y-%m', loan_date) AS loan_month,
       COUNT(*) AS loans_count
FROM loans
GROUP BY loan_month
ORDER BY loan_month;

-- Результат виконання:
-- loan_month | loans_count
-- 2026-10 | 7

-- Завдання 5. Навмисно некоректна дата.
-- SQLite не кидає помилку: date()/strftime() повертають NULL.
SELECT 'not-a-date' AS input_value,
       date('not-a-date') AS date_result,
       strftime('%Y', 'not-a-date') AS year_result;

-- Результат виконання:
-- input_value | date_result | year_result
-- not-a-date | NULL | NULL

