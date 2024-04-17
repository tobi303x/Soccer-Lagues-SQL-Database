SET NAMES utf8mb4;
SET GLOBAL net_buffer_length = 5000000;
SET GLOBAL max_allowed_packet = 5000000000;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS Soccer_Leagues;
CREATE SCHEMA Soccer_Leagues;
USE Soccer_Leagues;

-- Create League Table
CREATE TABLE League (
    LeagueID INT PRIMARY KEY,
    LeagueName VARCHAR(255) UNIQUE
);

-- Create Team Table
CREATE TABLE Team (
    TeamID INT PRIMARY KEY,
    LeagueID INT,
    TeamName VARCHAR(255),
    FOREIGN KEY (LeagueID) REFERENCES League(LeagueID) ON DELETE CASCADE
);

-- Create Manager Table
CREATE TABLE Manager (
    ManagerID INT PRIMARY KEY,
    TeamID INT,
    ManagerName VARCHAR(255),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID) ON DELETE CASCADE
);

-- Create Captain Table
CREATE TABLE Captain (
    CaptainID INT PRIMARY KEY,
    TeamID INT,
    CaptainName VARCHAR(255),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID) ON DELETE CASCADE
);

-- Create Formation Table
CREATE TABLE Formation (
    FormationID INT PRIMARY KEY,
    FormationName VARCHAR(255)
);

-- Create Referee Table
CREATE TABLE Referee (
    RefereeID INT PRIMARY KEY,
    RefereeName VARCHAR(255) UNIQUE
);

-- Create AR1 Table
CREATE TABLE AR1 (
    AR1ID INT PRIMARY KEY,
    AR1Name VARCHAR(255) UNIQUE
);

-- Create AR2 Table
CREATE TABLE AR2 (
    AR2ID INT PRIMARY KEY,
    AR2Name VARCHAR(255) UNIQUE
);

-- Create FourthOfficial Table
CREATE TABLE FourthOfficial (
    FourthOfficialID INT PRIMARY KEY,
    FourthOfficialName VARCHAR(255) UNIQUE
);

-- Create VAR Table
CREATE TABLE VAR (
    VARID INT PRIMARY KEY,
    VARName VARCHAR(255) UNIQUE
);

-- Create Venue Table
CREATE TABLE Venue (
    VenueID INT PRIMARY KEY,
    VenueName VARCHAR(255) UNIQUE
);

-- Create MatchDate Table
CREATE TABLE MatchDate (
    MatchDateID INT PRIMARY KEY,
    MatchDate DATE
);

-- Create GoalType Table
CREATE TABLE GoalType (
    GoalTypeID INT PRIMARY KEY,
    GoalTypeName VARCHAR(255) UNIQUE
);

-- Create FootballMatch Table
CREATE TABLE FootballMatch (
    MatchID INT PRIMARY KEY,
    LeagueID INT,
    HomeTeamID INT,
    AwayTeamID INT,
    HomeScore INT,
    AwayScore INT,
    HomeXG DECIMAL(3,1),
    AwayXG DECIMAL(3,1),
    MatchDateID INT,
    MatchTime TIME,
    VenueID INT,
    FOREIGN KEY (LeagueID) REFERENCES League(LeagueID) ON DELETE CASCADE,
    FOREIGN KEY (HomeTeamID) REFERENCES Team(TeamID) ON DELETE CASCADE,
    FOREIGN KEY (AwayTeamID) REFERENCES Team(TeamID) ON DELETE CASCADE,
    FOREIGN KEY (MatchDateID) REFERENCES MatchDate(MatchDateID) ON DELETE CASCADE,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID) ON DELETE CASCADE
);

-- Create Player Table
CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,
    TeamID INT,
    PlayerName VARCHAR(255),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID) ON DELETE CASCADE
);

-- Create Squad Table
CREATE TABLE Squad (
    SquadID INT PRIMARY KEY,
    PlayerID INT,
    TeamID INT,
    MatchID INT,
    IsStarter BOOLEAN,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID) ON DELETE CASCADE,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID) ON DELETE CASCADE,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create Scorer Table
CREATE TABLE Scorer (
    ScorerID INT PRIMARY KEY,
    MatchID INT,
    PlayerID INT,
    TeamID INT,
    GoalTypeID INT,
    Minute VARCHAR(10),
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID) ON DELETE CASCADE,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID) ON DELETE CASCADE,
    FOREIGN KEY (GoalTypeID) REFERENCES GoalType(GoalTypeID) ON DELETE CASCADE
);

-- Create MatchVenue Table
CREATE TABLE MatchVenue (
    MatchVenueID INT PRIMARY KEY,
    MatchID INT,
    VenueID INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID) ON DELETE CASCADE
);

