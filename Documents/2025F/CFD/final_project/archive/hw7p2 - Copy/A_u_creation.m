function [A_u, b_u] = A_u_creation(u_guess, v_guess, p_guess, dx, dy, dt, Re, u_type, u_prevTime,  A_u, grids, speeds);

[Ny_u, Nx_u] = size(u_guess);

u_P = u_guess;
u_E = [u_guess(:,2:end) zeros(Ny_u,1)];
u_W = [zeros(Ny_u,1) u_guess(:,1:end-1)];

v_ne = [v_guess(2:end,:) zeros(Ny_u,1)];
v_nw = [zeros(Ny_u,1) v_guess(2:end,:)];
v_se = [v_guess(1:end-1,:) zeros(Ny_u,1)];
v_sw = [zeros(Ny_u,1) v_guess(1:end-1,:)];

%%Calculation of the velocity at the midpoints (nonlinear terms)
ue = (u_P + u_E)/2;
uw = (u_P + u_W)/2;
vn = (v_ne + v_nw)/2;
vs = (v_se + v_sw)/2;

%%Calculate the pressures at the east and west midpoint
p_e = [p_guess zeros(Ny_u,1)];
p_w = [zeros(Ny_u,1) p_guess];

%%Coefficients for the A matrix
Fe_u = ue/2/dx; Fw_u = uw/2/dx; Fn_u = vn/2/dy; Fs_u = vs/2/dy;
De = 1/dx^2/Re; Dw = 1/dx^2/Re; Dn = 1/dy^2/Re; Ds = 1/dy^2/Re;        

%%Create the b vector
b_u = zeros(length(u_guess(:)),1);

for i = 1:length(u_type(:))
    %%If the cell is ON the right boundary
    if u_type(i) == 1            
        % Nuemann
        A_u(i,i) = 1;  
        A_u(i,i-Ny_u) = -1;
        b_u(i) = 0;

    %%If the cell is ON the left boundary at the bottom
    elseif u_type(i) == 2
        %%sinusoidal dirichlet
        A_u(i,i) = 1;
        b_u(i) = cos(2*pi*grids.y_u(i));           

    %%If the cell is Neighboring the bottom boundary 
    elseif u_type(i) == 3
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+Fn_u(i)-Fs_u(i)+De+Dw+Dn+2*Ds;      
        A_u(i,i-Ny_u) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;    
        A_u(i,i+1)    =  Fn_u(i)-Dn;            
        b_u(i)        = -(p_e(i)-p_w(i))/dx + 2*speeds.u_bot*Ds;

    %%If the cell is Neighboring the top boundary
    elseif u_type(i) == 4
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+2*Fn_u(i)-Fs_u(i)+De+Dw+Ds;      
        A_u(i,i-Ny_u) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;                 
        A_u(i,i-1)    = -Fs_u(i)-Ds;      
        b_u(i)        = -(p_e(i)-p_w(i))/dx;        %%%does this need 2*speeds.u_bot*Dn?
        
    %%If the cell is IN the domain
    else
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+Fn_u(i)-Fs_u(i)+De+Dw+Dn+Ds;        
        A_u(i,i-Ny_u) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;   
        A_u(i,i+1)    =  Fn_u(i)-Dn;                
        A_u(i,i-1)    = -Fs_u(i)-Ds; 
        b_u(i) = -(p_e(i)-p_w(i))/dx;

    end
end
