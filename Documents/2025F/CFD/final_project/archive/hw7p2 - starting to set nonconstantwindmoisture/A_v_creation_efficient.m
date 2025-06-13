function [A_v, b_v] = A_v_creation_efficient(u_guess, v_guess, p_guess, dx, dy, dt, Re, v_type, v_prevTime, A_v, grids, speeds, BC); 
       
[Ny_v, Nx_v] = size(v_guess);

%%Calculation of the velocity at the midpoints (nonlinear terms)
u_ne = [u_guess(:,2:end); zeros(1,Nx_v)];
u_se = [zeros(1,Nx_v); u_guess(:,2:end)];
u_nw = [u_guess(:,1:end-1); zeros(1,Nx_v)];
u_sw = [zeros(1,Nx_v); u_guess(:,1:end-1)];

v_P = v_guess;
v_N = [v_guess(2:end,:); zeros(1,Nx_v)];
v_S = [zeros(1,Nx_v); v_guess(1:end-1,:)];

ue = (u_ne+u_se)/2;
uw = (u_nw+u_sw)/2;
vn = (v_P+v_N)/2;
vs = (v_P+v_S)/2;


%%Calculate of pressure at the north and south midpoints
p_n = [zeros(1,Nx_v); p_guess(2:end,:); zeros(1,Nx_v)];
p_s = [zeros(1,Nx_v); p_guess(1:end-1,:); zeros(1,Nx_v)];

%%Coefficients for the A matrix
Fe_v = ue/2/dx; Fw_v = uw/2/dx; Fn_v = vn/2/dy; Fs_v = vs/2/dy;
De = 1/dx^2/Re; Dw = 1/dx^2/Re; Dn = 1/dy^2/Re; Ds = 1/dy^2/Re;

%%Create the b vector for the vertical velocity calculation
b_v = zeros(length(v_guess(:)),1);
A_v = sparse(Ny_v * Nx_v, Ny_v * Nx_v);

index=ones(1,4);    %%% indices for scrolling through nonuniform BC

%% Update Matrices by cell type
for i = 1:Ny_v*Nx_v


    %%Bottom/South Edge
    if v_type(i) == 4
        if BC.v_bot_type == "Dirichlet"
            A_v(i,i)      =  1;
            b_v(i) = BC.v_bot_value(index(2));
            index(2)=index(2)+1;
        end

 %%Top/North Edge
    elseif v_type(i) == 8
            A_v(i,i)      =  1;
            b_v(i) = BC.v_top_value(index(4));

    %%Left/West Edge
    elseif v_type(i) == 6
            A_v(i,i)      =  Fe_v(i)+Fn_v(i)-Fs_v(i)+De+2*Dw+Dn+Ds + 1/dt;        
            A_v(i,i+1)    =  Fn_v(i)-Dn;  
            A_v(i,i-1)    = -Fs_v(i)-Ds;               
            A_v(i,i+Ny_v) =  Fe_v(i)-De;
            b_v(i)        = -(p_n(i)-p_s(i))/dy + v_prevTime(i)/dt + 2*(Fw_v(i)+Dw)*speeds.v_lef;

    %%Right/East Edge
    elseif v_type(i) == 2
            A_v(i,i)      =  2*Fe_v(i)-Fw_v(i)+Fn_v(i)-Fs_v(i)+Dw+Dn+Ds + 1/dt;  
            A_v(i,i+1)    =  Fn_v(i)-Dn;  
            A_v(i,i-1)    = -Fs_v(i)-Ds;           
            A_v(i,i-Ny_v) = -Fw_v(i)-Dw;             
            b_v(i) = -(p_n(i)-p_s(i))/dy + v_prevTime(i)/dt+ 2*(Fe_v(i)+De)*speeds.v_rig;  
        
    %% If the cell has an west face on the obstruction
    elseif v_type(i) == 16
        A_v(i,i)      =  Fe_v(i)+Fn_v(i)-Fs_v(i)+De+2*Dw+Dn+Ds + 1/dt;
        A_v(i,i+1)    =  Fn_v(i)-Dn;  
        A_v(i,i-1)    = -Fs_v(i)-Ds; 
        A_v(i,i+Ny_v) =  Fe_v(i)-De;
        b_v(i) = -(p_n(i)-p_s(i))/dy + v_prevTime(i)/dt;    
   
    %%Obstruction Cells
    elseif v_type(i) == -1
        A_v(i,i) = 1;  
        b_v(i) = 0;      
          
    %%If the cell is in the domain
    else
        A_v(i,i)      =  Fe_v(i)-Fw_v(i)+Fn_v(i)-Fs_v(i)+De+Dw+Dn+Ds + 1/dt;        
        A_v(i,i+1)    =  Fn_v(i)-Dn;  
        A_v(i,i-1)    = -Fs_v(i)-Ds; 
        A_v(i,i-Ny_v) = -Fw_v(i)-Dw;             
        A_v(i,i+Ny_v) =  Fe_v(i)-De;
        b_v(i) = -(p_n(i)-p_s(i))/dy + v_prevTime(i)/dt;              
    end
end