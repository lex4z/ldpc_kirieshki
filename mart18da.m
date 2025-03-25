clc
clear
close all

K = 1e6;
info = randi([0 1],1,K);

%reshape(t,3,length(t)/3)

EbN0_dB = -4:1:10;
EbN0 = 10.^(EbN0_dB./10);
Pb = 1;
noise_var = sqrt(Pb./(2.*EbN0));

tx_sig = info*(-2)+1;
rx_sig = zeros(length(noise_var), K);
for i = 1:length(noise_var)
    rx_sig(i,:) = tx_sig + noise_var(i)*randn(size(tx_sig));
end
%rx_sig = tx_sig + noise_var*randn(size(tx_sig));
rx_info = (1-sign(rx_sig))/2;

%rx_info = zeros(size(tx_sig));
%rx_info(rx_sig<0) = 1;

t = info-rx_info;
error_cnt = zeros(1,length(noise_var));
for i = 1:length(noise_var)
    error_cnt(i) = sum(t(i,:)~=0);
end

error_p = error_cnt/K;

%% график
figure
semilogy(EbN0_dB,error_p)
grid on
xlim([min(EbN0_dB) max(EbN0_dB)])
ylim([1e-5 1])
ylabel("BER")


%histogram(info)