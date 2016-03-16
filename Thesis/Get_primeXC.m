function mat_primeXC=Get_primeXC(mat,ss,ee)
    %disp(ee);
    %disp(mat);
    for a=1:1:ss
        if mat(a,4)<=0
            mat(a,5)=1;
        elseif mat(a,4)>0 
            if isempty(find(mat(:,2)==mat(a,4)))==0
                 b=find(mat(:,2)==mat(a,4));
                 %disp(b);
                 mat(a,5)=mat(b,3);
            elseif isempty(find(mat(:,2)==mat(a,4)))==1 && mat(a,2)<ee                
                r=1;
                for g=1:1:ss
                    if mat(a,4)<mat(g,2)&&r==1
                        mat(a,5)=mat(g,3);
                        r=2;
                    end
                end
            end
        end
    mat_primeXC(a,1)=mat(a,5);
    end
       

    %disp( mat_primeXC);
    %disp(mat(:,5));
end