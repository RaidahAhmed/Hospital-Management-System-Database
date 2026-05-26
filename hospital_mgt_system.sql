--CREATING TABLES
--Department table
CREATE TABLE Department(
departmentID INT PRIMARY KEY,
department_name VARCHAR(100) NOT NULL UNIQUE,
department_location VARCHAR(100));

--Doctor table
CREATE TABLE Doctor(
doctorID INT PRIMARY KEY,
full_name VARCHAR(50) NOT NULL,
gender VARCHAR(20),
phone VARCHAR(20) UNIQUE,
email VARCHAR(100) UNIQUE,
specialty VARCHAR(100),
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department(departmentID));

--Nurse table
CREATE TABLE Nurse(
nurseID INT PRIMARY KEY,
full_name VARCHAR(50) NOT NULL,
gender VARCHAR(20),
phone VARCHAR(20) UNIQUE,
email VARCHAR(100) UNIQUE,
departmentID INT,
FOREIGN KEY (departmentID) REFERENCES Department(departmentID));

--Patient table
CREATE TABLE Patient(
patientID INT PRIMARY KEY,
full_name VARCHAR(50) NOT NULL,
gender VARCHAR(20),
date_of_birth DATE,
phone VARCHAR(20) UNIQUE,
patient_address VARCHAR(255));

--Nurse assignment
CREATE TABLE Nurse_Assignment(
assignmentID INT PRIMARY KEY,
nurseID INT,
patientID INT NULL,
doctorID INT NULL,
assignment_date DATE,
nurse_role VARCHAR(200),
FOREIGN KEY (nurseID) REFERENCES Nurse(nurseID),
FOREIGN KEY (patientID) REFERENCES Patient(patientID),
FOREIGN KEY (doctorID) REFERENCES Doctor(doctorID),
CONSTRAINT check_assignment_rule
CHECK(
(patientID IS NOT NULL AND doctorID IS NULL)
OR
(patientID IS NULL AND doctorID IS NOT NULL)));

--Appointment table
CREATE TABLE Appointment(
appointmentID INT PRIMARY KEY,
patientID INT,
doctorID INT,
appointment_date DATETIME,
reason VARCHAR(255),
appointment_status VARCHAR(50),
FOREIGN KEY (patientID)  REFERENCES Patient(patientID),
FOREIGN KEY (doctorID) REFERENCES Doctor(doctorID));

--Room table
CREATE TABLE Room(
roomID INT PRIMARY KEY,
room_number VARCHAR(20) UNIQUE NOT NULL,
room_type VARCHAR(50),
charge_per_day INT,
room_status VARCHAR(20) DEFAULT 'Available');

--Admission table
CREATE TABLE Admission(
admissionID INT PRIMARY KEY,
patientID INT,
admission_date DATETIME,
discharge_date DATETIME,
reason VARCHAR(255),
roomID INT,
FOREIGN KEY (patientID)  REFERENCES Patient(patientID),
FOREIGN KEY (roomID)  REFERENCES Room(roomID));

--One dept; many doctors
--One patient; many appointments
--One doctor; many appointments
--One patient; many admissions

--Treament table
CREATE TABLE Treatment(
treatmentID INT PRIMARY KEY,
patientID INT,
doctorID INT,
diagnosis TEXT,
treatment_plan TEXT,
treatment_date DATE,
FOREIGN KEY (patientID) REFERENCES Patient(patientID),
FOREIGN KEY (doctorID) REFERENCES Doctor(doctorID));

--Prescription table
CREATE TABLE Prescription(
prescriptionID INT PRIMARY KEY,
patientID INT,
doctorID INT,
medication_name VARCHAR(150),
dosage VARCHAR(100),
instructions TEXT,
prescription_date DATE,
FOREIGN KEY (patientID) REFERENCES Patient(patientID),
FOREIGN KEY (doctorID) REFERENCES Doctor(doctorID));

--Bill Table
CREATE TABLE Bill(
billID INT PRIMARY KEY,
patientID INT,
admissionID INT,
total_amount DECIMAL(10,2),
payment_status VARCHAR(50) DEFAULT 'Unpaid',
bill_date DATE,
FOREIGN KEY (patientID) REFERENCES Patient(patientID),
FOREIGN KEY (admissionID) REFERENCES Admission(admissionID));

