%% Code for getting I and Q
samplesPerSec = 10e6;
sampleRate = 1/samplesPerSec;
f = 1*samplesPerSec';

% Create sine and cosine waves
N = int(samplesPerSec/2);
tstep = sampleRate;
ftbase = f*0:tstep:N;

imix0 = zeros(2, N);
imix0(1,:) = cos(2*pi*ftbase);
imix0(2,:) = sin(2*pi*ftbase);

hann = zeros(1, N);

for i = 1:N
    hann(i) = 0.5*(1-cos(2*pi*i/N));
end

imix0 = imix0.*hann;

qmix0 = zeros(2, N);
qmix0(1,:) = imix0(2,:).*(-1);
qmix0(2,:) = imix0(1,:);

imix = reshape(imix0,2*N,1);
qmix = reshape(qmix0,2*N,1);