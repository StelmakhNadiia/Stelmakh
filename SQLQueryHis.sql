--������� Doctors�� �� ������DoctorsHistory
ALTER TABLE Doctors ADD 
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN 
        CONSTRAINT DF_Doctors_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN 
        CONSTRAINT DF_Doctors_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Doctors
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.DoctorsHistory));
GO

-- ������� Patients�� �� ������PatientsHistory
ALTER TABLE Patients ADD 
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN 
        CONSTRAINT DF_Patients_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN 
        CONSTRAINT DF_Patients_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Patients
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.PatientsHistory));
GO

--������� Medications�� �� ������MedicationsHistory
ALTER TABLE Medications ADD 
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN 
        CONSTRAINT DF_Medications_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN 
        CONSTRAINT DF_Medications_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Medications
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.MedicationsHistory));
GO

-- ������� Insurance�� �� ������InsuranceHistory
ALTER TABLE InsuranceCompanies ADD 
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN 
        CONSTRAINT DF_InsuranceCompanies_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN 
        CONSTRAINT DF_InsuranceCompanies_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE InsuranceCompanies
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.InsuranceCompaniesHistory));
GO

--������� Appointments�� �� ������AppointmentsHistory
ALTER TABLE Appointments ADD 
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN 
        CONSTRAINT DF_Appointments_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN 
        CONSTRAINT DF_Appointments_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Appointments
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.AppointmentsHistory));
GO
