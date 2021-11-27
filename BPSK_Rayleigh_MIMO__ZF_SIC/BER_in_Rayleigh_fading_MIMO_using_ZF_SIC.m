%% Topics
% Rayleigh fading MIMO systems
% Compare ZF equalizer to MMSE equalizer
% Bit error rate (BER)
% Modulation scheme: BPSK

%% Simulation
nTx = 2;
nRx = 2;
snrdB_list = [-2:25]; % a list of SNRs in dB
nSim = 10^5;
nBits = nTx*nSim; % nTx bits are sent by nTx antennas at the same time
BER_ZF_sim = zeros(1, length(snrdB_list));

for k = 1:length(snrdB_list)
    snrdB = snrdB_list(k);
    snr = 10^(snrdB/10);
    nErr_ZF = 0;
    for loop = 1:nSim
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
        %% Successive Interference Cancellation (SIC)
        x2hat = xhat_ZF(2);
        % 
        r = H(:,1)*x(1) + n/sqrt(snr);
        x1hat = (H(:,1)'*r) / (H(:,1)'*H(:,1));
        % Counting errors
        s1hat = shat_ZF(1);
        s1 = s(1);
        num_NonZero_ZF = nnz(s1hat - s1); % nnz() counts the number of nonzero elements
        nErr_ZF = nErr_ZF + num_NonZero_ZF; % the total number of incorrectly decoded bits
    end
    BER_ZF_sim(k) = nErr_ZF/nBits;
end

%% Theory
snr_list = 10.^(snrdB_list/10);
BER_ZF_theo = (1/2).*(1-1./sqrt(1+1./snr_list)); 

%% Illustration
figure
semilogy(snrdB_list, BER_ZF_theo, 'k-', 'LineWidth', 1);
hold on
semilogy(snrdB_list, BER_ZF_sim, 'bo', 'LineWidth', 1);
%semilogy(snrdB_list, BER_MMSE_sim, 'r*', 'LineWidth', 1);
axis([-2 25, 10^-5 1])
grid on
legend('theo. (ZF)', 'sim. (ZF + SIC)');
xlabel('snr (dB)');
ylabel('BER');
title('[Compare ZF to MMSE] BPSK & Rayleigh fading & 2x2 MIMO');