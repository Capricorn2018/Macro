clear;clc;
addpath('D:\Projects\x13tbx')
addpath('D:\Projects\AAAUTILITY')
x = readtable('D:\Projects\Macro\data\M.xlsx');
%load_raw_data(x);

%%
%  tk = 'S0059749';
%   M = load_edb(tk,'VALUE');
%   save(['D:\Projects\Macro\data\raw\',tk,'.mat'],'M');
start_date = datenum(2004,12,1);
%%

M1 = cal_S0073290(start_date);
M2 = cal_M5206730(start_date);
M3 = cal_M0017129(start_date);
M4 = cal_S0027013(start_date);
M5 = cal_S0027908(start_date);
M6 = cal_S0027375(start_date);

M = M1(:,{'DATEN','Z'}); M.Properties.VariableNames(end) = {'Z1'};
M = outerjoin(M,M2(:,{'DATEN','Z'}),'MergeKeys',true);M.Properties.VariableNames(end) = {'Z2'};
M = outerjoin(M,M3(:,{'DATEN','Z'}),'MergeKeys',true);M.Properties.VariableNames(end) = {'Z3'};
M = outerjoin(M,M4(:,{'DATEN','Z'}),'MergeKeys',true);M.Properties.VariableNames(end) = {'Z4'};
M = outerjoin(M,M5(:,{'DATEN','Z'}),'MergeKeys',true);M.Properties.VariableNames(end) = {'Z5'};
M = outerjoin(M,M6(:,{'DATEN','Z'}),'MergeKeys',true);M.Properties.VariableNames(end) = {'Z6'};
M = adj_table_table(M);
M.CLI = mean([M.Z1,M.Z2,M.Z3,M.Z4,M.Z5,M.Z6],2);

CLI = M;
%%

load(['D:\Projects\Macro\data\raw\','S0059749','.mat'],'M');
d=   get_monthly_stats_from_ts(M,CLI.DATEN,'avg');
CLI.YIELD =d.VALUE;

plot(CLI.DATEN,CLI.CLI); hold on;
yyaxis right
plot(CLI.DATEN,CLI.YIELD); 
axis tight
datetick('x','yyyy','keeplimits');
legend('小胖经济领先指标','10年国债收益率')
legend('boxoff')