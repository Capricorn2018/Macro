function  M = cal_M5206730(start_date)


  % {'社会融资规模（当月值）','金融','月','M5206730','','人民银行'}

    load(['D:\Projects\Macro\data\raw\','M5206730','.mat'],'M');
    M = M(M.DATEN>=start_date,:);
    dtt = get_monthly_table(M);


   % dtt(:,2) = 1 + dtt(:,2)/100;
   % dtt(:,2) = adj_table(dtt(:,2));

    spec = makespec( 'TRAMO', 'AUTO', 'X11', 'SPECTRUM',...
     'regression', 'variables','(const td TC2020.Mar)',...
     'series','period','12',...
     'AO','LS','TC','TD');
    t = x13(dtt, spec);
  %  disp(t.table('regression'))



    h = hpfilter(t.e2.e2,100);
    M = table;
    M.DATEN = dtt(:,1);
    M.V = dtt(:,2);
    M.S = t.e2.e2;
    M.H = hpfilter(t.e2.e2,100);
    M.Z = cal_zscore(M.H,repmat(1/height(M),height(M),1));



%     plot(dtt(:,1),dtt(:,2) );hold on;
%     plot(dtt(:,1),t.e2.e2,'r','LineWidth',2);hold on;
%     plot(dtt(:,1),h,'LineWidth',2);
%     datetick('x','keeplimits')
%     legend('原始数据','季节性调整后数据','HP滤波后')
%     legend('boxoff')
%     axis tight

end