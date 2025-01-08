--��������� ��������� ��� ������� Patients
CREATE OR ALTER PROCEDURE dbo.sp_GetPatients
    @PatientID INT = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'PatientID',  
    @SortDirection BIT = 0  -- 0-ASC, 1-DESC
AS
BEGIN
    IF @PatientID IS NOT NULL
    AND NOT EXISTS(SELECT * FROM dbo.Patients WHERE patient_id = @PatientID)
    BEGIN
        PRINT 'Incorrect value of @PatientID'
        RETURN
    END

    SELECT *
    FROM dbo.Patients
    WHERE (patient_id = @PatientID OR @PatientID IS NULL)
    AND (first_name LIKE @FirstName + '%' OR @FirstName IS NULL)
    AND (last_name LIKE @LastName + '%' OR @LastName IS NULL)
    ORDER BY 
        CASE 
            WHEN @SortDirection = 0 THEN 
                CASE @SortColumn
                    WHEN 'PatientID' THEN CAST(patient_id AS NVARCHAR(50))
                    WHEN 'FirstName' THEN first_name
                    WHEN 'LastName' THEN last_name
                    WHEN 'DateOfBirth' THEN date_of_birth
                END
            END ASC,
        CASE 
            WHEN @SortDirection = 1 THEN 
                CASE @SortColumn
                    WHEN 'PatientID' THEN CAST(patient_id AS NVARCHAR(50))
                    WHEN 'FirstName' THEN first_name
                    WHEN 'LastName' THEN last_name
                    WHEN 'DateOfBirth' THEN date_of_birth
                END
            END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;


EXEC dbo.sp_GetPatients --������ ��� ���������� �������� �� ������ ID
    @PatientID = 10,    
    @FirstName = NULL,     
    @LastName = NULL,      
    @PageSize = 5,         
    @PageNumber = 1,       
    @SortColumn = 'patient_id', 
    @SortDirection = 1;    


	--������ ��� ���������� �������� �� ��'�� �� ��������
	EXEC dbo.sp_GetPatients
    @PatientID = NULL,      
    @FirstName = '�',    
    @LastName = '�',    
    @PageSize = 10,         
    @PageNumber = 1,        
    @SortColumn = 'last_name', 
    @SortDirection = 0;     




--��������� ��������� ��� ������� Doctors
CREATE OR ALTER PROCEDURE dbo.sp_GetDoctors
    @DoctorID INT = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @Specialty NVARCHAR(50) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'doctor_id',  
    @SortDirection BIT = 0  -- 0-ASC, 1-DESC
AS
BEGIN
   
    IF @DoctorID IS NOT NULL
    AND NOT EXISTS(SELECT * FROM dbo.Doctors WHERE doctor_id = @DoctorID)
    BEGIN
        PRINT 'Incorrect value of @DoctorID'
        RETURN
    END

   
    SELECT *
    FROM dbo.Doctors
    WHERE (doctor_id = @DoctorID OR @DoctorID IS NULL)
    AND (first_name LIKE @FirstName + '%' OR @FirstName IS NULL)
    AND (last_name LIKE @LastName + '%' OR @LastName IS NULL)
    AND (specialty_id LIKE @Specialty + '%' OR @Specialty IS NULL)
    ORDER BY 
        CASE 
            WHEN @SortDirection = 0 THEN 
                CASE @SortColumn
                    WHEN 'DoctorID' THEN CAST(doctor_id AS NVARCHAR(50))
                    WHEN 'FirstName' THEN first_name
                    WHEN 'LastName' THEN last_name
                    WHEN 'Specialty' THEN specialty_id
                END
            END ASC,
        CASE 
            WHEN @SortDirection = 1 THEN 
                CASE @SortColumn
                    WHEN 'DoctorID' THEN CAST(doctor_id AS NVARCHAR(50))
                    WHEN 'FirstName' THEN first_name
                    WHEN 'LastName' THEN last_name
                    WHEN 'Specialty' THEN specialty_id
                END
            END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;



 -- ������ ��� ���������� ����� �� �������������
EXEC dbo.sp_GetDoctors
    @DoctorID = NULL,      
    @FirstName = NULL,     
    @LastName = NULL,      
    @Specialty = '1',  
    @PageSize = 10,        
    @PageNumber = 1,       
    @SortColumn = 'first_name', 
    @SortDirection = 1;    






--������ ��� ���������� ����� �� �������� � ��'��
EXEC dbo.sp_GetDoctors
    @DoctorID = NULL,      
    @FirstName = '��������',   
    @LastName = '������',     
    @Specialty = NULL, 
    @PageSize = 15,       
    @PageNumber = 1,       
    @SortColumn = 'last_name', 
    @SortDirection = 0;   




--��������� ��������� ��� ������� Medications
CREATE OR ALTER PROCEDURE dbo.sp_GetMedications
    @MedicationID INT = NULL,
    @MedicationName NVARCHAR(100) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn NVARCHAR(128) = 'medication_id',  -- ������� ��� ����������
    @SortDirection BIT = 0  -- 0 - ASC, 1 - DESC
AS
BEGIN
    -- �������� ����������� �������� MedicationID
    IF @MedicationID IS NOT NULL
        AND NOT EXISTS(SELECT 1 FROM [dbo].[Medications] WHERE medication_id = @MedicationID)
    BEGIN
        PRINT 'Incorrect value of @MedicationID'
        RETURN
    END

    -- �������� SELECT �� �����������, ����������� �� ���������
    SELECT *
    FROM [dbo].[Medications]
    WHERE 
        (@MedicationID IS NULL OR medication_id = @MedicationID) -- Գ�������� �� MedicationID
        AND (@MedicationName IS NULL OR medication_name LIKE @MedicationName + '%') -- Գ�������� �� MedicationName
    ORDER BY 
        CASE WHEN @SortDirection = 0 THEN 
            CASE @SortColumn
                WHEN 'medication_id' THEN CAST(medication_id AS NVARCHAR(50))
                WHEN 'medication_name' THEN medication_name
                WHEN 'description' THEN CAST(description AS NVARCHAR(MAX))  -- ������� text �� ����� ���������, ������������� CAST
                ELSE CAST(medication_id AS NVARCHAR(50)) -- �� ������������� ������� �� medication_id
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN 
            CASE @SortColumn
                WHEN 'medication_id' THEN CAST(medication_id AS NVARCHAR(50))
                WHEN 'medication_name' THEN medication_name
                WHEN 'description' THEN CAST(description AS NVARCHAR(MAX))  -- ������� text �� ����� ���������, ������������� CAST
                ELSE CAST(medication_id AS NVARCHAR(50)) -- �� ������������� ������� �� medication_id
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY;
END




EXEC dbo.sp_GetMedications
    @MedicationName = '������',
    @PageSize = 5,
    @PageNumber = 1,
    @SortColumn = 'medication_name',
    @SortDirection = 1;  -- DESC