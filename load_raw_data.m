function load_raw_data(x)


x(~strcmp(x.Update,''),:) = [];
for i  = 1 : height(x)
    M = load_edb(x.ID{i},'VALUE');
    save(['D:\Projects\Macro\data\raw\',x.ID{i},'.mat'],'M');
end

end