CREATE OR ALTER PROCEDURE dbo.sp_SetPatient
@Patient_id INT = NULL OUTPUT,
@First_name VARCHAR(100) = NULL,
@Last_name VARCHAR(100) = NULL,
@Date_of_birth DATE = NULL,
@Gender CHAR(1) = NULL,
@Phone_number VARCHAR(20) = NULL,
@Email VARCHAR(100) = NULL,
@Address VARCHAR(255) = NULL,
@Insurance_id INT = NULL,
@Emergency_contact_name VARCHAR(100) = NULL,
@Emergency_contact_phone VARCHAR(20) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Patient_id IS NULL
        BEGIN
            -- Додавання нового пацієнта
            INSERT INTO dbo.Patients 
            (First_name, Last_name, Date_of_birth, Gender, Phone_number, Email, Address, Insurance_id, Emergency_contact_name, Emergency_contact_phone)
            VALUES 
            (@First_name, @Last_name, @Date_of_birth, @Gender, @Phone_number, @Email, @Address, @Insurance_id, @Emergency_contact_name, @Emergency_contact_phone);
            SET @Patient_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            -- Оновлення існуючого пацієнта
            UPDATE dbo.Patients
            SET First_name = ISNULL(@First_name, First_name),
                Last_name = ISNULL(@Last_name, Last_name),
                Date_of_birth = ISNULL(@Date_of_birth, Date_of_birth),
                Gender = ISNULL(@Gender, Gender),
                Phone_number = ISNULL(@Phone_number, Phone_number),
                Email = ISNULL(@Email, Email),
                Address = ISNULL(@Address, Address),
                Insurance_id = ISNULL(@Insurance_id, Insurance_id),
                Emergency_contact_name = ISNULL(@Emergency_contact_name, Emergency_contact_name),
                Emergency_contact_phone = ISNULL(@Emergency_contact_phone, Emergency_contact_phone)
            WHERE Patient_id = @Patient_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Patient_id INT = 1;
EXEC dbo.sp_SetPatient 
    @Patient_id = @Patient_id OUTPUT,
    @First_name = 'Сергій',
    @Last_name = 'Мельник',
    @Date_of_birth = '1986-12-20',
    @Gender = 'M',
    @Phone_number = '+380671234572',
    @Email = 'serhiy.melynok@example.com',
    @Address = 'вул. Гоголя, 14, Львів',
    @Insurance_id = 1,
    @Emergency_contact_name = 'Ірина Ковальчук',
    @Emergency_contact_phone = '+380501234568';
SELECT @Patient_id AS NewPatientID;



CREATE OR ALTER PROCEDURE dbo.sp_SetDoctor
@Doctor_id INT = NULL OUTPUT,
@First_name VARCHAR(100) = NULL,
@Last_name VARCHAR(100) = NULL,
@Specialty_id INT = NULL,
@Phone_number VARCHAR(20) = NULL,
@Email VARCHAR(100) = NULL,
@Office_id INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @Doctor_id IS NULL
        BEGIN
            -- Додавання нового лікаря
            INSERT INTO dbo.Doctors 
            (First_name, Last_name, Specialty_id, Phone_number, Email, Office_id)
            VALUES 
            (@First_name, @Last_name, @Specialty_id, @Phone_number, @Email, @Office_id);
            SET @Doctor_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            -- Оновлення існуючого лікаря
            UPDATE dbo.Doctors
            SET First_name = ISNULL(@First_name, First_name),
                Last_name = ISNULL(@Last_name, Last_name),
                Specialty_id = ISNULL(@Specialty_id, Specialty_id),
                Phone_number = ISNULL(@Phone_number, Phone_number),
                Email = ISNULL(@Email, Email),
                Office_id = ISNULL(@Office_id, Office_id)
            WHERE Doctor_id = @Doctor_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Doctor_id INT = 16;
EXEC dbo.sp_SetDoctor 
    @Doctor_id = @Doctor_id OUTPUT,
    @First_name = 'Олег',
    @Last_name = 'Кузьма',
    @Specialty_id = 11,
    @Phone_number = '0981112223',
    @Email = 'оleg.kuzma@example.com',
    @Office_id = 2;
