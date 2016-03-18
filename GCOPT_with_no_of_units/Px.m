function ans3=Px(mat)

for a=1:1:size(mat,1)
    if a<size(mat,1)
        part(a,1)=mat(a,6)-mat(a+1,6);
    elseif a==size(mat,1)
        part(a,1)=mat(a,6)-0;
    end
end

ans3=[mat,part];


end
