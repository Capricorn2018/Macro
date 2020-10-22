clear;clc;

addpath('D:\Projects\x13tbx')
% addpath('D:\Projects\x13tbx\Rseasonal\matlab_R_api')
% addpath('D:\Projects\x13tbx\Rseasonal\matlab_X13')
% addpath('D:\Projects\x13tbx\demo\cnydemos')

x = readtable('D:\Projects\Macro\data\产量发电量当月同比.xlsx');
dt = [datenum(table2array(x(:,1))),table2array(x(:,2))];
tot_yrs = (year(dt(end,1)) - year(dt(1,1))+1 );
dtt = zeros(12*tot_yrs,2); 
for i  = 1 : tot_yrs
    y = year(dt(1,1)) + i -1 ;
    for  j = 1 :12
        m = j;
        idxy = year(dt(:,1)) == y;
        idxm = month(dt(:,1))== m;
        idx = and(idxy,idxm);
        if any(idx)
           dtt((i-1)*12+j,1) =  datenum(y,m,eomday(y,m)) ;
           dtt((i-1)*12+j,2) =  dt(idx,2);
        else 
           dtt((i-1)*12+j,1) = datenum(y,m,eomday(y,m)) ;
           dtt((i-1)*12+j,2) = NaN;
        end
    end
end

dttt = [zeros(size(dt,1),1),dt(:,2)];
for i  = 1 : size(dt,1)
    y = year(dt(i,1));
    m = month(dt(i,1));
    d = eomday(y,m);
    dttt(i,1) = datenum(y,m,d);
end

dtt(dtt(:,1)<dttt(1,1),:) = [];
dtt(dtt(:,1)>dttt(end,1),:) = [];

dtt(:,2) = 1 + dtt(:,2)/100;
% 
spec = makespec( 'TRAMO', 'AUTO', 'X11', 'SPECTRUM',...
     'regression', 'variables','(const td AO2005.Feb  TC2013.Jan TC2013.Feb)',...
     'regression','user','(Spring_Festval)',...
     'regression','file','D:\Projects\x13tbx\doc\X13docs\WinGenhol\holcny.dat', ....
     'regression','format','datevalue',...
     'regression','usertype','holiday',...
     'regression','centeruser','seasonal',...
     'series','period','12',...
     'AO','LS','TC','TD');
 
 
%  spec = makespec( 'TRAMO', 'AUTO', 'X11',...
%      'regression','user','(Spring_Festval)',...
%      'regression','file','D:\Projects\x13tbx\doc\X13docs\WinGenhol\holcny.dat', ....
%      'regression','format','datevalue',...
%      'regression','usertype','holiday',...
%      'regression','centeruser','seasonal',...
%      'series','period','12',...
%      'AO','LS','TC','TD');
t = x13(dtt, spec);
disp(t.table('regression'))



plot(dtt(:,1),dtt(:,2) );hold on;
plot(dtt(:,1),t.e2.e2,'r','LineWidth',2);
datetick('x','keeplimits')
legend('原始数据','季节性调整后数据')
legend('boxoff')
axis tight