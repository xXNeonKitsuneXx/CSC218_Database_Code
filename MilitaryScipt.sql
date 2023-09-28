--<ScriptOptions statementTerminator=";"/>

grant select on fort to user kitiphod;
grant select on deployment to user kitiphod;
grant select on division to user kitiphod;
grant select on divisiondeploy to user kitiphod;
grant select on military to user kitiphod;
grant select on vehicle to user kitiphod;
grant select on weapon to user kitiphod;

CREATE TABLE Division (
		DivisionNumber SMALLINT NOT NULL, 
		Name CHAR(20), 
		zone CHAR(10), 
		readyForWar CHAR(1), 
		FortName CHAR(20) NOT NULL
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE TABLE DivisionDeploy (
		DivisionNumber SMALLINT NOT NULL, 
		deploymenyNumber INTEGER NOT NULL, 
		casualty INTEGER, 
		injury INTEGER
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE TABLE Fort (
		FortName CHAR(20) NOT NULL, 
		location CHAR(20), 
		Type CHAR(10) NOT NULL
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE TABLE Military (
		Type CHAR(10) NOT NULL, 
		Mission CLOB(5), 
		Budget DECIMAL(12 , 2), 
		GeneralSSN CHAR(13)
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE TABLE Vehicle (
		vehicleId INTEGER NOT NULL, 
		type CHAR(10), 
		boughtDate DATE
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE TABLE VehicleWeapon (
		WeaponNumber INTEGER NOT NULL, 
		vehicleId INTEGER NOT NULL, 
		setUpDate DATE
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE TABLE Weapon (
		WeaponNumber INTEGER NOT NULL, 
		name CHAR(20), 
		destructiveRange DECIMAL(5 , 2), 
		shootingDistance INTEGER, 
		FortName CHAR(20) NOT NULL, 
		boughtDate DATE
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE TABLE deployment (
		deploymenyNumber INTEGER NOT NULL, 
		fromDate DATE, 
		toDate DATE, 
		Area CHAR(20)
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE TABLE soldier (
		SSN CHAR(13) NOT NULL, 
		Firstname CHAR(20), 
		Lastname CHAR(30), 
		Gender CHAR(1), 
		DOB DATE, 
		Rank CHAR(15) NOT NULL, 
		DivisionNumber SMALLINT NOT NULL, 
		FortName CHAR(20)
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

ALTER TABLE Division ADD CONSTRAINT Division_PK PRIMARY KEY
	(DivisionNumber);

ALTER TABLE DivisionDeploy ADD CONSTRAINT DivisionDeploy_PK PRIMARY KEY
	(DivisionNumber, 
	 deploymenyNumber);

ALTER TABLE Fort ADD CONSTRAINT Fort_PK PRIMARY KEY
	(FortName);

ALTER TABLE Military ADD CONSTRAINT Military_PK PRIMARY KEY
	(Type);

ALTER TABLE Vehicle ADD CONSTRAINT Vehicle_PK PRIMARY KEY
	(vehicleId);

ALTER TABLE VehicleWeapon ADD CONSTRAINT VehicleWeapon_PK PRIMARY KEY
	(WeaponNumber, 
	 vehicleId);

ALTER TABLE Weapon ADD CONSTRAINT Weapon_PK PRIMARY KEY
	(WeaponNumber);

ALTER TABLE deployment ADD CONSTRAINT deployment_PK PRIMARY KEY
	(deploymenyNumber);

ALTER TABLE soldier ADD CONSTRAINT soldier_PK PRIMARY KEY
	(SSN);

ALTER TABLE Division ADD CONSTRAINT Division_Fort_FK FOREIGN KEY
	(FortName)
	REFERENCES Fort
	(FortName)
	ON DELETE CASCADE;

ALTER TABLE DivisionDeploy ADD CONSTRAINT DivisionDeploy_Division_FK FOREIGN KEY
	(DivisionNumber)
	REFERENCES Division
	(DivisionNumber)
	ON DELETE CASCADE;

ALTER TABLE DivisionDeploy ADD CONSTRAINT DivisionDeploy_deployment_FK FOREIGN KEY
	(deploymenyNumber)
	REFERENCES deployment
	(deploymenyNumber)
	ON DELETE CASCADE;

ALTER TABLE Fort ADD CONSTRAINT Fort_Military_FK FOREIGN KEY
	(Type)
	REFERENCES Military
	(Type)
	ON DELETE CASCADE;

ALTER TABLE Military ADD CONSTRAINT Military_soldier_FK FOREIGN KEY
	(GeneralSSN)
	REFERENCES soldier
	(SSN)
	ON DELETE CASCADE;

ALTER TABLE VehicleWeapon ADD CONSTRAINT VehicleWeapon_Vehicle_FK FOREIGN KEY
	(vehicleId)
	REFERENCES Vehicle
	(vehicleId)
	ON DELETE CASCADE;

ALTER TABLE VehicleWeapon ADD CONSTRAINT VehicleWeapon_Weapon_FK FOREIGN KEY
	(WeaponNumber)
	REFERENCES Weapon
	(WeaponNumber)
	ON DELETE CASCADE;

ALTER TABLE Weapon ADD CONSTRAINT Weapon_Fort_FK FOREIGN KEY
	(FortName)
	REFERENCES Fort
	(FortName)
	ON DELETE CASCADE;

ALTER TABLE soldier ADD CONSTRAINT soldier_Division_FK FOREIGN KEY
	(DivisionNumber)
	REFERENCES Division
	(DivisionNumber)
	ON DELETE CASCADE;

ALTER TABLE soldier ADD CONSTRAINT soldier_Fort_FK FOREIGN KEY
	(FortName)
	REFERENCES Fort
	(FortName)
	ON DELETE CASCADE;
	


