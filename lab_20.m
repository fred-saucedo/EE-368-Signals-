


clear; 
p = .980365; %value of pole 

%{
	Finding K so that the Filter has 
	a DC gain of 1; 

	Method for finding K: 

		H(w) = k Numerator(w)/Demoninator(w) ->
		K = H(w) Denominator(w)/Numerator(W) ->
%}

k=(1-sqrt(2)*p +p^2)/(2 -sqrt(2)); % Error here 
%--------------------------------------------------%

%{
	Initializing the numerator and denominator 
	coefficients. Note that this procedure builds 
	and array with the coefficient of the polynomial
	terms. 
%}

num = [1 -sqrt(2) 1 ]; 
den = [1 -sqrt(2)*p p^2]; 

%{
	setting the domain from which to plot the Transfer
	function. Initializng and defining the Transfer
	Function/ Notch Filter. 
	Freqz takes in the coefficient of the polynomials
	and perfroms calculations with z = exp(jw_not); 

	Defining the magnitude of H as a log scale. 

%}
w = 0:0.0025*pi:pi; 
H = k*freqz(num, den, w); 
magnitude = 20*log(abs(H)); 

%{
	Defining Figure 1 to contain two subplots,
	The plot of the Magnitude of the Notch Filter
	and the second plot is a magnified version of 
	the first plot. 

%}

figure(1); 

subplot(2,1,1); 
plot(w/pi , magnitude); grid; 
axis([0 1 -75 0]); 
title('Magnitude Plot'); 
xlabel('Digital Angular Frequency (rad/s)'); 
ylabel('Magnitude (db)'); 


subplot(2,1,2); 
plot(w/pi, magnitude); grid; 
axis([0.23 0.27 -3.5 -2.5]); 
title('Magnified Plot'); 
xlabel('Digital Angular Frequency (rad/s)'); 
ylabel('Magnitude (db)'); 
%-------------------------------------------------------%

%{
	Generating a sinusoid signal of 1 kHz with an amplitude of 
	0.2 with a time period (t_total) from 0 -> .05 secs. 
	The signal is sampled at a sampling rate Fs = 8000 kHz. 
%}

t_total = .05; 
Fs = 8000; 
t = 0:1/Fs:t_total; 
f_1= 1000; 

sig_1 = .02*sin(f_1*2*pi*t); 

%{
	Generating a sinusoid signal of 100 Hz with an amplitude of 
	1 with a time period (t_total) from 0 -> .05 secs. 
	The signal is sampled at a sampling rate Fs = 8000 kHz. 
%}

f_2 = 100; 
sig_2 = sin(f_2*2*pi*t); 

%{
	Sum sig_1 and sig_2 and assign the summation of both to a 
	new signal sig_sum; 

	Pass the signal sig_sum through the digital filter by the convolution
	methond and assign the output to signal_output; 

	Plot both the signal sig_sum and it's output (output_signal)' and compare 
	both plots. 

	Taking the inverser Frequency response of H to obtain the unit sample
	response h_n. h_n is desirable in order to convolute with input signal. 

	Note that h_n is the unit sample response of our ditigal Notch 
	filter in discrete time. 
%}


sig_sum = sig_1 + sig_2 ; 

[a,b] = invfreqz(H,w,2,2); 
h_n = a/b; 

output_signal = conv(h_n, sig_sum);  

figure(2); 
plot(t,sig_sum);
title('Input Signal'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude'); 


figure(3); 
plot(t,output_signal);  
title('Plot of Output Signal'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude'); 

%------------------------------------------------------%

%{
	Reading in Wavefile to be passed through our Notch
	IIR filter. Convolving the wavefile with our filter  
	and saving the result in the specified file. 
	
%}

[x,Fs]=wavread('C:\Users\fred_2\Dropbox\Fall 2014\School\EE 368\Labs\Lab 20\cht5.wav'); 

y=conv(h_n,x); 
wavwrite(y,Fs,'C:\Users\fred_2\Dropbox\Fall 2014\School\EE 368\Labs\Lab 20\cht6.wav'); 

%------------------------------------------------------%


%{
	If the sampling rate is reduced to 4 kHz, find the new transfer function H(z) (you can leave
in H(z) as an undetermined parameter. 

%--------------------------------------------------------%

		Fs = 4 kHz
		F = 1 kHz 

		wo = 2*pi/4 = pi/2; 

		numerator  = 1-2cos(pi/2)z^-1 + z^-2; 

		denominator = 1-2pcos(pi/2)z^-1 + (p^2)z^-2 ; 

		H(z) = numerator/denominator  = (1-2cos(pi/2)z^-1 + z^-2 )/ (1-2pcos(pi/2)z^-1 + (p^2)z^-2)

%}