CREATE OR ALTER PROCEDURE AddAppointmentWithDetails
    @PatientID INT,
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100),
    @Address VARCHAR(255),
    @InsuranceID INT,
    @EmergencyContactName VARCHAR(100),
    @EmergencyContactPhone VARCHAR(20),
    @DoctorID INT,
    @AppointmentDate DATE,
    @AppointmentTime TIME,
    @ReasonForVisit VARCHAR(255),
    @Status VARCHAR(50)
AS
BEGIN
    DECLARE @NewPatientID INT;
    DECLARE @NewDoctorID INT;
    DECLARE @NewAppointmentID INT;

    BEGIN TRY
        -- ������ ������ �������� ��� ��������� ���������
        EXEC dbo.sp_SetPatient 
            @First_name = @FirstName,
            @Last_name = @LastName,
            @Date_of_birth = @DateOfBirth,
            @Gender = @Gender,
            @Phone_number = @PhoneNumber,
            @Email = @Email,
            @Address = @Address,
            @Insurance_id = @InsuranceID,
            @Emergency_contact_name = @EmergencyContactName,
            @Emergency_contact_phone = @EmergencyContactPhone;

        -- ������ ������ ����� ��� ��������� ���������
        EXEC dbo.sp_SetDoctor 
            @Doctor_id = @NewDoctorID OUTPUT,
            @First_name = @FirstName,
            @Last_name = @LastName,
            @Specialty_id = 1, -- ������ �������� ������������
            @Phone_number = @PhoneNumber,
            @Email = @Email,
            @Office_id = 1; -- ������ ��������� ����

        -- ������ ���� �����������
        EXEC dbo.sp_SetAppointment 
            @Appointment_id = @NewAppointmentID OUTPUT,
            @Patient_id = @NewPatientID,
            @Doctor_id = @NewDoctorID,
            @Appointment_date = @AppointmentDate,
            @Appointment_time = @AppointmentTime,
            @Reason_for_visit = @ReasonForVisit,
            @Status = @Status;

        PRINT '�����������, ������� �� ���� ������ ������� ��� �������.';

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW; -- ���������� �������
    END CATCH
END;


-- ������ ��������� ��� ��������� ������ �������� � ������ �� ������������
DECLARE @NewPatientID INT;
DECLARE @NewDoctorID INT;
DECLARE @NewAppointmentID INT;

EXEC AddAppointmentWithDetails 
    @PatientID = NULL,
    @FirstName = '����',
    @LastName = '������',
    @DateOfBirth = '1990-04-10',
    @Gender = 'M',
    @PhoneNumber = '+380985264867',
    @Email = 'ivan.marchuk@example.com',
    @Address = '���. ��������, 10, �����',
    @InsuranceID = 2,
    @EmergencyContactName = '������� ����������',
    @EmergencyContactPhone = '+380671384570',
    @DoctorID = NULL,
    @AppointmentDate = '2025-01-15',
    @AppointmentTime = '10:00:00',
    @ReasonForVisit = '������� ���������� �������',
    @Status = '�����������';

-- ������ ��������� ��� ��������� ��������� �������� � ����� ������������
DECLARE @NewPatientID2 INT;
DECLARE @NewDoctorID2 INT;
DECLARE @NewAppointmentID2 INT;

EXEC AddAppointmentWithDetails 
    @PatientID = 5, -- �������� �������
    @FirstName = 'Michael',
    @LastName = 'Johnson',
    @DateOfBirth = '1988-02-25',
    @Gender = 'M',
    @PhoneNumber = '+123456788',
    @Email = 'michael.johnson@example.com',
    @Address = '789 Pine St, Othercity',
    @InsuranceID = 3,
    @EmergencyContactName = 'Sarah Johnson',
    @EmergencyContactPhone = '+987654322',
    @DoctorID = NULL,
    @AppointmentDate = '2025-02-20',
    @AppointmentTime = '16:30:00',
    @ReasonForVisit = 'Consultation',
    @Status = 'Confirmed';

-- �������� ����������
SELECT @NewPatientID AS NewPatientID, @NewDoctorID AS NewDoctorID, @NewAppointmentID AS NewAppointmentID;
SELECT @NewPatientID2 AS NewPatientID2, @NewDoctorID2 AS NewDoctorID2, @NewAppointmentID2 AS NewAppointmentID2;
DROP PROCEDURE AddAppointmentWithDetails






