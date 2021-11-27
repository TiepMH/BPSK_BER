%% Topics
% Rayleigh fading MIMO systems
% Compare ZF equalizer to MMSE equalizer
% Bit error rate (BER)
% Modulation scheme: BPSK

%% Simulation
nTx = 2;
nRx = 2;
snrdB_list = [-2:25]; % a list of SNRs in dB
nSim = 10^6;
nBits = nTx*nSim; % nTx bits are sent by nTx antennas at the same time
BER_ZF_sim = zeros(1, length(snrdB_list));
BER_MMSE_sim = zeros(1, length(snrdB_list));

for k = 1:length(snrdB_list)
    snrdB = snrdB_list(k);
    snr = 10^(snrdB/10);
    nErr_ZF = 0;
    nErr_MMSE = 0;
    for n = 1:nSim
        %Transmitter
        s = rand(nTx, 1)>0.5; % sequence of 0 and 1 on all the nTx antennas
        x = BPSK(s); % signal transmitted by nTx antennas
        %Rayleigh fading MIMO channel
        H = (1/sqrt(2))*(randn(nRx, nTx) + 1i*randn(nRx, nTx));
        %Receiver
        n = (1/sqrt(2))*(randn(nRx, 1) + 1i*randn(nRx, 1)); % AWGN
        y = H*x + n/sqrt(snr); % signal received at Rx
        %% Zero-forcing (ZF)
        H_pseudo_inverse = ((H'*H)^-1) * H'; % using Moore-Penrose pseudo inverse
        xhat_ZF = H_pseudo_inverse*y; % estimates the transmitted signal
        shat_ZF = real(xhat_ZF) > 0; % estimates the transmitted symbol
        %% ZF: Counting errors
        num_NonZero_ZF = nnz(shat_ZF - s); % nnz() counts the number of nonzero elements
        nErr_ZF = nErr_ZF + num_NonZero_ZF; % the total number of incorrectly decoded bits
        %% Minimum Mean Squared Error (MMSE)
        positive_lambda = nTx/snr; % we can choose another positive value for possitive_lambda
        xhat_MMSE = (H'*(H*H' + positive_lambda*eye(nRx))^-1) * y; % estimates the transmitted signal
        shat_MMSE = real(xhat_MMSE) > 0; % estimates the transmitted symbol
        %% MMSE: Counting errors
        num_NonZero_MMSE = nnz(shat_MMSE - s); % nnz() counts the number of nonzero elements
        nErr_MMSE = nErr_MMSE + num_NonZero_MMSE; % the total number of incorrectly decoded bits
    end
    BER_ZF_sim(k) = nErr_ZF/nBits;
    BER_MMSE_sim(k) = nErr_MMSE/nBits;
end

%% Theory
snr_list = 10.^(snrdB_list/10);
BER_ZF_theo = (1/2).*(1-1./sqrt(1+1./snr_list)); 

%% Illustration
figure
semilogy(snrdB_list, BER_ZF_theo, 'k-', 'LineWidth', 1);
hold on
semilogy(snrdB_list, BER_ZF_sim, 'bo', 'LineWidth', 1);
semilogy(snrdB_list, BER_MMSE_sim, 'r*', 'LineWidth', 1);
axis([-2 25, 10^-5 1])
grid on
legend('theo. (ZF)', 'sim. (ZF)', 'sim. (MMSE)');
xlabel('snr (dB)');
ylabel('BER');
title('[Compare ZF to MMSE] BPSK & Rayleigh fading & 2x2 MIMO');