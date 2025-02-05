
-- PD(SD) Smart
EXEC InsertTrackIntoBranch
    @branchID = 1,
    @trackID = 1,
    @departmentManagerID = 3,
    @DepartementManagerJoinDate = '2022-02-14',
    @trackManagerID = 2, 
    @TrackManagerJoinDate = '2022-02-14';

-- IDA(SD) Smart
EXEC InsertTrackIntoBranch
    @branchID = 1,
    @trackID = 2,
    @departmentManagerID = 3,
    @DepartementManagerJoinDate = '2022-02-14',
    @trackManagerID = 2, 
    @TrackManagerJoinDate = '2022-02-14';

-- MCP(SD) Smart
EXEC InsertTrackIntoBranch
    @branchID = 1,
    @trackID = 3,
    @departmentManagerID = 3,
    @DepartementManagerJoinDate = '2022-02-14',
    @trackManagerID = 13, 
    @TrackManagerJoinDate = '2022-02-14';

-- UI(SD) Smart
EXEC InsertTrackIntoBranch
    @branchID = 1,
    @trackID = 4,
    @departmentManagerID = 3,
    @DepartementManagerJoinDate = '2022-02-14',
    @trackManagerID = 4, 
    @TrackManagerJoinDate = '2022-02-14';

-- ML(AI) Smart
EXEC InsertTrackIntoBranch
    @branchID = 1,
    @trackID = 5,
    @departmentManagerID = 11,
    @DepartementManagerJoinDate = '2021-02-14',
    @trackManagerID = 12, 
    @TrackManagerJoinDate = '2022-02-14';

-- ML(AI) Alex
EXEC InsertTrackIntoBranch
    @branchID = 2,
    @trackID = 5,
    @departmentManagerID = 11,
    @DepartementManagerJoinDate = '2022-02-14',
    @trackManagerID = 11, 
    @TrackManagerJoinDate = '2022-02-14';

-- PD(SD) Alex
EXEC InsertTrackIntoBranch
    @branchID = 2,
    @trackID = 1,
    @departmentManagerID = 11,
    @DepartementManagerJoinDate = '2022-02-14',
    @trackManagerID = 11, 
    @TrackManagerJoinDate = '2020-02-14';

-- JAVA(JETS) Smart
EXEC InsertTrackIntoBranch
    @branchID = 1,
    @trackID = 6,
    @departmentManagerID = 5,
    @DepartementManagerJoinDate = '2022-02-14',
    @trackManagerID = 5, 
    @TrackManagerJoinDate = '2022-02-14';

-- MN(JAVA) Smart
EXEC InsertTrackIntoBranch
    @branchID = 1,
    @trackID = 7,
    @departmentManagerID = 5,
    @DepartementManagerJoinDate = '2022-02-14',
    @trackManagerID = 6, 
    @TrackManagerJoinDate = '2022-02-14';


    SELECT * FROM Branch_Department_Track