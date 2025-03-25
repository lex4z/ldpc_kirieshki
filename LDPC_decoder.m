function data_out = LDPC_decoder(data_in, num_of_bits, H_matrix, iter_num)
    rx_mod = data_in;
    
    H_matrix = H_matrix == 1;
    
    L_matrix = H_matrix.*rx_mod;

    for iter = 1:iter_num
        for i = 1:min(size(L_matrix))
            L_matrix(i,H_matrix(i,:)) = row_op(L_matrix(i,logical(H_matrix(i,:))));
        end
    
        llr_vector = rx_mod + sum(L_matrix,1);
        L_matrix = (llr_vector - L_matrix).*H_matrix;
    end
    
    res = (1-sign(llr_vector))/2;
    data_out = res(1:num_of_bits);
end