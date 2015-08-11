
[filename, pathname] = uigetfile('*.wav','choose a file in which to be hide');        
[x,fs,nbits]=wavread([pathname filename]);

sound(x,fs)

y=((2^(nbits-1)*x(:,1))); %CONVERTING FROM ANALOG TO DIGITAL

for i=1:length(y)%cheking for negative data and storing sign in z
if y(i)>0
    z(i)=1;
else
    z(i)=0;
end
if y(i)<0
        y(i)=-1*y(i);
end
end
%convert decimal to binary
y=dec2bin(y);
z=dec2bin(z);

[filename, pathname] = uigetfile('*.wav','choose a file to be hidden');        
[x1,fs1,nbits1]=wavread([pathname filename]);

y1=((2^(nbits1-1)*x1(:,1))); %CONVERTING FROM ANALOG TO DIGITAL

for i1=1:length(y1)%cheking for negative data and storing sign in z1
if y1(i1)>0
    z1(i1)=1;
else
    z1(i1)=0;
end
if y1(i1)<0
        y1(i1)=-1*y1(i1);
end
end
%convert decimal to binary
y1=dec2bin(y1,16);
z1=dec2bin(z1,16);


message=[];
for v=1:size(y1,1)
    message=[message y1(v,:)];
end
str = dec2bin(length(message),16);

message1=[];
for v=1:size(z1,1)
    message1=[message1 z1(v,:)];
end

if 2*length(message)<length(y)
    
for a=1:length(str)
    y(a,nbits-1)=str(a);
end

b=1; 
for j=17:length(message)+16
 if b<length(message)+1 
    y(j,nbits-1)=message(b);
    b=b+1;
 end
end

b=1;

for j=16+length(message)+1:length(message1)+length(message)+16
 if b<length(message1)+1 
    y(j,nbits-1)=message1(b);
    b=b+1;
 end
end

%convert binary to decimal
z=bin2dec(z);
b=bin2dec(y);

for i=1:length(y)
    if z(i)==0
        b(i)=-1*b(i);
    end
end
a=b/(2^(nbits-1));

wavwrite(a,fs,nbits,'autohide.wav');

else
disp('error')
end


