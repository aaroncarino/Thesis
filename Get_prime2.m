function mat_prime=Get_prime2(mat,ss,mat2,zz)
    for a=1:1:ss
        if mat(a,3)==0 
            if mat(a,2)<=0 
                mat(a,3)=1;               
            else
            end
        else
        end
        mat_prime(a,1)=mat(a,3);
        mat_prime(a,2)=mat(a,2)-mat2(zz,1);
    end
end