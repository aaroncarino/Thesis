function mat_T=Get_derPX(mat1,num,tt)
    for a=1:1:tt
        mat1(a,6)=mat1(a,6)+num*mat1(a,5);
        mat2(a,1)=mat1(a,6);
    end
        mat_T=mat2;
end