--DATA INSERTION
--Department
INSERT INTO Department (departmentID, department_name, department_location) VALUES
(1,'General Medicine', 'Block A'),
(2,'Pediatrics', 'Block B'),
(3,'Surgery', 'Block C'),
(4,'Orthopedics', 'Block D'),
(5,'Obsterics and Gynecology', 'Block E'),
(6,'Emergency & Critical Care', 'Block F'),
(7,'Diagnostics & Support', 'Block G');

--Doctor
INSERT INTO Doctor (doctorID,full_name,gender,phone,email,specialty,departmentID)
VALUES
(1,'Dr. Raidah Ahmed','Female','0701000001','raidahahmed@hospital.com','Gynecology',5),
(2,'Dr. Rahmah Namugwanya','Female','0701000002','rahmah@hospital.com','Pediatrics',2),
(3,'Dr. Paul Kato','Male','0701000003','paul@hospital.com','Surgery',3),
(4,'Dr. Vannessa Namukwaya','Female','0701000004','kimo@hospital.com','Orthopedics',4),
(5,'Dr. Musa Ssemanda','Male','0701000005','musa@hospital.com','General Medicine',1),
(6,'Dr. Taubah Kibirige','Female','0701000006','kibirige@hospital.com','Emergency',6),
(7,'Dr. Joan Nattabi','Female','0701000007','joan@hospital.com','Diagnostics',7),
(8,'Dr. Musa Bagaga','Male','0701000008','bagaga@hospital.com','General Medicine',1),
(9,'Dr. Amina Namukwaya','Female','0701000009','amina@hospital.com','Pediatrics',2),
(10,'Dr. Hassan Muhammad','Male','0701000010','hassan@hospital.com','Surgery',3);

--Nurse
INSERT INTO Nurse VALUES
(1,'Tessa Huda','Female','0772000001','huda@nurse.com',1),
(2,'Asia Nampijja','Female','0772000002','rahma@nurse.com',2),
(3,'Aliyah Mohammad','Female','0772000003','joanita@nurse.com',3),
(4,'Natasha Mutoni','Female','0772000004','vanessa@nurse.com',4),
(5,'Nawe Abaasa','Female','0772000005','abaasa@nurse.com',5),
(6,'Nakayiza Kauthara','Female','0772000006','kauthara@nurse.com',6),
(7,'Mutesi Shadiah','Male','0772000007','taubah@nurse.com',7),
(8,'Nelson Irankunda','Male','0772000008','musa.nurse@hospital.com',1),
(9,'Ukasha Muhammad','Male','0772000009','ukasha@nurse.com',2),
(10,'Asha Nanyanzi','Female','0772000010','asha@nurse.com',3);

--Patient
INSERT INTO Patient VALUES
(1,'Mary Nabakka','Female','2001-05-12','0781000001','Kampala'),
(2,'Brian Ssemakula','Male','1998-11-03','0781000002','Entebbe'),
(3,'Orishaba Jenipher','Female','2003-02-20','0781000003','Mukono'),
(4,'David Ouma','Male','1995-07-15','0781000004','Jinja'),
(5,'Esther Nalwoga','Female','2000-09-30','0781000005','Wakiso'),
(6,'Samuel Kato','Male','1992-04-10','0781000006','Mbale'),
(7,'Lydia Nansubuga','Female','1999-08-21','0781000007','Masaka'),
(8,'Joseph Byaruhanga','Male','1988-12-11','0781000008','Hoima'),
(9,'Grace Smith','Female','2002-06-14','0781000009','Gulu'),
(10,'Peter Owor','Male','1996-09-05','0781000010','Lira'),
(11,'Fatuma Namatovu','Female','1994-03-18','0781000011','Kampala'),
(12,'Ivan Ssentamu','Male','2001-01-25','0781000012','Mukono'),
(13,'Joyce Ishimwe','Female','1997-07-09','0781000013','Arua'),
(14,'Michael Ocheng','Male','1993-10-30','0781000014','Jinja'),
(15,'Sarah Nabukeera','Female','2000-12-22','0781000015','Wakiso'),
(16,'Ali Muwonge','Male','1998-05-16','0781000016','Kampala'),
(17,'Rebecca Nakanwagi','Female','1999-11-28','0781000017','Entebbe'),
(18,'Daniel Lutaaya','Male','1991-06-07','0781000018','Mbale'),
(19,'Hadijah Namata','Female','2003-09-12','0781000019','Masaka'),
(20,'Brian Kizza','Male','1995-02-02','0781000020','Gulu');

