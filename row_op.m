function data_out = row_op(data_in)
    data_signs = sign(data_in);
    abs_data_in = abs(data_in);
    [data_min1,data_min1_pos] = min(abs_data_in);
    abs_data_in(data_min1_pos) = max(abs_data_in);

    data_min2 = min(abs_data_in);
    abs_data_in(data_min1_pos) = data_min1;
    
    ext_abs = data_min1*ones(1,length(data_in));
    ext_abs(data_min1_pos) = data_min2;
    
    s = prod(data_signs);
    if(s > 0)
        ext_signs = data_signs;
    else
        ext_signs = -data_signs;
    end
    
    data_out = ext_abs.*ext_signs;
end