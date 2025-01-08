-- ��������� ���������� ����� ��� �������� �� ��������� �������
ALTER TABLE Patients
ADD CONSTRAINT FK_Patients_Insurance FOREIGN KEY (Insurance_id) REFERENCES InsuranceCompanies(Insurance_id);

-- ��������� ���������� ����� ��� ����� �� ��������������
ALTER TABLE Doctors
ADD CONSTRAINT FK_Doctors_Specialties FOREIGN KEY (Specialty_id) REFERENCES Specialties(Specialty_id);

-- ��������� ���������� ����� ��� ����� �� �����
ALTER TABLE Doctors
ADD CONSTRAINT FK_Doctors_Offices FOREIGN KEY (Office_id) REFERENCES Offices(Office_id);

-- ��������� ���������� ����� ��� ������� ��������
ALTER TABLE Appointments
ADD CONSTRAINT FK_Appointments_Patients FOREIGN KEY (Patient_id) REFERENCES Patients(Patient_id);

-- ��������� ���������� ����� ��� ������� �����
ALTER TABLE Appointments
ADD CONSTRAINT FK_Appointments_Doctors FOREIGN KEY (Doctor_id) REFERENCES Doctors(Doctor_id);

-- ��������� ���������� ����� ��� ������� �� �������
ALTER TABLE Prescriptions
ADD CONSTRAINT FK_Prescriptions_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- ��������� ���������� ����� ��� ������� �� ���
ALTER TABLE Prescriptions
ADD CONSTRAINT FK_Prescriptions_Medications FOREIGN KEY (Medication_id) REFERENCES Medications(Medication_id);

-- ��������� ���������� ����� ��� ������� �� �������
ALTER TABLE Diagnoses
ADD CONSTRAINT FK_Diagnoses_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- ��������� ���������� ����� ��� ������� �� ��������
ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Patients FOREIGN KEY (Patient_id) REFERENCES Patients(Patient_id);

-- ��������� ���������� ����� ��� ������� �� �������
ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- ��������� ���������� ����� ��� �������� �����
ALTER TABLE DoctorSchedules
ADD CONSTRAINT FK_DoctorSchedules_Doctors FOREIGN KEY (Doctor_id) REFERENCES Doctors(Doctor_id);

-- ��������� ���������� ����� ��� �������� ������ ��������
ALTER TABLE MedicalRecords
ADD CONSTRAINT FK_MedicalRecords_Patients FOREIGN KEY (Patient_id) REFERENCES Patients(Patient_id);

-- ��������� ���������� ����� ��� �������� ������ �������
ALTER TABLE MedicalRecords
ADD CONSTRAINT FK_MedicalRecords_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- ��������� ���������� ����� ��� �������� ������ �������
ALTER TABLE MedicalRecords
ADD CONSTRAINT FK_MedicalRecords_Diagnoses FOREIGN KEY (Diagnosis_id) REFERENCES Diagnoses(Diagnosis_id);

-- ��������� ���������� ����� ��� ������������ ���������� ��������
ALTER TABLE LabResults
ADD CONSTRAINT FK_LabResults_Patients FOREIGN KEY (Patient_id) REFERENCES Patients(Patient_id);

-- ��������� ���������� ����� ��� ������������ ���������� �������
ALTER TABLE LabResults
ADD CONSTRAINT FK_LabResults_Appointments FOREIGN KEY (Appointment_id) REFERENCES Appointments(Appointment_id);

-- ��������� ���������� ����� ��� ��������� ���������� �� ��������
ALTER TABLE MedicalEquipment
ADD CONSTRAINT FK_MedicalEquipment_Procedures FOREIGN KEY (Procedure_id) REFERENCES Procedures(Procedure_id);
