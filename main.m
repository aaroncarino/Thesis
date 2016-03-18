clc 
clear
compLOLE=[];
[peakloaddata]=Peakloadinput;
[input1]=input_data1;
[input2]=input_data2;
for i=1:size(input1,1)
    testnonderated=input1;
    testnonderated(i,2)=testnonderated(i,2)-1;
    GCOPT=table2array(GCOPT_MAIN(testnonderated,input2));
    [LOLE] = solveLOLE(GCOPT,peakloaddata);
    compLOLE(i,1)=LOLE;
end
num=0;
c=size(compLOLE,1);
TF=isnan(input2);
for i=1:size(input2,1)
    if TF(i,1)==0
        num=num+1;
    else
    end
end
disp(TF);
inc1=0;
inc2=1;
for x=1:size(input2,1)
    if x==1
    else
        if TF(x,1)==1
        inc1=inc1+1;
            if x==size(input2,1)
                delete(inc2,1)=inc1;
            else
            end
        else
        delete(inc2,1)=inc1;
        inc1=0;
        inc2=inc2+1;
        end
    end
end
inc3=1;
for i=1:size(delete,1)
    sum=0;
    testderated=input2;
   if i==1
       for j=1:delete(i,1)+1
       testderated(i,:)=[];
       end
   else
       for k=1:i-1
       sum=sum+delete(k,1);
       end
       for j=1:delete(i,1)+1
       testderated(sum+i,:)=[];
       end
   end
       GCOPT=table2array(GCOPT_MAIN(input1,testderated));
       [LOLE] = solveLOLE(GCOPT,peakloaddata);
       compLOLE(i+c,1)=LOLE;
end
GCOPT=table2array(GCOPT_MAIN(input1,input2));
[LOLE]=BasecaseLOLE(GCOPT,peakloaddata);
compLOLE
for i=1:size(compLOLE,1)
    ans(i,2)=i;
    ans(i,3)=compLOLE(i,1);
end
ranklist=sortrows(ans,-3);
for i=1:size(ranklist,1)
    ranklist(i,1)=i;
end
fprintf('   Rank of Importance    Generator No.   Component Absence LOLE\n');
disp(ranklist);


