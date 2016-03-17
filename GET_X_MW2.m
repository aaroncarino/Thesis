function matrix_data=GET_X_MW2(a_val,mat_b)
    q=size(mat_b,1);   
    X_mw_part=mat_b;
    part_mat=[];
    for a=1:1:q
        part_mat(a,1)=a_val+X_mw_part(a,1);
    end
    X_mw_part=[X_mw_part;part_mat];
    matrix_data=X_mw_part;
end