--Appointment
INSERT INTO Appointment VALUES
(1,1,5,'2026-05-01 09:00:00','Fever','Completed'),
(2,2,2,'2026-05-01 10:00:00','Cough','Completed'),
(3,3,3,'2026-05-02 11:00:00','Injury','Pending'),
(4,4,4,'2026-05-02 12:00:00','Back pain','Completed'),
(5,5,1,'2026-05-03 09:30:00','Pregnancy check','Completed'),
(6,6,6,'2026-05-03 10:30:00','Headache','Pending'),
(7,7,7,'2026-05-04 09:00:00','Lab tests','Completed'),
(8,8,8,'2026-05-04 10:00:00','Diabetes','Completed'),
(9,9,9,'2026-05-05 11:00:00','Fever','Completed'),
(10,10,10,'2026-05-05 12:00:00','Surgery review','Pending'),
(11,11,5,'2026-05-06 09:00:00','Endometriosis','Pending'),
(12,12,2,'2026-05-06 10:00:00','Cold','Completed'),
(13,13,3,'2026-05-07 11:00:00','Fracture','Pending'),
(14,14,4,'2026-05-07 12:00:00','Joint pain','Completed'),
(15,15,5,'2026-05-08 09:30:00','Antenatal','Completed'),
(16,16,6,'2026-05-08 10:30:00','Emergency check','Completed'),
(17,17,7,'2026-05-09 09:00:00','Blood test','Completed'),
(18,18,8,'2026-05-09 10:00:00','Chest pain','Pending'),
(19,19,9,'2026-05-10 11:00:00','Malaria','Completed'),
(20,20,10,'2026-05-10 12:00:00','Surgery follow-up','Completed');

INSERT INTO Room (roomID, room_number, room_type, charge_per_day, room_status)
VALUES
(1,'A101','General',50000,'Available'),
(2,'A102','General',50000,'Occupied'),
(3,'B201','Pediatrics',70000,'Available'),
(4,'B202','Pediatrics',70000,'Occupied'),
(5,'C301','Surgery',100000,'Available'),
(6,'C302','Surgery',100000,'Occupied'),
(7,'D401','Orthopedics',90000,'Available'),
(8,'E501','Maternity',80000,'Occupied'),
(9,'F601','ICU',150000,'Available'),
(10,'G701','Emergency',120000,'Occupied');

--Admission
INSERT INTO Admission VALUES
(1,1,'2026-04-01','2026-04-05','Malaria',1),
(2,2,'2026-04-02','2026-04-06','Injury', 2),
(3,3,'2026-04-03','2026-04-07','Fever',3),
(4,4,'2026-04-04','2026-04-08','Surgery recovery',4),
(5,5,'2026-04-05','2026-04-09','Pregnancy',5),
(6,6,'2026-04-06','2026-04-10','Head trauma',6),
(7,7,'2026-04-07','2026-04-11','Fracture',7),
(8,8,'2026-04-08','2026-04-12','Diabetes',8),
(9,9,'2026-04-09','2026-04-13','Chest infection',9),
(10,10,'2026-04-10','2026-04-14','Emergency case',10),
(11,11,'2026-04-11','2026-04-15','Endometriosis',1),
(12,12,'2026-04-12','2026-04-16','Cold',2),
(13,13,'2026-04-13','2026-04-17','Accident',3),
(14,14,'2026-04-14','2026-04-18','Joint injury',4),
(15,15,'2026-04-15','2026-04-19','Pregnancy monitoring',1),
(16,16,'2026-04-16','2026-04-20','Surgery', 6),
(17,17,'2026-04-17','2026-04-21','Observation',7),
(18,18,'2026-04-18','2026-04-22','Heart issue',8),
(19,19,'2026-04-19','2026-04-23','Malaria severe',5),
(20,20,'2026-04-20','2026-04-24','Recovery',10);

