function M = load_edb(tk,value)
 % tk = 'M0001385'
      w = windmatlab;% w.menu;
  
     [x,~,~,y,~,~]=w.edb(tk,'2000-01-01',datestr(today(),'yyyy-mm-dd'));
     M = array2table([y,x],'VariableNames',[{'DATEN'},value]);
     M(isnan(M.(value)),:) = [];

end