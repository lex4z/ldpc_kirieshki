clear
clc
close all

rx_mod = [-0.5, 0.3, -0.2, 0.4, 0.1, -0.6, -0.3];

H_matrix = [1 1 1 0 1 0 0;
0 1 1 1 0 1 0;
1 1 0 1 0 0 1;
1 0 1 0 1 1 1] == 1;

L_matrix = H_matrix.*rx_mod;

iter_num = 5;
for iter = 1:iter_num
    for i = 1:min(size(L_matrix))
        L_matrix(i,H_matrix(i,:)) = row_op(L_matrix(i,logical(H_matrix(i,:))));
    end

    llr_vector = rx_mod + sum(L_matrix,1);
    L_matrix = (llr_vector - L_matrix).*H_matrix;
end

