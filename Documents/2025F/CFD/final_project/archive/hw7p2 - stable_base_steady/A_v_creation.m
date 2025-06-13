function [A_v, b_v] = A_v_creation(u_guess, v_guess, p_guess, dx, dy, dt,...
            Re, v_type, v_bot, v_top, v_prevTime,v_lef,A_v)
       
[Ny_v, Nx_v] = size(v_guess);

%% Calculation of the velocity at the midpoints (nonlinear terms)

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

%% Calculate of pressure at the north and south midpoints

p_n = [zeros(1,Nx_v); p_guess(2:end,:); zeros(1,Nx_v)];
p_s = [zeros(1,Nx_v); p_guess(1:end-1,:); zeros(1,Nx_v)];

%% Calculation of the coefficients for the matrix

Fe_v = ue/2/dx; Fw_v = uw/2/dx; Fn_v = vn/2/dy; Fs_v = vs/2/dy;
De = 1/dx^2/Re; Dw = 1/dx^2/Re; Dn = 1/dy^2/Re; Ds = 1/dy^2/Re;

%% Create the b vector for the vertical velocity calculation

b_v = zeros(length(v_guess(:)),1);

%% Set the values of the matrix

for i = 1:Ny_v*Nx_v

    %% If the cell is ON the bottom boundary    
    if v_type(i) == 1
        A_v(i,i) = 1;    
        b_v(i) = v_bot;

    %% If the cell is ON the top boundary
    elseif v_type(i) == 2
        A_v(i,i) = 1; 
        b_v(i) = v_top;

    %% If the cell is Neighboring the left boundary - v-cell with inlet on west edge dvdx = (vp-vw)/(dx/2)
    elseif v_type(i) == 3
        A_v(i,i)      =  Fe_v(i) +Fn_v(i)-Fs_v(i)+De+2*Dw+Dn+Ds;
        A_v(i,i+1)    =  Fn_v(i)-Dn;  
        A_v(i,i-1)    = -Fs_v(i)-Ds;            
        A_v(i,i+Ny_v) =  Fe_v(i)-De;
        b_v(i) = -(p_n(i)-p_s(i))/dy + 2*(Fw_v(i)+Dw)*v_lef; 

    %% If the cell is Neighboring the right boundary
    elseif v_type(i) == 4
        A_v(i,i)      =  2*Fe_v(i)-Fw_v(i)+Fn_v(i)-Fs_v(i)+Dw+Dn+Ds;
        A_v(i,i+1)    =  Fn_v(i)-Dn;  
        A_v(i,i-1)    = -Fs_v(i)-Ds; 
        A_v(i,i-Ny_v) = -Fw_v(i)-Dw;            
        b_v(i) = -(p_n(i)-p_s(i))/dy;  
        
    %% If the cell is In the domain
    else
        A_v(i,i)      =  Fe_v(i)-Fw_v(i)+Fn_v(i)-Fs_v(i)+De+Dw+Dn+Ds;
        A_v(i,i+1)    =  Fn_v(i)-Dn;  
        A_v(i,i-1)    = -Fs_v(i)-Ds; 
        A_v(i,i-Ny_v) = -Fw_v(i)-Dw;             
        A_v(i,i+Ny_v) =  Fe_v(i)-De;
        b_v(i) = -(p_n(i)-p_s(i))/dy;              
    end
end