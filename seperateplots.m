clc
clear variables

buckets=30;
out=1000000;
dat1=readmatrix("totalr.xlsx");
dat2=readmatrix("Totalc.xlsx");
dat3=readmatrix("totall.xlsx");
dat4=readmatrix("totalf.xlsx");
dat5=readmatrix("totalb.xlsx");
dia1=dat1(:,8);
dia2=dat2(:,8);
dia3=dat3(:,7)*10^(9);
dia4=dat4(:,7)*10^(9);
dia5=dat5(:,7)*10^(9);
[r1,~]=size(dia1);
[r2,~]=size(dia2);
[r3,~]=size(dia3);
[r4,~]=size(dia4);
[r5,~]=size(dia5);

count=1;
for i=1:r1
    if dia1(count)<out
        dia1f(count)=dia1(count);
    end
    count=count+1;
end
count=1;
for i=1:r2
    if dia2(count)<out
        dia2f(count)=dia2(count);
    end
    count=count+1;
end
count=1;
for i=1:r3
    if dia3(count)<out
        dia3f(count)=dia3(count);
    end
    count=count+1;
end
count=1;
for i=1:r4
    if dia4(count)<out
        dia4f(count)=dia4(count);
    end
    count=count+1;
end
count=1;
for i=1:r5
    if dia5(count)<out
        dia5f(count)=dia5(count);
    end
    count=count+1;
end


dia1f=tau_thompson_test(dia1f,0.01);
dia2f=tau_thompson_test(dia2f,0.01);
dia3f=tau_thompson_test(dia3f,0.01);
dia4f=tau_thompson_test(dia4f,0.01);
dia5f=tau_thompson_test(dia5f,0.01);



figure;
t = tiledlayout(3, 2, 'TileSpacing', 'compact'); % 3 rows, 2 columns
title(t,'Histograms of each location on the Wafer');

nexttile
histogram(dia1f,buckets)
title("Right side Histogram")
ax1=gca;
nexttile
histogram(dia2f,buckets)
title("Center Histogram")
ax2=gca;
nexttile
histogram(dia3f,buckets)
title("Left side Histogram")
ax3=gca;
nexttile
histogram(dia4f,buckets)
title("Top side Histogram")
ax4=gca;
nexttile
histogram(dia5f,buckets)
title("Bottom side Histogram")
ax5=gca;
linkaxes([ax1,ax2,ax3,ax4,ax5],'xy')
m1=mean(dia1f);
m2=mean(dia2f);
m3=mean(dia3f);
m4=mean(dia4f);
m5=mean(dia5f);
std1=standard_deviation(dia1f);
std2=standard_deviation(dia2f);
std3=standard_deviation(dia3f);
std4=standard_deviation(dia4f);
std5=standard_deviation(dia5f);
