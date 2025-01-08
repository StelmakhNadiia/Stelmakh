CREATE TABLE Patients (
    Patient_id INT PRIMARY KEY IDENTITY(1,1),
    First_name VARCHAR(100) NOT NULL,
    Last_name VARCHAR(100) NOT NULL,
    Date_of_birth DATE NOT NULL,
    Gender CHAR(1),
    Phone_number VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255),
    Insurance_id INT,
    Emergency_contact_name VARCHAR(100),
    Emergency_contact_phone VARCHAR(20)
);

CREATE TABLE InsuranceCompanies (
    Insurance_id INT PRIMARY KEY IDENTITY(1,1),
    Insurance_company_name VARCHAR(100) NOT NULL,
    Plan_name VARCHAR(100),
    Coverage_amount DECIMAL(10, 2)
);

CREATE TABLE Doctors (
    Doctor_id INT PRIMARY KEY IDENTITY(1,1),
    First_name VARCHAR(100) NOT NULL,
    Last_name VARCHAR(100) NOT NULL,
    Specialty_id INT NOT NULL,
    Phone_number VARCHAR(20),
    Email VARCHAR(100),
    Office_id INT
);

CREATE TABLE Offices (
    Office_id INT PRIMARY KEY IDENTITY(1,1),
    Office_number VARCHAR(50) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Specialties (
    Specialty_id INT PRIMARY KEY IDENTITY(1,1),
    Specialty_name VARCHAR(100) NOT NULL
);

CREATE TABLE Appointments (
    Appointment_id INT PRIMARY KEY IDENTITY(1,1),
    Patient_id INT NOT NULL,
    Doctor_id INT NOT NULL,
    Appointment_date DATE NOT NULL,
    Appointment_time TIME NOT NULL,
    Reason_for_visit VARCHAR(255),
    Status VARCHAR(50)
);

CREATE TABLE Medications (
    Medication_id INT PRIMARY KEY IDENTITY(1,1),
    Medication_name VARCHAR(100) NOT NULL,
    Description TEXT
);

CREATE TABLE Prescriptions (
    Prescription_id INT PRIMARY KEY IDENTITY(1,1),
    Appointment_id INT NOT NULL,
    Medication_id INT NOT NULL,
    Dosage VARCHAR(50),
    Instructions TEXT
);

CREATE TABLE Procedures (
    Procedure_id INT PRIMARY KEY IDENTITY(1,1),
    Procedure_name VARCHAR(100) NOT NULL,
    Description TEXT,
    Cost DECIMAL(10, 2)
);

CREATE TABLE Diagnoses (
    Diagnosis_id INT PRIMARY KEY IDENTITY(1,1),
    Appointment_id INT NOT NULL,
    Diagnosis_name VARCHAR(100),
    Description TEXT
);

CREATE TABLE Payments (
    Payment_id INT PRIMARY KEY IDENTITY(1,1),
    Patient_id INT NOT NULL,
    Appointment_id INT,
    Amount DECIMAL(10, 2) NOT NULL,
    Payment_date DATE,
    Payment_method VARCHAR(50)
);

CREATE TABLE DoctorSchedules (
    Schedule_id INT PRIMARY KEY IDENTITY(1,1),
    Doctor_id INT NOT NULL,
    Available_date DATE NOT NULL,
    Available_time_from TIME NOT NULL,
    Available_time_to TIME NOT NULL
);

CREATE TABLE MedicalRecords (
    Record_id INT PRIMARY KEY IDENTITY(1,1),
    Patient_id INT NOT NULL,
    Appointment_id INT,
    Diagnosis_id INT,
    Record_details TEXT,
    Record_date DATE NOT NULL
);

CREATE TABLE LabResults (
    Lab_result_id INT PRIMARY KEY IDENTITY(1,1),
    Patient_id INT NOT NULL,
    Appointment_id INT,
    Test_name VARCHAR(100) NOT NULL,
    Result_value VARCHAR(100),
    Result_date DATE NOT NULL
);

CREATE TABLE MedicalEquipment (
    Equipment_id INT PRIMARY KEY IDENTITY(1,1),
    Equipment_name VARCHAR(100) NOT NULL,
    Equipment_type VARCHAR(100),
    Status VARCHAR(50) NOT NULL
);
