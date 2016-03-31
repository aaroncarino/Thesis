clc
clear
format short G
filename='input.xlsx';
fprintf('PLEASE WAIT WHILE THE CODE IS READING INPUT DATA\n\n');
data12=xlsread(filename,'Non Derated Generators'); %%DECLARE INITIAL VALUES AND MATRICES
check=isempty(data12);
error=0;
if check==1 
    nndgen=0;
else
    rowcount=max(data12(:,1));
    data12=data12(~isnan(data12));
    
    if size(data12,1)==(rowcount*3)
    else
        error=error+1;
        fprintf('\nERROR %i: There is a missing element/s in NON DERATED STATES input!!\n',error);
        minus=(rowcount*3)-size(data12,1);
        for i=1:minus
        minusmatrix(i,1)=0;
        end
        data12=[data12;minusmatrix];    
    end
        a=1;
        for i=1:3
            for j=1:rowcount
                data1(j,i)=data12(a,1);
             a=a+1;
            end
        end
    
    datasize1=size(data1);
    Gnum=datasize1(1,1); %%COMBINATIONS FOR NON DERATED GENERATORS
    nndgen=max(Gnum);
    capacity=data1(:,2);
    FOR=data1(:,3);
    capacitysize=size(capacity);
    ncap=capacitysize(1,1);
    col=(ncap);
    row=2^(ncap);
    div=row/2;
    table=zeros(row,col);
    for i=1:col                       
    j=1;
    counter=0;
        while counter<row
            counter1=0;
            counter2=0;
            while counter1<(div);
                table(j,i)=0;
                counter=counter+1;
                counter1=counter1+1;
                j=j+1;
            end
            while counter2<(div)   
                table(j,i)=capacity(i);
                counter=counter+1;
                counter2=counter2+1;
                j=j+1;
            end
        end
    div=div/2;
    states=zeros(row,1);
    gcopt=[];
    for i=1:row
    states(i,1)=sum(table(i,:));
    end
    end
%     table
%     states
    x=1;
    for z=1:size(table,1)
    zero=0;
        for y=1:Gnum
            if table(x,y)==0
                zero=zero+1;
            else
            end    
        end
        if zero>3
           table(x,:)=[];
           states(x,:)=[];
        else 
           x=x+1;
        end       
    end
%     table
%     states
    for i=1:size(table,1)
        a=3;
        for j=1:Gnum
             if table(i,j)==0;
                 gcopt(i,a)=j;
                 a=a+1;
             else
             end
        end
    end
%     gcopt
    
%%START ITERATION FOR GCOPT
if nndgen~=0
%SOLVING FOR NON DERATED STATES GCOPT
for i=1:size(table,1)
    prob=1;
    for j=1:Gnum
        if table(i,j)~=0
            prob=prob*(1-FOR(j,1));   
        else
            prob=prob*FOR(j,1);
        end
    end
    states(i,2)=prob;   
end
maxcap=0;
for i=1:Gnum
    maxcap=maxcap+data1(i,2);
end
    for i=1:size(table,1)
        gcopt(i,1)=states(i,1);
        gcopt(i,2)=states(i,2);
    end
end
for i=1:size(gcopt,1)
    gcopt(i,1)=maxcap-gcopt(i,1);
end
end
gcopt=sortrows(gcopt);
fprintf('\n       OUTAGE(MW) INDIVIDUAL                   GENERATORS');
fprintf('\n                 PROBABILITY                      OUT\n\n');
      disp(gcopt);
