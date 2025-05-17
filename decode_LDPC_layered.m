function data_out = decode_LDPC_layered(data_in, num_of_bits, H_matrix, iter_num, ef)
    rx_mod = data_in;
    
    H_matrix = H_matrix == 1;
    
    L_matrix = H_matrix.*rx_mod;
    llr_vector = rx_mod;
    
    for iter = 1:iter_num
        for i = 1:ef:min(size(L_matrix))
            if(iter == 1) 
                L_matrix(i:(i+ef-1),:) = H_matrix(i:(i+ef-1),:).*llr_vector;
            else
                L_matrix(i:(i+ef-1), :) = (llr_vector - L_matrix(i:(i+ef-1), :)).*H_matrix(i:(i+ef-1),:);
                llr_vector = sum(L_matrix(i:(i+ef-1),:),1);
            end
            for j = i:(i+ef-1)
                L_matrix(j,H_matrix(j,:)) = row_op(L_matrix(j,H_matrix(j,:)));
            end
            
            llr_vector = llr_vector + sum(L_matrix(i:(i+ef-1),:),1);
        end   
    end
    
    res = (1-sign(llr_vector))/2;
    data_out = res(1:num_of_bits);
end