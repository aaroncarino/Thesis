function answer_PX=Get_PX(mat,ss,mat2,zz)
    for a=1:1:ss
        mat(a,6)=(1-mat2(zz,3))*mat(a,3)+mat2(zz,3)*mat(a,5);
    end
    answer_PX=mat(:,6);
end