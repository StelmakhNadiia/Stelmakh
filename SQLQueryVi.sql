--�������� ��� ��� ������������ � �� �����
CREATE VIEW vw_PatientsWithDoctors AS
SELECT p.First_name AS PatientFirstName, p.Last_name AS PatientLastName,
       d.First_name AS DoctorFirstName, d.Last_name AS DoctorLastName
FROM Patients p
JOIN Appointments a ON p.Patient_id = a.Patient_id
JOIN Doctors d ON a.Doctor_id = d.Doctor_id;
GO


--�������� ��� ��� ����� ����� � �� ���������������
CREATE VIEW vw_DoctorsWithSpecialties AS
SELECT d.First_name AS DoctorFirstName, d.Last_name AS DoctorLastName, s.Specialty_name
FROM Doctors d
JOIN Specialties s ON d.Specialty_id = s.Specialty_id;
GO


--�������� �����, �� �������� � ����������� ����
CREATE VIEW vw_DoctorsByOffice AS
SELECT d.First_name AS DoctorFirstName, d.Last_name AS DoctorLastName, o.Office_number
FROM Doctors d
JOIN Offices o ON d.Office_id = o.Office_id;
GO


--�������� �����, �� �������������� �� ����� �����, �� �� �����������
CREATE VIEW vw_DoctorsWithAppointments AS
SELECT d.First_name AS DoctorFirstName, d.Last_name AS DoctorLastName, 
       a.Appointment_date, a.Appointment_time, p.First_name AS PatientFirstName
FROM Doctors d
LEFT JOIN Appointments a ON d.Doctor_id = a.Doctor_id
LEFT JOIN Patients p ON a.Patient_id = p.Patient_id;
GO

--�������� ��� ����� � �������, �� ��� ��������
CREATE VIEW vw_OfficesWithDoctors AS
SELECT o.Office_number, o.Location, d.First_name AS DoctorFirstName, d.Last_name AS DoctorLastName
FROM Offices o
JOIN Doctors d ON o.Office_id = d.Office_id;
GO

--�������� �������� � ������������� �� ������ ��� ����������� ��������
CREATE VIEW vw_AppointmentsTomorrowForPatient AS
SELECT a.Appointment_date, a.Appointment_time, d.First_name AS DoctorFirstName, d.Last_name AS DoctorLastName
FROM Appointments a
JOIN Patients p ON a.Patient_id = p.Patient_id
JOIN Doctors d ON a.Doctor_id = d.Doctor_id
WHERE p.Patient_id = 1 AND MONTH(a.Appointment_date) = 10;  -- ������ ID �������� �� �������
GO


--�������� ��� ���������� ��������
CREATE VIEW vw_AllAppointmentsForPatient AS
SELECT p.First_name AS PatientFirstName, p.Last_name AS PatientLastName, 
       a.Appointment_date, a.Appointment_time, d.First_name AS DoctorFirstName, d.Last_name AS DoctorLastName
FROM Patients p
JOIN Appointments a ON p.Patient_id = a.Patient_id
JOIN Doctors d ON a.Doctor_id = d.Doctor_id
WHERE p.Patient_id = 1;  -- ������ ID �������� �� �������
GO
