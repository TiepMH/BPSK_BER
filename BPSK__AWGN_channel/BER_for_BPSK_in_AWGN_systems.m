%% Topics:
% MIMO systems
% Zero-forcing (ZF) equalization
% Bit error rate (BER)

%% Assumptions:
% 2 transmit antennas, 2 receive antennas
% Modulation scheme: BPSK

%% Simulation
snrdB_list = [-2:10]; % a list of SNRs in dB
n_bits = 10^6;

s = rand(1, n_bits) > 0.5; % sequence of 0-bits and 1-bits
x = BPSK(s); % signal transmitted by Tx, x is a sequence of -1 and +1
for k = 1:length(snrdB_list)
    snrdB = snrdB_list(k);
    snr = 10^(snrdB/10);
    n = (1/sqrt(2))*(randn(1, n_bits) + 1i*randn(1, n_bits)); % AWGN
    y = x + n/sqrt(snr); % signal received at Rx
    %% Hard-decision decoding
    shat = real(y) > 0; % recovers the original sequence
                        % -1 is converted into 0, while +1 is still +1
    nonzero_indices = find(s-shat); % find() returns a list of indices that are nonzero
    nErr(k) = size(nonzero_indices, 2); % number of nonzero elements = number of errors
end
BER_sim = nErr/n_bits;

%% Theory
BER_theo = 0.5*erfc(sqrt(10.^(snrdB_list/10)));

%% Illustration
figure
semilogy(snrdB_list, BER_theo, 'b-');
hold on
semilogy(snrdB_list, BER_sim, 'r-o');
axis([-2 10, 10^-5 1])
grid on
legend('theory', 'simulation');
xlabel('snr (dB)');
ylabel('BER');
title('BPSK mod. & AWGN channel');