--Nurse
INSERT INTO Nurse_Assignment VALUES
(1,1,1,NULL,'2026-05-01','Patient Care'),
(2,2,NULL,1,'2026-05-01','Doctor Assistant'),
(3,3,2,NULL,'2026-05-02','Patient Care'),
(4,4,NULL,2,'2026-05-02','Doctor Assistant'),
(5,5,3,NULL,'2026-05-03','Patient Care'),
(6,6,NULL,3,'2026-05-03','Doctor Assistant'),
(7,7,4,NULL,'2026-05-04','Patient Care'),
(8,8,NULL,4,'2026-05-04','Doctor Assistant'),
(9,9,5,NULL,'2026-05-05','Patient Care'),
(10,10,NULL,5,'2026-05-05','Doctor Assistant'),
(11,1,6,NULL,'2026-05-06','Patient Care'),
(12,2,NULL,6,'2026-05-06','Doctor Assistant'),
(13,3,7,NULL,'2026-05-07','Patient Care'),
(14,4,NULL,7,'2026-05-07','Doctor Assistant'),
(15,5,8,NULL,'2026-05-08','Patient Care'),
(16,6,NULL,8,'2026-05-08','Doctor Assistant'),
(17,7,9,NULL,'2026-05-09','Patient Care'),
(18,8,NULL,9,'2026-05-09','Doctor Assistant'),
(19,9,10,NULL,'2026-05-10','Patient Care'),
(20,10,NULL,10,'2026-05-10','Doctor Assistant');

--Treatment
INSERT INTO Treatment VALUES
(1,1,1,'Malaria','Anti-malarials','2026-05-01'),
(2,2,2,'Flu','Rest + medication','2026-05-01'),
(3,3,3,'Fracture','Cast applied','2026-05-02'),
(4,4,4,'Back pain','Physiotherapy','2026-05-02'),
(5,5,5,'Pregnancy check','Routine care','2026-05-03'),
(6,6,6,'Headache','Pain management','2026-05-03'),
(7,7,7,'Lab diagnosis','Further tests','2026-05-04'),
(8,8,8,'Diabetes','Insulin control','2026-05-04'),
(9,9,9,'Fever','Antibiotics','2026-05-05'),
(10,10,10,'Surgery follow-up','Monitoring','2026-05-05'),
(11,11,1,'Endometriosis','Further tests, Rest + Medication','2026-05-06'),
(12,12,2,'Cold','Rest','2026-05-06'),
(13,13,3,'Accident injury','Surgery prep','2026-05-07'),
(14,14,4,'Joint pain','Therapy','2026-05-07'),
(15,15,5,'Pregnancy','Checkup','2026-05-08'),
(16,16,6,'Emergency','Stabilization','2026-05-08'),
(17,17,7,'Blood test','Review','2026-05-09'),
(18,18,8,'Chest pain','ECG done','2026-05-09'),
(19,19,9,'Malaria','Treatment started','2026-05-10'),
(20,20,10,'Recovery','Follow-up','2026-05-10');

--Prescription
INSERT INTO Prescription VALUES
(1,1,1,'Coartem','2 tablets','After meals','2026-05-01'),
(2,2,2,'Paracetamol','1 tablet','3 times daily','2026-05-01'),
(3,3,3,'Ibuprofen','1 tablet','After food','2026-05-02'),
(4,4,4,'Diclofenac','1 tablet','Twice daily','2026-05-02'),
(5,5,5,'Folic Acid','1 tablet','Daily','2026-05-03'),
(6,6,6,'Panadol','2 tablets','As needed','2026-05-03'),
(7,7,7,'Antibiotics','Course','Complete full dose','2026-05-04'),
(8,8,8,'Insulin','Injection','As prescribed','2026-05-04'),
(9,9,9,'Amoxicillin','1 capsule','3 days','2026-05-05'),
(10,10,10,'Painkillers','1 tablet','Morning','2026-05-05'),
(11,11,1,'Birth control','1 tablets','Night','2026-05-06'),
(12,12,2,'Vitamin C','1 tablet','Daily','2026-05-06'),
(13,13,3,'Antibiotics','Injection','Hospital use','2026-05-07'),
(14,14,4,'Muscle relaxant','1 tablet','Evening','2026-05-07'),
(15,15,5,'Prenatal vitamins','Daily','Morning','2026-05-08'),
(16,16,6,'Emergency meds','IV','Hospital','2026-05-08'),
(17,17,7,'Iron tablets','1 tablet','Daily','2026-05-09'),
(18,18,8,'Heart meds','1 tablet','Daily','2026-05-09'),
(19,19,9,'Artemether','Course','Full dose','2026-05-10'),
(20,20,10,'Recovery meds','1 tablet','Evening','2026-05-10');

