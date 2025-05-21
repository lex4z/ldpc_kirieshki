function data_out = decode_LDPC_layered(data_in, num_of_bits, H_matrix, iter_num, ef)
    llr_vector = data_in; 
    H_matrix = H_matrix == 1;
    L_matrix = zeros(size(H_matrix));


    for iter = 1:iter_num
        for i = 1:ef:size(H_matrix,1)
            rows = i:(i+ef-1);
            if(iter == 1) 
                L_matrix(rows,:) = H_matrix(rows,:).*llr_vector;
            else
                L_matrix(rows, :) = (llr_vector - L_matrix(rows, :)).*H_matrix(rows,:);
                H_not_0 = sum(H_matrix(rows,:),1) == 1;
                llr_vector(H_not_0) = sum(L_matrix(rows,H_not_0),1);
            end

            for j = i:(i+ef-1)
                L_matrix(j,H_matrix(j,:)) = row_op(L_matrix(j,H_matrix(j,:)));
            end

            llr_vector = llr_vector + sum(L_matrix(rows,:),1);
        end   
    end

    res = (1-sign(llr_vector))/2;
    data_out = res(1:num_of_bits);
end