--Збережена процедура для таблиці Patients
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


EXEC dbo.sp_GetPatients --Виклик для фільтрації пацієнтів за певним ID
    @PatientID = 10,    
    @FirstName = NULL,     
    @LastName = NULL,      
    @PageSize = 5,         
    @PageNumber = 1,       
    @SortColumn = 'patient_id', 
    @SortDirection = 1;    


	--Виклик для фільтрації пацієнтів за ім'ям та прізвищем
	EXEC dbo.sp_GetPatients
    @PatientID = NULL,      
    @FirstName = 'М',    
    @LastName = 'С',    
    @PageSize = 10,         
    @PageNumber = 1,        
    @SortColumn = 'last_name', 
    @SortDirection = 0;     




--Збережена процедура для таблиці Doctors
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



 -- Виклик для фільтрації лікарів за спеціалізацією
EXEC dbo.sp_GetDoctors
    @DoctorID = NULL,      
    @FirstName = NULL,     
    @LastName = NULL,      
    @Specialty = '1',  
    @PageSize = 10,        
    @PageNumber = 1,       
    @SortColumn = 'first_name', 
    @SortDirection = 1;    






--Виклик для фільтрації лікарів за прізвищем і ім'ям
EXEC dbo.sp_GetDoctors
    @DoctorID = NULL,      
    @FirstName = 'Катерина',   
    @LastName = 'Яценко',     
    @Specialty = NULL, 
    @PageSize = 15,       
    @PageNumber = 1,       
    @SortColumn = 'last_name', 
    @SortDirection = 0;   




--Збережена процедура для таблиці Medications
CREATE OR ALTER PROCEDURE dbo.sp_GetMedications
    @MedicationID INT = NULL,
    @MedicationName NVARCHAR(100) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn NVARCHAR(128) = 'medication_id',  -- Колонка для сортування
    @SortDirection BIT = 0  -- 0 - ASC, 1 - DESC
AS
BEGIN
    -- Перевірка правильності значення MedicationID
    IF @MedicationID IS NOT NULL
        AND NOT EXISTS(SELECT 1 FROM [dbo].[Medications] WHERE medication_id = @MedicationID)
    BEGIN
        PRINT 'Incorrect value of @MedicationID'
        RETURN
    END

    -- Основний SELECT із фільтрацією, сортуванням та пагінацією
    SELECT *
    FROM [dbo].[Medications]
    WHERE 
        (@MedicationID IS NULL OR medication_id = @MedicationID) -- Фільтрація за MedicationID
        AND (@MedicationName IS NULL OR medication_name LIKE @MedicationName + '%') -- Фільтрація за MedicationName
    ORDER BY 
        CASE WHEN @SortDirection = 0 THEN 
            CASE @SortColumn
                WHEN 'medication_id' THEN CAST(medication_id AS NVARCHAR(50))
                WHEN 'medication_name' THEN medication_name
                WHEN 'description' THEN CAST(description AS NVARCHAR(MAX))  -- Оскільки text не можна сортувати, використовуємо CAST
                ELSE CAST(medication_id AS NVARCHAR(50)) -- За замовчуванням сортуємо за medication_id
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN 
            CASE @SortColumn
                WHEN 'medication_id' THEN CAST(medication_id AS NVARCHAR(50))
                WHEN 'medication_name' THEN medication_name
                WHEN 'description' THEN CAST(description AS NVARCHAR(MAX))  -- Оскільки text не можна сортувати, використовуємо CAST
                ELSE CAST(medication_id AS NVARCHAR(50)) -- За замовчуванням сортуємо за medication_id
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY;
END




EXEC dbo.sp_GetMedications
    @MedicationName = 'смекта',
    @PageSize = 5,
    @PageNumber = 1,
    @SortColumn = 'medication_name',
    @SortDirection = 1;  -- DESC