Declare @PDID INT;
Declare @IDAID INT;
Declare @MCPID INT;
Declare @UIID INT;
Declare @MLID INT;
Declare @JAVAID INT;
Declare @MNID INT;

-- SD Tracks
EXEC InsertTrack
    @Name = 'Professional Development',
    @DepartmentID = 1,
    @NewTrackID = @PDID OUTPUT;

EXEC InsertTrack
    @Name = 'Integraded Development & Architecture',
    @DepartmentID = 1,
    @NewTrackID = @IDAID OUTPUT;

EXEC InsertTrack
    @Name = 'Mobile Cross Platform',
    @DepartmentID = 1,
    @NewTrackID = @MCPID OUTPUT;

EXEC InsertTrack
    @Name = 'User Interface Development',
    @DepartmentID = 1,
    @NewTrackID = @UIID OUTPUT;


-- AI Tracks
EXEC InsertTrack
    @Name = 'Machine Learning',
    @DepartmentID = 2,
    @NewTrackID = @MLID OUTPUT;


-- JETS Tracks
EXEC InsertTrack
    @Name = 'JAVA',
    @DepartmentID = 3,
    @NewTrackID = @JAVAID OUTPUT;

EXEC InsertTrack
    @Name = 'Mobile Native',
    @DepartmentID = 3,
    @NewTrackID = @MNID OUTPUT;