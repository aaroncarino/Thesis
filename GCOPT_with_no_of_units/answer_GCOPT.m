function ANSWER = answer_GCOPT(input_data1,input_data2)

aa          = size(input_data1,1);
Partial_mat = zeros(1,1);

for a=1:1:aa
    X_MW        = input_data1(a,1);
    Partial_mat = GET_X_MW2(X_MW,Partial_mat);
end

Partial_mat        = unique(Partial_mat);
qq                 = size(Partial_mat,1);
Answer_non_derated = zeros(qq,6);

for a=1:1:qq
    Answer_non_derated(a,1)=a;
end
Answer_non_derated = ans_loop(Answer_non_derated,Partial_mat,qq,2);
num_sum            = 0;
for a=1:1:aa
   prime=Get_prime2(Answer_non_derated,qq,input_data1,a);          
   for b=1:1:qq
   Answer_non_derated(b,4) = prime(b,2);
   end   
   Answer_non_derated      = ans_loop(Answer_non_derated,prime,qq,3);   
   num_sum                 = num_sum+input_data1(a,1);  
   primeXC                 = Get_primeXC(Answer_non_derated,qq,num_sum);
   Answer_non_derated      = ans_loop(Answer_non_derated,primeXC,qq,5);  
   Answer_PX               = Get_PX(Answer_non_derated,qq,input_data1,a); 
   Answer_non_derated      = ans_loop(Answer_non_derated,Answer_PX,qq,6); 
   Answer_non_derated(:,3) = Answer_non_derated(:,6);
end

%==========================================================================

%%DERATED 
derated_data=input_data2;
disp(derated_data);
if isempty(input_data2) == 0;
    
ss            = isnan(input_data2(:,1));
loc_zero      = find(ss==0);
loc_zero      = [loc_zero;size(input_data2(:,1),1)+1];
%disp(loc_zero);
loc_zero

no_of_units = input_data2(find(ss==0),2);
z=1;
for b=1:1:size(loc_zero,1)-1
    c=1;
    for a=loc_zero(b,1):1:loc_zero(b+1,1)-1
       % disp(a);
        mat_xx(c,z) = input_data2(a,3);
        mat_yy(c,z) = input_data2(a,4);
        c=c+1;  
    end
        while no_of_units(b,1)>1
            mat_xx(:,z+1)=mat_xx(:,z);
            mat_yy(:,z+1)=mat_yy(:,z);
            no_of_units=no_of_units-1;
            z=z+1;
        end    
    z=z+1;
end

%mat_xx
%mat_yy

Answer_derated = Answer_non_derated;
iter           = 1;

while iter<size(mat_xx,2)+1
aa2               = size(mat_xx(:,iter),1);
Partial_mat2      = [];
Partial_mat2(:,1) = Answer_derated(:,2);
Partial_mat3      = zeros(1,1);

for a=1:1:aa2
    X_MW2        = mat_xx(a,iter);
    Partial_mat4 = unique(GET_X_MW2(X_MW2,Partial_mat2));
    Partial_mat3 = unique([Partial_mat3(:,1);Partial_mat4]);
end

pp               = size(Partial_mat3,1);
Answer_mat       = zeros(pp,6);

for a=1:1:pp %%col 1:states
    Answer_mat(a,1)=a;
end

Answer_mat = ans_loop(Answer_mat,Partial_mat3,pp,2); %XMW

for b=1:1:pp %P'X
    if isempty(find(Answer_mat(b,2)==Answer_derated(:,2)))==0
        num             = find(Answer_mat(b,2)==Answer_derated(:,2));
        Answer_mat(b,3) = Answer_derated(num,6);
    end
end

max_ee=max(Answer_derated(:,2));
for b=1:1:pp
    if Answer_mat(b,3)==0 && Answer_mat(b,2)<max_ee   %no p' val inbetween states less than the max of the prev states                 
        r=1;
        for g=1:1:pp
            if Answer_mat(b,2)<Answer_mat(g,2)&&r==1&&Answer_mat(g,3)~=0
                Answer_mat(b,3) = Answer_mat(g,3);
                r=2;
            end
        end
    end
    Answer_mat(b,4)=Answer_mat(b,2)-max(mat_xx(:,iter));%X-C
end
%disp(Answer_mat);

primeXC2                 = Get_primeXC(Answer_mat,pp,Answer_mat(pp,2));
Answer_mat               = ans_loop(Answer_mat,primeXC2,pp,5);  
Derated_capacity_out_mat = mat_xx(:,iter);
hh                       = size(Derated_capacity_out_mat,1);
P_deratedXC              = zeros(pp,hh);

for a=1:1:hh
    for b=1:1:pp
        P_deratedXC(b,a) = Answer_mat(b,2)-Derated_capacity_out_mat(a,1);
    end
        Answer_mat(:,4)  = P_deratedXC(:,a);
        primeXC2         = Get_primeXC(Answer_mat,pp,Answer_mat(pp,2));
        Answer_mat       = ans_loop(Answer_mat,primeXC2,pp,5);  
        Par_derPX        = Get_derPX(Answer_mat,mat_yy(a,iter),pp);
        Answer_mat       = ans_loop(Answer_mat,Par_derPX,pp,6);
end
        Answer_derated=Answer_mat;
iter=iter+1;
end
        ANSWER=Answer_mat;

else
    ANSWER=Answer_non_derated;
end
end