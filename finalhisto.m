clc
clear variables
%t=true;
%tau=1.9586;
dat=readmatrix("totalr.xlsx");
dat1=readmatrix("Totalc.xlsx");
dat2=readmatrix("totall.xlsx");
dat3=readmatrix("totalf.xlsx");
dat4=readmatrix("totalb.xlsx");
dia=dat(:,8);
dia1=dat1(:,8);
dia2=dat2(:,7)*10^(9);
dia3=dat3(:,7)*10^(9);
dia4=dat4(:,7)*10^(9);
diaf=[dia;dia1;dia2;dia3;dia4];
[s,~]=size(diaf);

count=1;
for i=1:s
    if diaf(i)<100
        diaf2(count,1)=diaf(i);
        count=count+1;
    end
end

%% tau thompson test
diaf3=tau_thompson_test(diaf,0.01);


histogram(diaf2,60)
figure
histogram(diaf3,60)
title("Histogram of the Diameter the Imaged Carbon Nano Tubes.")
ylabel("Number of Carbon Nanotubes")
xlabel("Diameter (nm)")
m=mean(diaf3);
std=standard_deviation(diaf3);
fprintf("mean = %f\n sigma = %f\n",m,std)