SELECT @Doctor_id AS NewDoctorID;



CREATE OR ALTER PROCEDURE dbo.sp_SetAppointment
@Appointment_id INT = NULL OUTPUT,
@Patient_id INT = NULL,
@Doctor_id INT = NULL,
@Appointment_date DATE = NULL,
@Appointment_time TIME = NULL,
@Reason_for_visit VARCHAR(255) = NULL,
@Status VARCHAR(50) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Appointment_id IS NULL
        BEGIN
            -- Додавання нового запису
            INSERT INTO dbo.Appointments 
            (Patient_id, Doctor_id, Appointment_date, Appointment_time, Reason_for_visit, Status)
            VALUES 
            (@Patient_id, @Doctor_id, @Appointment_date, @Appointment_time, @Reason_for_visit, @Status);
            SET @Appointment_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            -- Оновлення запису
            UPDATE dbo.Appointments
            SET Patient_id = ISNULL(@Patient_id, Patient_id),
                Doctor_id = ISNULL(@Doctor_id, Doctor_id),
                Appointment_date = ISNULL(@Appointment_date, Appointment_date),
                Appointment_time = ISNULL(@Appointment_time, Appointment_time),
                Reason_for_visit = ISNULL(@Reason_for_visit, Reason_for_visit),
                Status = ISNULL(@Status, Status)
            WHERE Appointment_id = @Appointment_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Appointment_id INT = 5;
EXEC dbo.sp_SetAppointment 
    @Appointment_id = @Appointment_id OUTPUT,
    @Patient_id = 5,
    @Doctor_id = 2,
    @Appointment_date = '2024-12-01',
    @Appointment_time = '14:30:00',
    @Reason_for_visit = 'Терапія',
    @Status = 'Відхилено';
SELECT @Appointment_id AS NewAppointmentID;



