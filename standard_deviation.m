function [std]=standard_deviation(data)
    m=mean(data);
    [s,~]=size(data);
    d1=data-m;
    d2=d1.^2;
    d3=sum(d2);
    d4=d3/s;
    std=sqrt(d4);
end

