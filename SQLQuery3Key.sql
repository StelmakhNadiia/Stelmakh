-- Додавання вторинного ключа для пацієнтів та страхових компаній
ALTER TABLE Patients
ADD CONSTRAINT FK_Patients_Insurance FOREIGN KEY (Insurance_id) REFERENCES InsuranceCompanies(Insurance_id);

-- Додавання вторинного ключа для лікарів та спеціальностей
ALTER TABLE Doctors
ADD CONSTRAINT FK_Doctors_Specialties FOREIGN KEY (Specialty_id) REFERENCES Specialties(Specialty_id);

-- Додавання вторинного ключа для лікарів та офісів
ALTER TABLE Doctors
ADD CONSTRAINT FK_Doctors_Offices FOREIGN KEY (Office_id) REFERENCES Offices(Office_id);

-- Додавання вторинного ключа для прийомів пацієнтів
ALTER TABLE Appointments
ADD CONSTRAINT FK_Appointments_Patients FOREIGN KEY (Patient_id) REFERENCES Patients(Patient_id);

-- Додавання вторинного ключа для прийомів лікарів
ALTER TABLE Appointments
ADD CONSTRAINT FK_Appointments_Doctors FOREIGN KEY (Doctor_id) REFERENCES Doctors(Doctor_id);

-- Додавання вторинного ключа для рецептів та прийомів
ALTER TABLE Prescriptions
ADD CONSTRAINT FK_Prescriptions_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- Додавання вторинного ключа для рецептів та ліків
ALTER TABLE Prescriptions
ADD CONSTRAINT FK_Prescriptions_Medications FOREIGN KEY (Medication_id) REFERENCES Medications(Medication_id);

-- Додавання вторинного ключа для діагнозів та прийомів
ALTER TABLE Diagnoses
ADD CONSTRAINT FK_Diagnoses_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- Додавання вторинного ключа для платежів та пацієнтів
ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Patients FOREIGN KEY (Patient_id) REFERENCES Patients(Patient_id);

-- Додавання вторинного ключа для платежів та прийомів
ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- Додавання вторинного ключа для розкладу лікарів
ALTER TABLE DoctorSchedules
ADD CONSTRAINT FK_DoctorSchedules_Doctors FOREIGN KEY (Doctor_id) REFERENCES Doctors(Doctor_id);

-- Додавання вторинного ключа для медичних записів пацієнтів
ALTER TABLE MedicalRecords
ADD CONSTRAINT FK_MedicalRecords_Patients FOREIGN KEY (Patient_id) REFERENCES Patients(Patient_id);

-- Додавання вторинного ключа для медичних записів прийомів
ALTER TABLE MedicalRecords
ADD CONSTRAINT FK_MedicalRecords_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- Додавання вторинного ключа для медичних записів діагнозів
ALTER TABLE MedicalRecords
ADD CONSTRAINT FK_MedicalRecords_Diagnoses FOREIGN KEY (Diagnosis_id) REFERENCES Diagnoses(Diagnosis_id);

-- Додавання вторинного ключа для лабораторних результатів пацієнтів
ALTER TABLE LabResults
ADD CONSTRAINT FK_LabResults_Patients FOREIGN KEY (Patient_id) REFERENCES Patients(Patient_id);

-- Додавання вторинного ключа для лабораторних результатів прийомів
ALTER TABLE LabResults
ADD CONSTRAINT FK_LabResults_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- Додавання вторинного ключа для медичного обладнання та процедур
ALTER TABLE MedicalEquipment
ADD CONSTRAINT FK_MedicalEquipment_Procedures FOREIGN KEY (Procedure_id) REFERENCES Procedures(Procedure_id);
