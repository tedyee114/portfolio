% Perform a step of the heat transfer analysis
A_phi = zeros(length(phi_n(:)));
b_phi = zeros(length(phi_n(:)),1);

%% Set the heat transfer properties

phi_in = 0;
phi_wall = 1;
kappa = .01;

 %% Get the velocity at the midpoints of the Pressure/Temperature cell

uw = u_star(:,1:end-1);
ue = u_star(:,2:end);

vn = v_star(2:end,:);
vs = v_star(1:end-1,:);

%% Coefficients for the A matrix

Fe = ue/2/dx;   Fw = uw/2/dx;   Fn = vn/2/dy;   Fs = vs/2/dy;
De = 1/dx^2/Re; Dw = 1/dx^2/Re; Dn = 1/dy^2/Re; Ds = 1/dy^2/Re;

%% Create the A matrix for the phi system

for i = 1:Ny_p*Nx_p      

    % Boundaries on the west and south face
    if p_type(i) == 1
        A_phi(i,i) = Fe(i)+Fn(i)-2*Fs(i) + De+2*Dw+Dn + 1/dt;
        A_phi(i,i+Ny_p) = Fe(i)-De;
        A_phi(i,i+1)    = Fn(i)-Dn;
        b_phi(i) = phi_n(i)/dt + 2*(Fw(i)+Dw)*phi_in;

    % Boundaries on the west and north face
    elseif p_type(i) == 2
        A_phi(i,i) = Fe(i)-Fs(i) + De+2*Dw+2*Dn+Ds + 1/dt;
        A_phi(i,i+Ny_p) = Fe(i)-De;
        A_phi(i,i-1)    =-Fs(i)-Ds;
        b_phi(i) = phi_n(i)/dt + 2*(Fw(i)+Dw)*phi_in + 2*(-Fn(i)+Dn)*phi_wall;

    % Boundaries on the west face
    elseif p_type(i) == 3        
        A_phi(i,i) = Fe(i)+Fn(i)-Fs(i) + De+2*Dw+Dn+Ds + 1/dt;
        A_phi(i,i+Ny_p) = Fe(i)-De;
        A_phi(i,i+1)    = Fn(i)-Dn;
        A_phi(i,i-1)    =-Fs(i)-Ds;
        b_phi(i) = phi_n(i)/dt + 2*(Fw(i)+Dw)*phi_in;

    % Boundaries on the east and south face
    elseif p_type(i) == 4
        A_phi(i,i) = 2*Fe(i)-Fw(i)+Fn(i)-2*Fs(i) +Dw+Dn + 1/dt;        
        A_phi(i,i+1)    = Fn(i)-Dn;        
        A_phi(i,i-Ny_p) =-Fw(i)-Dw;
        b_phi(i) = phi_n(i)/dt;

    % Boundaries on the east and north face
    elseif p_type(i) == 5
        A_phi(i,i) = 2*Fe(i)-Fw(i)-Fs(i) + Dw+Ds+2*Dn + 1/dt;
        A_phi(i,i-1)    =-Fs(i)-Ds;
        A_phi(i,i-Ny_p) =-Fw(i)-Dw;
        b_phi(i) = phi_n(i)/dt + 2*(-Fn(i)+Dn)*phi_wall;

    % Boundaries on the east face
    elseif p_type(i) == 6         
        A_phi(i,i) = 2*Fe(i)-Fw(i)+Fn(i)-Fs(i) + +Dw+Dn+Ds + 1/dt;        
        A_phi(i,i+1)    = Fn(i)-Dn;
        A_phi(i,i-1)    =-Fs(i)-Ds;
        A_phi(i,i-Ny_p) =-Fw(i)-Dw;
        b_phi(i) = phi_n(i)/dt;

    % Boundaries on the south face
    elseif p_type(i) == 7
        A_phi(i,i) = Fe(i)-Fw(i)+Fn(i)-2*Fs(i) + De+Dw+Dn + 1/dt;
        A_phi(i,i+Ny_p) = Fe(i)-De;
        A_phi(i,i+1)    = Fn(i)-Dn;
        A_phi(i,i-Ny_p) =-Fw(i)-Dw;
        b_phi(i) = phi_n(i)/dt;           

    % Boundaries on the north face
    elseif p_type(i) == 8
        A_phi(i,i) = Fe(i)-Fw(i)   -Fs(i) + De+Dw+2*Dn+Ds + 1/dt;
        A_phi(i,i+Ny_p) = Fe(i)-De;
        A_phi(i,i-1)    =-Fs(i)-Ds;
        A_phi(i,i-Ny_p) =-Fw(i)-Dw;
        b_phi(i) = phi_n(i)/dt + 2*(-Fn(i)+Dn)*phi_wall;

    elseif p_type(i) == -1;
        A_phi(i,i) = 1;  
        b_phi(i) = 0;      
        
    % Interior cells
    else
        A_phi(i,i) = Fe(i)-Fw(i)+Fn(i)-Fs(i) + De+Dw+Dn+Ds + 1/dt;
        A_phi(i,i+Ny_p) = Fe(i)-De;
        A_phi(i,i+1)    = Fn(i)-Dn;
        A_phi(i,i-1)    =-Fs(i)-Ds;
        A_phi(i,i-Ny_p) =-Fw(i)-Dw;
        b_phi(i) = phi_n(i)/dt;
    end            

    
end

phi_np1 = A_phi\b_phi;

figure(4)
imagesc(x_p,y_p,reshape(phi_np1,length(y_p),length(x_p)));
set(gca,'YDir','normal')
colormap jet