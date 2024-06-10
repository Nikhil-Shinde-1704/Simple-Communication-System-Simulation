% Communication System Simulation

% Parameters
numBits = 10000; % Number of bits to transmit
EbNo_dB = 0:2:10; % Eb/No values in dB to simulate
BER = zeros(size(EbNo_dB)); % Initialize BER array

% Loop over Eb/No values
for i = 1:length(EbNo_dB)
    % Generate random bits
    bitsTx = randi([0 1], numBits, 1);
    
    % BPSK modulation
    signalTx = 2 * bitsTx - 1; % Map 0 to -1 and 1 to 1
    
    % Additive White Gaussian Noise (AWGN)
    EbNo_lin = 10^(EbNo_dB(i)/10); % Convert dB to linear scale
    noisePower = 1 / (2 * EbNo_lin); % Noise power per bit
    noise = sqrt(noisePower) * randn(size(signalTx)); % Gaussian noise
    signalRx = signalTx + noise; % Received signal
    
    % BPSK demodulation
    bitsRx = signalRx > 0; % Decision: if received signal > 0, decode as 1, else 0
    
    % Calculate bit error rate (BER)
    BER(i) = sum(bitsRx ~= bitsTx) / numBits; % Count the number of bit errors
    
    % Display simulation progress
    fprintf('Eb/No = %ddB, Bit Error Rate = %f\n', EbNo_dB(i), BER(i));
end

% Plot BER curve
figure;
semilogy(EbNo_dB, BER, 'bo-');
grid on;
xlabel('Eb/No (dB)');
ylabel('Bit Error Rate');
title('Bit Error Rate vs. Eb/No for BPSK');
