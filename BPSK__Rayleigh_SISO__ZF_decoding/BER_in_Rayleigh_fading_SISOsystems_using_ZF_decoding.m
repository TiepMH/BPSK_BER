%% Topics:
% MIMO systems
% Zero-forcing (ZF) equalization
% Bit error rate (BER)

%% Assumptions:
% nRx = 1 transmit antenna, nTx = 1 receive antenna
% Modulation scheme: BPSK
% Rayleigh fading channel

%% Simulation
snrdB_list = [-2:25]; % a list of SNRs in dB
nSim = 10^6;
BER_sim = zeros(1, length(snrdB_list));

for k = 1:length(snrdB_list)
    snrdB = snrdB_list(k);
    snr = 10^(snrdB/10);
    nErr = 0;
    for n = 1:nSim
        %Transmitter
        s = rand(1, 1) > 0.5; % sequence of 0-bits and 1-bits
        x = BPSK(s); % signal transmitted by Tx, x is a sequence of -1 and +1
        %Rayleigh fading channel
        h = (1/sqrt(2))*(randn(1) + 1i*randn(1));
        %Receiver
        n = (1/sqrt(2))*(randn(1) + 1i*randn(1)); % AWGN
        y = h*x + n/sqrt(snr); % signal received at Rx
        %% Zero-forcing (ZF)
        h_pseudo_inverse = ((h'*h)^-1) * h'; % using Moore-Penrose pseudo inverse
        xhat = h_pseudo_inverse*y; % estimates the transmitted signal
        shat = real(xhat) > 0; % estimates the transmitted symbol
        nonzero_indices = find(shat-s); % find() returns a list of indices that are nonzero
        if ~isempty(nonzero_indices) % if the list is NOT empty, there is a difference between s and shat
            nErr = nErr + 1; % number of nonzero elements = number of errors
        end
    end
    BER_sim(k) = nErr/nSim;
end

%% Theory
snr_list = 10.^(snrdB_list/10);
BER_theo = 0.5.*(1-sqrt(snr_list./(1+snr_list)));

%% Illustration
figure
semilogy(snrdB_list, BER_sim, 'r-o', 'LineWidth', 1);
hold on
semilogy(snrdB_list, BER_theo, 'b-', 'LineWidth', 2);
axis([-2 25, 10^-5 1])
grid on
legend('simulation', 'theory');
xlabel('snr (dB)');
ylabel('BER');
title('BPSK mod. & Rayleigh channel & SISO system & ZF decoding');