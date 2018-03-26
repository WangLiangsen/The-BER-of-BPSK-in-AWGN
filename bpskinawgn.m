%Simulation of bpsk in AWGN Channel
Max_SNR=18;
N_trials=1000;
N=1000;
Eb=1;
ber_m=0;
step = 0.5;

for trial=1:1:N_trials
	trial;
    msg = round(rand(1,N));	% 1,0 sequence
	s = 1-msg.*2; %BPSK modulation
	n = randn(1,N)+1i.*randn(1,N); %generate guass white noise

	ber_v = [ ];
	
	for snr_dB = 0:step:Max_SNR
		snr = 10.^(snr_dB./10); %snr(db)to snr(decimal)
		N0 = Eb./snr;
		sgma = sqrt(N0./2);

		y = sqrt(Eb).*s + sgma.*n;
		y1 = sign(real(y));
		y2 = (1-y1)./2; %demodulation

		error = sum(abs(msg-y2)); %error bits
		ber_snr = error./N; %ber
		ber_v = [ber_v,ber_snr];
    end  %for snr

	ber_m = ber_m + ber_v;
end

ber = ber_m./N_trials;

ber_theory=[];
for snr_db = 0:step:Max_SNR
	snr = 10.^(snr_db./10);
	snr_1 = qfunc(sqrt(2*snr));
	ber_theory = [ber_theory,snr_1];
end

i = 0:step:Max_SNR;
semilogy(i,ber,'-r',i,ber_theory,'*b');
xlabel('E_b/N_0(dB)')
ylabel('BER')
legend('MontcCarlo','Theoretic')

% figure %will be delete
% t=0:1:N-1; %will be delete
% plot(t,n) %will be delete