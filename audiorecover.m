
[filename, pathname] = uigetfile('*.wav','choose the autohidden file');        
[m,fs,nbits]=wavread([pathname filename]);

wavplay(m,fs);

%convert analog to digital

y=((2^(nbits-1)*m(:,1)));   


y=abs(y);
%convert decimal to binary
y=dec2bin(y,16);

  for h=1:16
      k(h)=y(h,nbits);
      
  end
 %convert binary to decimal
  b=bin2dec(k);



 c=1;
 j=17;
 while (j<=b+16)
     for j1=1:16
         msg(c,j1)=y(j,nbits);
         j=j+1;
     end
     c=c+1;
 end
 %convert binary to decimal
  g=bin2dec(msg);
 

 
 c=1;
 j=b+16+1;
 while (j<=b+b+16)
     for j1=1:16
         msg1(c,j1)=y(j,nbits);
         j=j+1;
     end
     c=c+1;
 end
 %convert binary to decimal
 z1=bin2dec(msg1);
 
 
 for i=1:length(msg)
    if z1(i)==1
        g(i)=-1*g(i);
    end
 end
 %convert digital to analog
a=g/(2^(nbits-1));


wavwrite(a,fs,nbits,'hidden.wav');%writing wav file