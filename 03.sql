-- Create the student table
CREATE TABLE student (
    studentid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100),
    birthdate DATE,
    enrolldate DATE
);

-- Insert 5 entries into the student table
INSERT INTO student (studentid, firstname, lastname, email, birthdate, enrolldate) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', '2003-04-15', '2022-09-01'),
(2, 'Bob', 'Smith', 'bob.smith@example.com', '2002-11-23', '2021-09-01'),
(3, 'Charlie', 'Davis', 'charlie.davis@example.com', '2004-01-08', '2023-09-01'),
(4, 'Diana', 'Lopez', 'diana.lopez@example.com', '2003-07-30', '2022-09-01'),
(5, 'Ethan', 'Wright', 'ethan.wright@example.com', '2001-05-17', '2020-09-01');

-- Create the course table
CREATE TABLE course (
    courseid INT PRIMARY KEY,
    coursename VARCHAR(100),
    departmentid INT,
    credits INT
);

-- Insert 5 entries into the course table
INSERT INTO course (courseid, coursename, departmentid, credits) VALUES
(101, 'Introduction to Computer Science', 1, 4),
(102, 'Calculus I', 2, 3),
(103, 'General Chemistry', 3, 4),
(104, 'World History', 4, 3),
(105, 'English Literature', 5, 3);

-- Create the instructor table
CREATE TABLE instructor (
    instructorid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100),
    departmentid INT
);

-- Insert 5 entries into the instructor table
INSERT INTO instructor (instructorid, firstname, lastname, email, departmentid) VALUES
(1, 'Sarah', 'Miller', 'sarah.miller@example.com', 1),
(2, 'James', 'Anderson', 'james.anderson@example.com', 2),
(3, 'Laura', 'Garcia', 'laura.garcia@example.com', 3),
(4, 'Michael', 'Brown', 'michael.brown@example.com', 4),
(5, 'Emily', 'Wilson', 'emily.wilson@example.com', 5);


-- Create the enrollments table with foreign key constraints
CREATE TABLE enrollments (
    enrollmentid INT PRIMARY KEY,
    studentid INT,
    courseid INT,
    enrollmentdate DATE,
    FOREIGN KEY (studentid) REFERENCES student(studentid),
    FOREIGN KEY (courseid) REFERENCES course(courseid)
);

-- Insert 5 entries into the enrollments table
INSERT INTO enrollments (enrollmentid, studentid, courseid, enrollmentdate) VALUES
(1, 1, 101, '2022-09-02'),
(2, 2, 102, '2021-09-05'),
(3, 3, 103, '2023-09-03'),
(4, 4, 104, '2022-09-06'),
(5, 5, 105, '2020-09-07');


CREATE TABLE department (
    departmentid INT PRIMARY KEY,
    departmentname VARCHAR(100)
);

-- Insert sample departments
INSERT INTO department (departmentid, departmentname) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Chemistry'),
(4, 'History'),
(5, 'English');



-- Perform CRUD Operations on all tables.
--(1)
SELECT *from course;
SELECT *from department;
SELECT *from enrollments;
SELECT *from instructor;
SELECT *from student;

--(2)
update student SET firstname='ram' WHERE studentid=3;
update course SET coursename='gujarati' WHERE courseid=3;
update department SET departmentname='social' WHERE departmentid=3;
UPDATE enrollments set enrollmentdate='2022-09-04' WHERE studentid=1;
UPDATE instructor set firstname='karan' WHERE instructorid=1;

--(3)
DELETE from enrollments WHERE studentid=3;
DELETE from student WHERE studentid=3;
DELETE from department WHERE departmentid=3;
DELETE from instructor WHERE instructorid=3;
DELETE from course WHERE courseid=3;


-- Retrieve students who enrolled after 2022.
SELECT firstname from student WHERE enrolldate > '2022-01-01'


-- Retrieve courses offered by the Mathematics department with a limit of 5 courses.
SELECT d.departmentname,c.coursename
from department d 
INNER JOIN course c on d.departmentid=c.departmentid;


-- Get the number of students enrolled in each course, filtering for courses with more than 5 students.
SELECT studentid,count(*) as student_count
from enrollments GROUP BY studentid;


-- Find students enrolled in both Introduction to SQL and Data Structures.
SELECT enrollmentid, studentid
from enrollments
WHERE studentid IN(SELECT studentid from enrollments WHERE courseid in(101,103));


-- Find students enrolled in either Introduction to SQL or Data Structures.
SELECT enrollmentid, studentid
from enrollments
WHERE studentid = (SELECT studentid from enrollments WHERE courseid in(101,103));


-- Calculate the average number of credits for all courses.
SELECT avg(credits) from course;


-- Find the maximum salary of instructors in the Computer Science department.
SELECT max(credits) from course;


-- Count the number of students enrolled in each department.
SELECT studentid,count(*) as student_count
from enrollments GROUP BY studentid;


-- INNER JOIN: Retrieve students and their corresponding courses.
SELECT d.departmentname,c.coursename
from department d 
INNER JOIN course c on d.departmentid=c.departmentid;


-- LEFT JOIN: Retrieve all students and their corresponding courses, if any.
SELECT d.departmentname,c.coursename
from department d 
LEFT JOIN course c on d.departmentid=c.departmentid;


-- Subquery: Find students enrolled in courses that have more than 10 students.

select * from student

Select s.studentid, s.firstname
from student s 
    INNER join enrollments e
ON e.studentid = s.studentid
WHERE e.courseid = 
(select courseid from enrollments
GROUP BY courseid
HAVING count(studentid) >= 10);


-- Extract the year from the EnrollmentDate of students.
(SELECT firstname ,
YEAR(enrolldate) as years
from student);


-- Concatenate the instructor’s first and last name.
SELECT firstname,lastname,
CONCAT(firstname,' ',lastname) as full_name from instructor;


-- Calculate the running total of students enrolled in courses.
SELECT COUNT(studentid) from student;



-- Label students as 'Senior' or 'Junior' based on their year of enrollment. (If enrolled more than 4 years ago, label as Senior, otherwise Junior.)

SELECT firstname,
case 
when DATEDIFF(CURDATE(),enrolldate) > 4 THEN 'senior'
when DATEDIFF(CURDATE(),enrolldate) < 4 THEN 'junior'
else 0
end as sen_jun
from student;