-- Create Attendance Table
CREATE TABLE Attendance (
    MatchID INT PRIMARY KEY,
    Attendance INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create MatchManager Table
CREATE TABLE MatchManager (
    MatchID INT PRIMARY KEY,
    HomeManagerID INT,
    AwayManagerID INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE,
    FOREIGN KEY (HomeManagerID) REFERENCES Manager(ManagerID) ON DELETE CASCADE,
    FOREIGN KEY (AwayManagerID) REFERENCES Manager(ManagerID) ON DELETE CASCADE
);

-- Create MatchCaptain Table
CREATE TABLE MatchCaptain (
    MatchID INT PRIMARY KEY,
    HomeCaptainID INT,
    AwayCaptainID INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE,
    FOREIGN KEY (HomeCaptainID) REFERENCES Captain(CaptainID) ON DELETE CASCADE,
    FOREIGN KEY (AwayCaptainID) REFERENCES Captain(CaptainID) ON DELETE CASCADE
);

-- Create MatchFormation Table
CREATE TABLE MatchFormation (
    MatchID INT PRIMARY KEY,
    HomeFormationID INT,
    AwayFormationID INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE,
    FOREIGN KEY (HomeFormationID) REFERENCES Formation(FormationID) ON DELETE CASCADE,
    FOREIGN KEY (AwayFormationID) REFERENCES Formation(FormationID) ON DELETE CASCADE
);

-- Create MatchReferee Table
CREATE TABLE MatchReferee (
    MatchID INT PRIMARY KEY,
    RefereeID INT,
    AR1ID INT,
    AR2ID INT,
    FourthOfficialID INT,
    VARID INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE,
    FOREIGN KEY (RefereeID) REFERENCES Referee(RefereeID) ON DELETE CASCADE,
    FOREIGN KEY (AR1ID) REFERENCES AR1(AR1ID) ON DELETE CASCADE,
    FOREIGN KEY (AR2ID) REFERENCES AR2(AR2ID) ON DELETE CASCADE,
    FOREIGN KEY (FourthOfficialID) REFERENCES FourthOfficial(FourthOfficialID) ON DELETE CASCADE,
    FOREIGN KEY (VARID) REFERENCES VAR(VARID) ON DELETE CASCADE
);

-- Create FoulStatistics Table
CREATE TABLE FoulStatistics (
    MatchID INT PRIMARY KEY,
    HomeFouls INT,
    AwayFouls INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create CornerStatistics Table
CREATE TABLE CornerStatistics (
    MatchID INT PRIMARY KEY,
    HomeCorners INT,
    AwayCorners INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create CrossStatistics Table
CREATE TABLE CrossStatistics (
	MatchID INT PRIMARY KEY,
    HomeCrosses INT,
    AwayCrosses INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create TouchStatistics Table
CREATE TABLE TouchStatistics (
    MatchID INT PRIMARY KEY,
    HomeTouches INT,
    AwayTouches INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create TackleStatistics Table
CREATE TABLE TackleStatistics (
	MatchID INT PRIMARY KEY,
    HomeTackles INT,
    AwayTackles INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create AerialStatistics Table
CREATE TABLE AerialStatistics (
    MatchID INT PRIMARY KEY,
    HomeAerialsWon INT,
    AwayAerialsWon INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create ClearanceStatistics Table
CREATE TABLE ClearanceStatistics (
	MatchID INT PRIMARY KEY,
    HomeClearances INT,
    AwayClearances INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create OffsideStatistics Table
CREATE TABLE OffsideStatistics (
    MatchID INT PRIMARY KEY,
    HomeOffsides INT,
    AwayOffsides INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create GoalKickStatistics Table
CREATE TABLE GoalKickStatistics (
    MatchID INT PRIMARY KEY,
    HomeGoalKicks INT,
    AwayGoalKicks INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create ThrowInStatistics Table
CREATE TABLE ThrowInStatistics (
    MatchID INT PRIMARY KEY,
    HomeThrowIns INT,
    AwayThrowIns INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create LongBallStatistics Table
CREATE TABLE LongBallStatistics (
    MatchID INT PRIMARY KEY,
    HomeLongBalls INT,
    AwayLongBalls INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create YellowCards Table
CREATE TABLE YellowCards (
    MatchID INT PRIMARY KEY,
    HomeYellowCards INT,
    AwayYellowCards INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

-- Create RedCards Table
CREATE TABLE RedCards (
    MatchID INT PRIMARY KEY,
    HomeRedCards INT,
    AwayRedCards INT,
    FOREIGN KEY (MatchID) REFERENCES FootballMatch(MatchID) ON DELETE CASCADE
);

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET SQL_MODE=@OLD_SQL_MODE;