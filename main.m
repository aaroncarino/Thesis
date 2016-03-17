clc 
clear
compLOLE=[];
[peakloaddata]=Peakloadinput;
peakloaddata
for i=1:size(input_data1,1)
    testnonderated=input_data1;
    testnonderated(i,2)=testnonderated(i,2)-1;
    GCOPT=table2array(GCOPT_MAIN(testnonderated,input_data2));
    [LOLE] = solveLOLE(GCOPT,peakloaddata);
    compLOLE(i,1)=LOLE;
end
num=0;
c=size(compLOLE,1);
TF=isnan(input_data2);
for i=1:size(input_data2,1)
    if TF(i,1)==0
        num=num+1;
    else
    end
end
size(input_data2)
input_data2(4,3)
for i=1:num
    x=0;
    num1=1;
    for a=1:size(input_data2,1)
        if x~=1
            x=x+input_data2(a,3);
        else
            num2=a
        end
    end

    GCOPT=table2array(GCOPT_MAIN(input_data1,testderated));
    [LOLE] = solveLOLE(GCOPT,peakloaddata);
    compLOLE(i+c,1)=LOLE;
end
GCOPT=table2array(GCOPT_MAIN(input_data1,input_data2));
[LOLE]=BasecaseLOLE(GCOPT,peakloaddata);
LOLE
compLOLE
