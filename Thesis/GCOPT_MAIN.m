function GCOPT=GCOPT_MAIN
clc;clearvars; 
format long;

non_derated_data = input_data1;
derated_data     = input_data2;

%non_derated
aa          = size(non_derated_data,1);
Partial_mat = zeros(1,1);
for a=1:1:aa
    X_MW        = non_derated_data(a,1);
    no_of_units = non_derated_data(a,2);
    while no_of_units>=1
        Partial_mat = GET_X_MW2(X_MW,Partial_mat);
        no_of_units = no_of_units-1;
    end
end

Partial_mat        = unique(Partial_mat);
qq                 = size(Partial_mat,1);
Answer_non_derated = zeros(qq,6);

%No of states (non_derated)
for a=1:1:qq
    Answer_non_derated(a,1) = a;
end

Answer_non_derated = ans_loop(Answer_non_derated,Partial_mat,qq,2);
num_sum = 0;

for a = 1:1:aa
    no_of_units = non_derated_data(a,2);
    while no_of_units>=1
        prime = Get_prime2(Answer_non_derated,qq,non_derated_data,a);          
        for b=1:1:qq
            Answer_non_derated(b,4)=prime(b,2);
        end   
        Answer_non_derated     = ans_loop(Answer_non_derated,prime,qq,3);   
        num_sum                = num_sum + non_derated_data(a,1);  
        primeXC                = Get_primeXC(Answer_non_derated,qq,num_sum);
        Answer_non_derated     = ans_loop(Answer_non_derated,primeXC,qq,5);  
        Answer_PX              = Get_PX(Answer_non_derated,qq,non_derated_data,a); 
        Answer_non_derated     = ans_loop(Answer_non_derated,Answer_PX,qq,6); 
        Answer_non_derated(:,3)= Answer_non_derated(:,6);
        
        no_of_units=no_of_units-1;
    end
    
end

%%DERATED 
if isempty(derated_data)==0;
    
aa2               = size(derated_data,1);
Partial_mat2(:,1) = Answer_non_derated(:,2);
Partial_mat3      = zeros(1,1);

for a=1:1:aa2
    X_MW2         = derated_data(a,2);
    Partial_mat4  = unique(GET_X_MW2(X_MW2,Partial_mat2));
    Partial_mat3  = unique([Partial_mat3(:,1);Partial_mat4]);
end

pp         = size(Partial_mat3,1);
Answer_mat = zeros(pp,6);

for a=1:1:pp
    Answer_mat(a,1) = a;
end

Answer_mat = ans_loop(Answer_mat,Partial_mat3,pp,2); %XMW

for b=1:1:pp
    if isempty(find(Answer_mat(b,2)==Answer_non_derated(:,2)))==0
        num             = find(Answer_mat(b,2)==Answer_non_derated(:,2));
        Answer_mat(b,3) = Answer_non_derated(num,3);
    end
end

max_ee = max(Answer_non_derated(:,2));
for b=1:1:pp
    if Answer_mat(b,3)==0 && Answer_mat(b,2)<max_ee   %no p' val inbetween states less than the max of the prev states             
        r=1;
        for g=1:1:pp
            if Answer_mat(b,2)<Answer_mat(g,2)&&r==1
                Answer_mat(b,3) = Answer_mat(g,3);
                r               = 2;
            end
        end
    end
    Answer_mat(b,4) = Answer_mat(b,2)-derated_data(1,1); %X-C
end

primeXC2                 = Get_primeXC(Answer_mat,pp,Answer_mat(pp,2));
Answer_mat               = ans_loop(Answer_mat,primeXC2,pp,5);  
Derated_capacity_out_mat = derated_data(:,2);
hh                       = size(Derated_capacity_out_mat,1);
P_deratedXC              = zeros(pp,hh);
P_prime_deratedXC        = zeros(pp,hh);

for a=1:1:hh
    for b=1:1:pp
        P_deratedXC(b,a) = Answer_mat(b,2)-Derated_capacity_out_mat(a,1);
    end
        Answer_mat(:,4) = P_deratedXC(:,a);
        primeXC2        = Get_primeXC(Answer_mat,pp,Answer_mat(pp,2));
        Answer_mat      = ans_loop(Answer_mat,primeXC2,pp,5);  
        Par_derPX       = Get_derPX(Answer_mat,derated_data(a,3),pp);
        Answer_mat      = ans_loop(Answer_mat,Par_derPX,pp,6);
end
    Answer = Answer_mat;
else
    Answer = Answer_non_derated;
end

Answer_Table = array2table(Answer,...
    'VariableNames',{'STATE' 'X_MW' 'P_PRIME_X_MW' 'XC_MW' 'P_PRIME_XC' 'PX'});
 disp(Answer_Table);
 
GCOPT=Answer_Table;
end



