-- Active: 1729083379425@@127.0.0.1@5432@university_db

-- Create "students" table

CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    frontend_mark INT NOT NULL,
    backend_mark INT NOT NULL,
    status VARCHAR(50)
);

-- Create "courses" table

CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL
);

-- Create "enrollment" table

CREATE TABLE enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id) NOT NULL,
    course_id INTEGER REFERENCES courses(course_id) NOT NULL
);

-- Query 1
-- Insert new student record

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark)
VALUES
('Sameer', 21, 'sameer@example.com', 48, 60),
('Zoya', 23, 'zoya@example.com', 52, 58),
('Nabil', 22, 'nabil@example.com', 37, 46),
('Rafi', 24, 'rafi@example.com', 41, 40),
('Sophia', 22, 'sophia@example.com', 50, 52),
('Hasan', 23, 'hasan@gmail.com', 43, 39);

-- Query 2
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.

SELECT student_name FROM students s
 JOIN enrollment e ON s.student_id = e.student_id
 JOIN courses c ON e.course_id = c.course_id
 WHERE course_name = 'Next.js'

-- Query 3
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.

UPDATE students 
 SET status = 'Awarded'
 WHERE frontend_mark + backend_mark = (
     SELECT max(frontend_mark + backend_mark) FROM students
     )

-- Query 4
-- Delete all courses that have no students enrolled.

DELETE FROM courses
 WHERE course_id IN (
    SELECT c.course_id FROM courses c 
     LEFT JOIN enrollment e ON c.course_id = e.course_id
     WHERE e.course_id IS NULL
 );

-- Query 5
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.

SELECT student_name FROM students 
 ORDER BY student_id 
 LIMIT 2 OFFSET 2

-- Query 6
-- Retrieve the course names and the number of students enrolled in each course.

SELECT c.course_name, count(e.student_id) as students_enrolled FROM courses c
 JOIN enrollment e ON e.course_id = c.course_id
 GROUP BY c.course_name;

-- Query 7
-- Calculate and display the average age of all students.

SELECT ROUND(avg(age), 2) as average_age FROM students

-- Query 8
-- Retrieve the names of students whose email addresses contain 'example.com'.

SELECT student_name FROM students
 WHERE email LIKE '%example.com'

