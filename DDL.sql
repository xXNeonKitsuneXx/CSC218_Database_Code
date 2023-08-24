create table prisoner (
    prisonerID int not null,
    firstname char(20),
    lastname char(30),
    dateOfBirth date,
    gender char(1),
    race char(20),

    primary key (prisonerID),
    check (gender in ('M', 'F'))
);

insert into prisoner values (111, 'Dylan', 'Yves', '2002-01-30', 'M', 'Asian');
insert into prisoner values (222, 'Nithit', 'Win', '2002-04-20', 'F', 'Asian'),
                            (333, 'Jack', 'Simpsom', '1990-07-12', 'M', 'Caucasian'),
                            (444, 'Ann', 'Newton', '1984-02-17', 'F', 'Arabian');

create table crime (
    crimeNo int not null,
    title char(30),
    category char(20),
    penalty varchar(100),
    primary key(crimeNo),
    check(category in ('Slaughter', 'Fraud', 'Terrerism', 'Assualt', 'Cyber'))
);

delete from crime where crimeNo = 1;
insert into crime values (1, 'First degree murder', 'Slaughter', 'Serve 5-30 years in prison');
insert into crime values (2, 'Second degree murder', 'Slaughter', 'Serve 5-30 years in prison');
insert into crime values (3, 'Money Scam', 'Fraud', 'Fine between 10000 and 100000000'),
                         (4, 'Charity fraud', 'Fraud', 'Fine between 1000 and 1000000');

select * from crime;

create table punishment(
    prisonerID int not null,
    crimeNo int not null,
    sentenceDate date not null,
    startPrisonDate date,
    endPrisonDate date,
    fineAmount numeric(11,2),
    primary key (prisonerID, crimeNo, sentenceDate),
    foreign key (prisonerID) references prisoner(prisonerID),
    foreign key (crimeNo) references crime(crimeNo),
    check (endPrisonDate > startPrisonDate),
    check (fineAmount between 1000 and 100000000)
);

insert into punishment values (111, 1, '2022-01-01', '2022-06-01', '2032-05-31', 2000.50);

--error on check of fineAmount
insert into punishment values (111, 2, '2022-01-01', '2022-06-01', '2032-05-31', 0);

insert into punishment values (111, 2, '2012-01-01', '2012-05-16', '2013-05-15', 1000);

--error on primary key
insert into punishment values (111, 2, '2012-01-01', '2012-05-16', '2013-05-15', 50000);

--error on foreign key that checks crimeNo record in the table crime
insert into punishment values (111, 25, '2015-01-01', '2012-05-16', '2013-05-15', 50000);

select * from punishment;

grant select on ST21865212.PRISONER to user KITTIPHOD;
grant select on ST21865212.CRIME to user KITTIPHOD;
grant select on ST21865212.PUNISHMENT to user KITTIPHOD;

