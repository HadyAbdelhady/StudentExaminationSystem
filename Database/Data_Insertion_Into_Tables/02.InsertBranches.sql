-- Insert Smart Village Branch
EXEC InsertBranch
    @Name = N'Smart Village',
    @Location = N'Smart Village, Giza',
    @Phone = N'+201234567890',
    @EstablishmentDate = '1993-01-01',
    @ManagerID = 1;  -- Hany Labib

-- Insert Alexandria Branch
EXEC InsertBranch
    @Name = N'Alexandria',
    @Location = N'Moharam Bek, Alexandria',
    @Phone = N'+201098765432',
    @EstablishmentDate = '2018-05-15',
    @ManagerID = 11; --Mahmoud Ouf