CREATE OR ALTER PROCEDURE dbo.sp_SetInsuranceCompany
@Insurance_id INT = NULL OUTPUT,
@Insurance_company_name VARCHAR(100) = NULL,
@Plan_name VARCHAR(100) = NULL,
@Coverage_amount DECIMAL(10, 2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Insurance_id IS NULL
        BEGIN
            INSERT INTO dbo.InsuranceCompanies (Insurance_company_name, Plan_name, Coverage_amount)
            VALUES (@Insurance_company_name, @Plan_name, @Coverage_amount);
            SET @Insurance_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.InsuranceCompanies
            SET Insurance_company_name = ISNULL(@Insurance_company_name, Insurance_company_name),
                Plan_name = ISNULL(@Plan_name, Plan_name),
                Coverage_amount = ISNULL(@Coverage_amount, Coverage_amount)
            WHERE Insurance_id = @Insurance_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Insurance_id INT = 10;
EXEC dbo.sp_SetInsuranceCompany 
    @Insurance_id = @Insurance_id OUTPUT,
    @Insurance_company_name = 'Страхова компанія "Здоров’я"',
    @Plan_name = 'План А',
    @Coverage_amount = 120000.00;
SELECT @Insurance_id AS NewInsuranceID;



CREATE OR ALTER PROCEDURE dbo.sp_SetOffice
@Office_id INT = NULL OUTPUT,
@Office_number VARCHAR(50) = NULL,
@Location VARCHAR(100) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Office_id IS NULL
        BEGIN
            INSERT INTO dbo.Offices (Office_number, Location)
            VALUES (@Office_number, @Location);
            SET @Office_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.Offices
            SET Office_number = ISNULL(@Office_number, Office_number),
                Location = ISNULL(@Location, Location)
            WHERE Office_id = @Office_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Office_id INT = NULL;
EXEC dbo.sp_SetOffice 
    @Office_id = @Office_id OUTPUT,
    @Office_number = 'Офіс 16',
    @Location = 'Вулиця Шевченка, 2';
SELECT @Office_id AS NewOfficeID;




CREATE OR ALTER PROCEDURE dbo.sp_SetSpecialty
@Specialty_id INT = NULL OUTPUT,
@Specialty_name VARCHAR(100) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Specialty_id IS NULL
        BEGIN
            INSERT INTO dbo.Specialties (Specialty_name)
            VALUES (@Specialty_name);
            SET @Specialty_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.Specialties
            SET Specialty_name = ISNULL(@Specialty_name, Specialty_name)
            WHERE Specialty_id = @Specialty_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Specialty_id INT = NULL;
EXEC dbo.sp_SetSpecialty 
    @Specialty_id = @Specialty_id OUTPUT,
    @Specialty_name = 'Косметолог';
SELECT @Specialty_id AS NewSpecialtyID;



CREATE OR ALTER PROCEDURE dbo.sp_SetMedication
@Medication_id INT = NULL OUTPUT,
@Medication_name VARCHAR(100) = NULL,
@Description TEXT = NULL
AS
BEGIN
    BEGIN TRY
        IF @Medication_id IS NULL
        BEGIN
            INSERT INTO dbo.Medications (Medication_name, Description)
            VALUES (@Medication_name, @Description);
            SET @Medication_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.Medications
            SET Medication_name = ISNULL(@Medication_name, Medication_name),
                Description = ISNULL(@Description, Description)
            WHERE Medication_id = @Medication_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Medication_id INT = 34;
EXEC dbo.sp_SetMedication 
    @Medication_id = @Medication_id OUTPUT,
    @Medication_name = 'Фенілпропаноламін',
    @Description = 'Препарат для зменшення закладеності носа.';
SELECT @Medication_id AS NewMedicationID;



CREATE OR ALTER PROCEDURE dbo.sp_SetPrescription
@Prescription_id INT = NULL OUTPUT,
@Appointment_id INT = NULL,
@Medication_id INT = NULL,
@Dosage VARCHAR(50) = NULL,
@Instructions TEXT = NULL
AS
BEGIN
    BEGIN TRY
        IF @Prescription_id IS NULL
        BEGIN
            INSERT INTO dbo.Prescriptions (Appointment_id, Medication_id, Dosage, Instructions)
            VALUES (@Appointment_id, @Medication_id, @Dosage, @Instructions);
            SET @Prescription_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.Prescriptions
            SET Appointment_id = ISNULL(@Appointment_id, Appointment_id),
                Medication_id = ISNULL(@Medication_id, Medication_id),
                Dosage = ISNULL(@Dosage, Dosage),
                Instructions = ISNULL(@Instructions, Instructions)
            WHERE Prescription_id = @Prescription_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Prescription_id INT = NULL;
EXEC dbo.sp_SetPrescription 
    @Prescription_id = @Prescription_id OUTPUT,
    @Appointment_id = 5,
    @Medication_id = 2,
    @Dosage = '10mg',
    @Instructions = 'Приймати 1 раз на день вночі.';
SELECT @Prescription_id AS NewPrescriptionID;



CREATE OR ALTER PROCEDURE dbo.sp_SetLabResult
@Lab_result_id INT = NULL OUTPUT,
@Patient_id INT = NULL,
@Appointment_id INT = NULL,
@Test_name VARCHAR(100) = NULL,
@Result_value VARCHAR(100) = NULL,
@Result_date DATE = NULL
AS
BEGIN
    BEGIN TRY
        IF @Lab_result_id IS NULL
        BEGIN
            INSERT INTO dbo.LabResults (Patient_id, Appointment_id, Test_name, Result_value, Result_date)
            VALUES (@Patient_id, @Appointment_id, @Test_name, @Result_value, @Result_date);
            SET @Lab_result_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.LabResults
            SET Patient_id = ISNULL(@Patient_id, Patient_id),
                Appointment_id = ISNULL(@Appointment_id, Appointment_id),
                Test_name = ISNULL(@Test_name, Test_name),
                Result_value = ISNULL(@Result_value, Result_value),
                Result_date = ISNULL(@Result_date, Result_date)
            WHERE Lab_result_id = @Lab_result_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Lab_result_id INT = NULL;
EXEC dbo.sp_SetLabResult 
    @Lab_result_id = @Lab_result_id OUTPUT,
    @Patient_id = 7,
    @Appointment_id = 4,
    @Test_name = 'Аналіз на алергії',
    @Result_value = 'Негативний',
    @Result_date = '2024-11-25';
SELECT @Lab_result_id AS NewLabResultID;



CREATE OR ALTER PROCEDURE dbo.sp_SetProcedure
@Procedure_id INT = NULL OUTPUT,
@Procedure_name VARCHAR(100) = NULL,
@Description TEXT = NULL,
@Cost DECIMAL(10, 2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Procedure_id IS NULL
        BEGIN
            INSERT INTO dbo.Procedures (Procedure_name, Description, Cost)
            VALUES (@Procedure_name, @Description, @Cost);
            SET @Procedure_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.Procedures
            SET Procedure_name = ISNULL(@Procedure_name, Procedure_name),
                Description = ISNULL(@Description, Description),
                Cost = ISNULL(@Cost, Cost)
            WHERE Procedure_id = @Procedure_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Procedure_id INT = 20;
EXEC dbo.sp_SetProcedure 
    @Procedure_id = @Procedure_id OUTPUT,
    @Procedure_name = 'Консультація',
    @Description = 'Повторна консультація лікаря.',
    @Cost = 900.00;
SELECT @Procedure_id AS NewProcedureID;



CREATE OR ALTER PROCEDURE dbo.sp_SetDiagnosis
@Diagnosis_id INT = NULL OUTPUT,
@Appointment_id INT = NULL,
@Diagnosis_name VARCHAR(100) = NULL,
@Description TEXT = NULL
AS
BEGIN
    BEGIN TRY
        IF @Diagnosis_id IS NULL
        BEGIN
            INSERT INTO dbo.Diagnoses (Appointment_id, Diagnosis_name, Description)
            VALUES (@Appointment_id, @Diagnosis_name, @Description);
            SET @Diagnosis_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.Diagnoses
            SET Appointment_id = ISNULL(@Appointment_id, Appointment_id),
                Diagnosis_name = ISNULL(@Diagnosis_name, Diagnosis_name),
                Description = ISNULL(@Description, Description)
            WHERE Diagnosis_id = @Diagnosis_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Diagnosis_id INT = 13;
EXEC dbo.sp_SetDiagnosis 
    @Diagnosis_id = @Diagnosis_id OUTPUT,
    @Appointment_id = 8,
    @Diagnosis_name = 'Депресія',
    @Description = 'Хронічний емоційний стан, що викликає почуття смутку і безнадії.';
SELECT @Diagnosis_id AS NewDiagnosisID;



CREATE OR ALTER PROCEDURE dbo.sp_SetDoctorSchedule
@Schedule_id INT = NULL OUTPUT,
@Doctor_id INT = NULL,
@Available_date DATE = NULL,
@Available_time_from TIME = NULL,
@Available_time_to TIME = NULL
AS
BEGIN
    BEGIN TRY
        IF @Schedule_id IS NULL
        BEGIN
            INSERT INTO dbo.DoctorSchedules (Doctor_id, Available_date, Available_time_from, Available_time_to)
            VALUES (@Doctor_id, @Available_date, @Available_time_from, @Available_time_to);
            SET @Schedule_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.DoctorSchedules
            SET Doctor_id = ISNULL(@Doctor_id, Doctor_id),
                Available_date = ISNULL(@Available_date, Available_date),
                Available_time_from = ISNULL(@Available_time_from, Available_time_from),
                Available_time_to = ISNULL(@Available_time_to, Available_time_to)
            WHERE Schedule_id = @Schedule_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Schedule_id INT = NULL;
EXEC dbo.sp_SetDoctorSchedule 
    @Schedule_id = @Schedule_id OUTPUT,
    @Doctor_id = 3,
    @Available_date = '2024-11-27',
    @Available_time_from = '11:00',
    @Available_time_to = '19:00';
SELECT @Schedule_id AS NewScheduleID;



CREATE OR ALTER PROCEDURE dbo.sp_SetMedicalRecord
@Record_id INT = NULL OUTPUT,
@Patient_id INT = NULL,
@Appointment_id INT = NULL,
@Diagnosis_id INT = NULL,
@Record_details TEXT = NULL,
@Record_date DATE = NULL
AS
BEGIN
    BEGIN TRY
        IF @Record_id IS NULL
        BEGIN
            INSERT INTO dbo.MedicalRecords (Patient_id, Appointment_id, Diagnosis_id, Record_details, Record_date)
            VALUES (@Patient_id, @Appointment_id, @Diagnosis_id, @Record_details, @Record_date);
            SET @Record_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.MedicalRecords
            SET Patient_id = ISNULL(@Patient_id, Patient_id),
                Appointment_id = ISNULL(@Appointment_id, Appointment_id),
                Diagnosis_id = ISNULL(@Diagnosis_id, Diagnosis_id),
                Record_details = ISNULL(@Record_details, Record_details),
                Record_date = ISNULL(@Record_date, Record_date)
            WHERE Record_id = @Record_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Record_id INT = 27;
EXEC dbo.sp_SetMedicalRecord 
    @Record_id = @Record_id OUTPUT,
    @Patient_id = 12,
    @Appointment_id = 27,
    @Diagnosis_id = 27,
    @Record_details = 'Діагноз: алопеція.',
    @Record_date = '2024-11-27';
SELECT @Record_id AS NewRecordID;



CREATE OR ALTER PROCEDURE dbo.sp_SetMedicalEquipment
@Equipment_id INT = NULL OUTPUT,
@Equipment_name VARCHAR(100) = NULL,
@Equipment_type VARCHAR(100) = NULL,
@Status VARCHAR(50) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Equipment_id IS NULL
        BEGIN
            INSERT INTO dbo.MedicalEquipment (Equipment_name, Equipment_type, Status)
            VALUES (@Equipment_name, @Equipment_type, @Status);
            SET @Equipment_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.MedicalEquipment
            SET Equipment_name = ISNULL(@Equipment_name, Equipment_name),
                Equipment_type = ISNULL(@Equipment_type, Equipment_type),
                Status = ISNULL(@Status, Status)
            WHERE Equipment_id = @Equipment_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


--Виклик
DECLARE @Equipment_id INT = NULL;
EXEC dbo.sp_SetMedicalEquipment 
    @Equipment_id = @Equipment_id OUTPUT,
    @Equipment_name = 'Лазер',
    @Equipment_type = 'Лікування',
    @Status = 'Використовується';
SELECT @Equipment_id AS NewEquipmentID;



CREATE OR ALTER PROCEDURE dbo.sp_SetPayment 
    @Payment_id INT = NULL OUTPUT,
    @Patient_id INT,
    @Appointment_id INT = NULL,
    @Amount DECIMAL(10, 2),
    @Payment_date DATE = NULL,
    @Payment_method VARCHAR(50) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Payment_id IS NULL
        BEGIN
            -- Додавання нового платежу
            INSERT INTO dbo.Payments (Patient_id, Appointment_id, Amount, Payment_date, Payment_method)
            VALUES (@Patient_id, @Appointment_id, @Amount, @Payment_date, @Payment_method);

            -- Повертаємо ID останнього доданого платежу
            SET @Payment_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            -- Оновлення існуючого платежу
            UPDATE dbo.Payments
            SET 
                Patient_id = ISNULL(@Patient_id, Patient_id),
                Appointment_id = ISNULL(@Appointment_id, Appointment_id),
                Amount = ISNULL(@Amount, Amount),
                Payment_date = ISNULL(@Payment_date, Payment_date),
                Payment_method = ISNULL(@Payment_method, Payment_method)
            WHERE Payment_id = @Payment_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

DECLARE @Payment_id INT = 14;
EXEC dbo.sp_SetPayment 
    @Payment_id = @Payment_id OUTPUT,
    @Patient_id = 1,
    @Appointment_id = 14,
    @Amount = 300.00,
    @Payment_date = '2024-11-28',
    @Payment_method = 'Готівка';

SELECT @Payment_id AS NewPaymentID;