--Bill
INSERT INTO Bill VALUES
(1,1,1,500000,'Paid','2026-05-01'),
(2,2,2,300000,'Paid','2026-05-01'),
(3,3,3,450000,'Unpaid','2026-05-02'),
(4,4,4,600000,'Paid','2026-05-02'),
(5,5,5,700000,'Paid','2026-05-03'),
(6,6,6,550000,'Unpaid','2026-05-03'),
(7,7,7,400000,'Paid','2026-05-04'),
(8,8,8,800000,'Paid','2026-05-04'),
(9,9,9,350000,'Paid','2026-05-05'),
(10,10,10,900000,'Unpaid','2026-05-05'),
(11,11,11,250000,'Paid','2026-05-06'),
(12,12,12,300000,'Paid','2026-05-06'),
(13,13,13,650000,'Unpaid','2026-05-07'),
(14,14,14,500000,'Paid','2026-05-07'),
(15,15,15,750000,'Paid','2026-05-08'),
(16,16,16,1000000,'Unpaid','2026-05-08'),
(17,17,17,400000,'Paid','2026-05-09'),
(18,18,18,850000,'Unpaid','2026-05-09'),
(19,19,19,300000,'Paid','2026-05-10'),
(20,20,20,950000,'Paid','2026-05-10');

--SQL Queries
--Display all records from the tables
SELECT * FROM Department;
SELECT * FROM Doctor;
SELECT * FROM Patient;
SELECT * FROM Nurse;
SELECT * FROM Nurse_Assignment; 
SELECT * FROM Appointment;
SELECT * FROM Room;
SELECT * FROM Admission;
SELECT * FROM Treatment;
SELECT * FROM Prescription;
SELECT * FROM Bill

--Retrieve records using WHERE
SELECT * FROM Patient
WHERE patient_address = 'Kampala';

SELECT * FROM Doctor
WHERE gender = 'Male';

--Using ORDERBY
SELECT * FROM Patient
ORDER BY full_name ASC; --getting patient records by the order of names from a-z

SELECT * FROM Appointment
ORDER BY appointment_date DESC; --getting appointment dates from the latest date to the oldest

--Using aggregate functions
SELECT COUNT(*) AS total_patients
FROM Patient; --returns a new column with the number of total patients

SELECT SUM(total_amount) AS total_revenue
FROM Bill;   --returns a new column with the total_amount summed up as now total_revenue

SELECT AVG(total_amount) AS average_bill
FROM Bill;  --averages the total_amount column values and returns the average

--INNER JOIN
--joining patients with their doctors and their appointments
SELECT 
    Patient.full_name AS patient_name,
    Doctor.full_name AS doctor_name,
    Appointment.appointment_date,
    Appointment.reason
FROM Appointment
INNER JOIN Patient ON Appointment.patientID = Patient.patientID
INNER JOIN Doctor ON Appointment.doctorID = Doctor.doctorID;

--joining doctors with their departments
SELECT 
    Doctor.full_name,
    Doctor.specialty,
    Department.department_name
FROM Doctor
INNER JOIN Department ON Doctor.departmentID = Department.departmentID;

--Updating records using UPDATE
--updating patient with id 1 address to Kasangati
UPDATE Patient
SET patient_address = 'Kasangati'
WHERE patientID = 1;

--updating room status
UPDATE Room
SET room_status = 'Available'
WHERE roomID = 2;

--Advanced database feature; using VIEW
/*To help simplify retrieving an appointment information by combining data from Patient table,
Doctor Table and Appointment table into a virtual table.*/
GO
CREATE VIEW Patient_Appointment_View AS
SELECT
    Patient.full_name AS patient_name,
    Doctor.full_name AS doctor_name,
    Appointment.appointment_date,
    Appointment.reason,
    Appointment.appointment_status
FROM Appointment
INNER JOIN Patient
ON Appointment.patientID = Patient.patientID
INNER JOIN Doctor
ON Appointment.doctorID = Doctor.doctorID;
GO
--using the view
SELECT * FROM Patient_Appointment_View;


--ANOTHER for patients who haven't paid and their bills
GO
CREATE VIEW Unpaid_Bills_View AS
SELECT
    Patient.full_name,
    Bill.total_amount,
    Bill.bill_date
FROM Bill
INNER JOIN Patient
ON Bill.patientID = Patient.patientID
WHERE Bill.payment_status = 'Unpaid';
GO
--USING view
SELECT * FROM Unpaid_Bills_View;