function [A_u, b_u] = A_u_creation(u_guess, v_guess, p_guess, dx, dy, dt,...
    Re, u_type, u_bot, u_prevTime)

[Ny_u, Nx_u] = size(u_guess);

u_P = u_guess;
u_E = [u_guess(:,2:end) u_guess(:,2)];
u_W = [u_guess(:,end-1) u_guess(:,1:end-1)];

v_ne = [v_guess(2:end,:) v_guess(2:end,1)];
v_nw = [v_guess(2:end,end) v_guess(2:end,:)];
v_se = [v_guess(1:end-1,:) v_guess(1:end-1,1)];
v_sw = [v_guess(1:end-1,end) v_guess(1:end-1,:)];

%% Calculation of the velocity at the midpoints (nonlinear terms)

ue = (u_P + u_E)/2;
uw = (u_P + u_W)/2;
vn = (v_ne + v_nw)/2;
vs = (v_se + v_sw)/2;

%% Calculate the pressures at the east and west midpoint

p_e = [p_guess p_guess(:,1)];
p_w = [p_guess(:,end) p_guess];

%% Coefficients for the A matrix

Fe_u = ue/2/dx; Fw_u = uw/2/dx; Fn_u = vn/2/dy; Fs_u = vs/2/dy;
De = 1/dx^2/Re; Dw = 1/dx^2/Re; Dn = 1/dy^2/Re; Ds = 1/dy^2/Re;        

%% Create the A matrix and the right hand side

A_u = zeros(length(u_guess(:)),length(u_guess(:)));
b_u = zeros(length(u_guess(:)),1);

for i = 1:length(u_type(:))
    
    %% If the cell is ON the right boundary
    if u_type(i) == 1            
        % Periodic boundary condition
        A_u(i,i) = 1;  
        A_u(i,i-Ny_u*(Nx_u-1)) = -1;
        b_u(i) = 0;

    %% If the cell is ON the left boundary at the bottom
    elseif u_type(i) == 2
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+Fn_u(i)-Fs_u(i)+De+Dw+Dn+2*Ds + 1/dt;      
        A_u(i,i+Ny_u*(Nx_u-2)) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;    
        A_u(i,i+1)    =  Fn_u(i)-Dn;            
        b_u(i)        = -(p_e(i)-p_w(i))/dx + 2*u_bot*Ds + u_prevTime(i)/dt;

    %% If the cell is ON the left boundary at the top
    elseif u_type(i) == 3
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+Fn_u(i)-Fs_u(i)+De+Dw+Ds + 1/dt;      
        A_u(i,i+Ny_u*(Nx_u-2)) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;                 
        A_u(i,i-1)    = -Fs_u(i)-Ds;      
        b_u(i)        = -(p_e(i)-p_w(i))/dx + u_prevTime(i)/dt;            

    %% If the cell is ON the left boundary but not at the bottom or top
    elseif u_type(i) == 4
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+Fn_u(i)-Fs_u(i)+De+Dw+Dn+Ds + 1/dt;      
        A_u(i,i+Ny_u*(Nx_u-2)) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;    
        A_u(i,i+1)    =  Fn_u(i)-Dn;             
        A_u(i,i-1)    = -Fs_u(i)-Ds; 
        b_u(i)        = -(p_e(i)-p_w(i))/dx + u_prevTime(i)/dt;            

    %% If the cell is Neighboring the bottom boundary 
    elseif u_type(i) == 5
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+Fn_u(i)-Fs_u(i)+De+Dw+Dn+2*Ds + 1/dt;      
        A_u(i,i-Ny_u) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;    
        A_u(i,i+1)    =  Fn_u(i)-Dn;            
        b_u(i)        = -(p_e(i)-p_w(i))/dx + 2*u_bot*Ds + u_prevTime(i)/dt;

    %% If the cell is Neighboring the top boundary
    elseif u_type(i) == 6
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+Fn_u(i)-Fs_u(i)+De+Dw+Ds + 1/dt;      
        A_u(i,i-Ny_u) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;                 
        A_u(i,i-1)    = -Fs_u(i)-Ds;      
        b_u(i)        = -(p_e(i)-p_w(i))/dx + u_prevTime(i)/dt;

    %% If the cell is IN the domain
    else
        A_u(i,i)      =  Fe_u(i)-Fw_u(i)+Fn_u(i)-Fs_u(i)+De+Dw+Dn+Ds + 1/dt;        
        A_u(i,i-Ny_u) = -Fw_u(i)-Dw;   
        A_u(i,i+Ny_u) =  Fe_u(i)-De;   
        A_u(i,i+1)    =  Fn_u(i)-Dn;                
        A_u(i,i-1)    = -Fs_u(i)-Ds; 
        b_u(i) = -(p_e(i)-p_w(i))/dx + u_prevTime(i)/dt;

    end
end

A_u = sparse(A_u);