%{

	EE 368 , Lab 18 Code 
	Fred Saucedo, Johnathan Peterson
%}

M = 31; % size of uniform window 
f_s = 8000; % value of sampling frequency
k =(M+1)/2; 

%--------------------------------------------------%
%{
	Initializng the unit sample response of our ideal 
	lowpass filter. 
%}

for n=1:M; 
    if (n)~=k; 
        h(n) =sin((pi/4)*(n-k))/(pi*(n-k)); 
    else
        h(n) = 1/4; 
    end
end 
%---------------------------------------------------%

%{
	Defining our unit sample response signal (unit_sample)
	to be it's transpose to ensure proper
	multiplication of matrix. Plotting the outuput 
	of the signal
%}
%---------------------------------------------------%
unit_sample = h'; 
figure(6); 
plot(unit_sample);  
%---------------------------------------------------%

%---------------------------------------------------%
%{
	Defining our uniform window of Size M and multiplying
	trasnpose unit sample signal with a unidorm window.
%}
%---------------------------------------------------%

window=rectwin(M); 

h1 = unit_sample.*window; 
figure(1); 
plot(h1) 

%--------------------------------------------------%
%{
	Defining hanning window with Size M and multiplying
	with unit sample reponse signal "unit_sample"
%}
%--------------------------------------------------%
han = hanning(M); 
h2 = unit_sample.*han; 

figure(2); 
plot(h2); 
% -------------------------------------------------%

%--------------------------------------------------%
%{
	Convolving h1 and h2 to obtain Lowpass FIR Filter. 
	Plotting the resulting filter. 
%}

h3 = conv(h1,h2); %
figure(3);
plot(h3); 

%---------------------------------------------------%
%{
	Finding the frequency reponse of our Lowpass FIR Filter
	ussing the Fast Forier Transform. Plotting the result in 
	figure 4. 

	Note the the magnitudeof the Frquency response is plotted
	in decibels. 
%}

h3_fft = fftshift(fftshift((fft(h3)))); 
f = f_s*(0:30)/61; 
figure(4); 

plot(f,20*log10(abs(h3_fft(1:M)))); %half of out filter
title('Frequency Response of Low Pass FIR Filter'); 
ylabel('Magnitude (db)'); 

%----------------------------------------------------%

%----------------------------------------------------%
%{
	Initializing a 500Hz sine  wave signal (x1)with an
	amplitude of 1 for a total time t = .02 secs 
	sampled at the same sampling rate of Fs = 8000Hz.
%}

total_time = 0.02; 

t = 0:1/f_s:total_time; 
x1=sin(500*2*pi*t); 

%----------------------------------------------------%
%----------------------------------------------------%
%{
	Passing 500Hz sine wave signal digital filter and 
	plotting the result in figure 5. 
%}

h4 = conv(h3,x1); 
figure(5); 
plot(h4); 
%-----------------------------------------------------%
%{
	Defining "x2" to be a sine wav of 1500 Hz sampled at 
	Fs = 8000 Hz for the same duration of t = .02 secs
%}

x2 = sin(1500*2*pi*t); 

%-----------------------------------------------------%
%{
	Passing "x2" 1500 Hz sine wave signal through our 
	Lowpass FIR filter and plotting the result in 
	figure 7. 
%}

h5 = conv(h3,x2); %1500 Hz passed through filter. 
figure(7); 
plot(h5); 

%----------------------------------------------------%


%{
	Reading in Wavefile to be passed through our Lowpass
	FIR filter. Convolving the wavefile with our filter 
	and saving the result in the specified file. 
%}

[x,f_s]=wavread('C:\Users\fred_2\Dropbox\Fall 2014\School\EE 368\Labs\Lab 18\cht5.wav'); 

y=conv(h3,x); 
wavwrite(y,f_s,'C:\Users\fred_2\Dropbox\Fall 2014\School\EE 368\Labs\Lab 18\cht6.wav'); 

%------------------------------------------------------%

        
    
    