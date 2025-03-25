function [decoder_out] = decoder_N1(data_in)
    decoder_out = ones(size(data_in))*sum(data_in);
end