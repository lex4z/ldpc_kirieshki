%%
% input data
num_frames = 100;

P = [16 17 22 24  9  3 14 -1  4  2  7 -1 26 -1  2 -1 21 -1  1  0 -1 -1 -1 -1
     25 12 12  3  3 26  6 21 -1 15 22 -1 15 -1  4 -1 -1 16 -1  0  0 -1 -1 -1
     25 18 26 16 22 23  9 -1  0 -1  4 -1  4 -1  8 23 11 -1 -1 -1  0  0 -1 -1
      9  7  0  1 17 -1 -1  7  3 -1  3 23 -1 16 -1 -1 21 -1  0 -1 -1  0  0 -1
     24  5 26  7  1 -1 -1 15 24 15 -1  8 -1 13 -1 13 -1 11 -1 -1 -1 -1  0  0
      2  2 19 14 24  1 15 19 -1 21 -1  2 -1 24 -1  3 -1  2  1 -1 -1 -1 -1  0];
block_size = 27;
pcmatrix = ldpcQuasiCyclicMatrix(block_size,P);
cfg_ldpc_enc = ldpcEncoderConfig(pcmatrix);
num_info_bits = cfg_ldpc_enc.NumInformationBits;
block_length = cfg_ldpc_enc.BlockLength;

% encoding
info_bits = randi([0 1], num_info_bits*num_frames, 1);
for f = 1:num_frames
    codewords((f-1)*block_length+1:f*block_length) = ldpcEncode(info_bits((f-1)*num_info_bits+1:f*num_info_bits), cfg_ldpc_enc);
end

%%
for i=1:min(size(pcmatrix))
  for j=1:max(size(pcmatrix))
      if pcmatrix(i,j) == true
         t(i,j)=1;
      else
          t(i,j)=0;
      end
   end
end