clear
clc

%% Import Schedule CSV
pathRaw = "MoonRanger Schedule - Costs.csv";
pathHeader = "MoonRanger Schedule Header.csv";
csvRunner = FormattedCsv(pathRaw, pathHeader);
csvRunner.rawSkipRows = 1;
raw.csv = csvRunner.run();
[raw.sched, raw.check] = ScheduleTable(raw.csv).run;

%% Create Schedule
[Tasks, checked, Sched] = Schedule(raw.sched).run;
disp(Sched.tbl)

%% Check Costs
mthly = Sched.monthlyCosts();
