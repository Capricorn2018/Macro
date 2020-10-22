function  dtt = get_monthly_table(z)

    dt = [datenum(table2array(z(:,1))),table2array(z(:,2))];
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

end