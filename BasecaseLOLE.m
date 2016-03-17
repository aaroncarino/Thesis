function [LOLE] = solveLOLE(GCOPT,peakloaddata)
systemcap=450; 
reserve=zeros(12,1);
ans=zeros(12,1);
for i=1:12
    reserve(i,1)=systemcap-peakloaddata(i,2);
    for n=1:size(GCOPT,1)
        if reserve(i,1)== GCOPT(n,2)
            ans(i,1)=GCOPT(n,6);
            break;
        elseif reserve(i,1)<GCOPT(n,2)
            ans(i,1)=GCOPT(n,6);
            break;
        end
    end
end 
LOLE=sum(ans);
ans
end