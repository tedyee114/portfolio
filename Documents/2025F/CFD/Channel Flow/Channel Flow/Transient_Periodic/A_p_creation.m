function [A_p, b_p, Ap_u, Ap_v] = A_p_creation(u_star, v_star, p_guess, A_u, A_v, ...
    dx, dy, p_type)

[Ny_u, Nx_u] = size(u_star);
[Ny_v, Nx_v] = size(v_star);
[Ny_p, Nx_p] = size(p_guess);

 %% Get the velocity at the midpoints of the Pressure cell

        uw_star = u_star(:,1:end-1);
        ue_star = u_star(:,2:end);
        ue_star(:,end) = u_star(:,1);  % Periodic boundary condition imposed

        vn_star = v_star(2:end,:);
        vs_star = v_star(1:end-1,:);

    %% Set the value of aP for the u and v velocities

        Ap_u = reshape(diag(A_u),Ny_u,Nx_u);    

        Ap_v = reshape(diag(A_v),Ny_v,Nx_v);

    %% Calculate the pressure correction matrix coefficients

        Cw = 1./Ap_u(:,1:end-1)/dx^2;
        Ce = 1./Ap_u(:,2:end)/dx^2;
        Cn = 1./Ap_v(2:end,:)/dy^2;
        Cs = 1./Ap_v(1:end-1,:)/dy^2;

    %% Create the pressure correction matrix

        A_p = zeros(length(p_guess(:)));
        b_p = zeros(length(p_guess(:)),1);

    %% Set the pressure correction coefficients

        for i = 1:Ny_p*Nx_p      

            if p_type(i) == 1
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cn(i);
                A_p(i,i+Ny_p*(Nx_p-1)) = -Cw(i);
                A_p(i,i+Ny_p) = -Ce(i);
                A_p(i,i+1) = -Cn(i);

            elseif p_type(i) == 2
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cs(i);
                A_p(i,i+Ny_p*(Nx_p-1)) = -Cw(i);
                A_p(i,i+Ny_p) = -Ce(i);
                A_p(i,i-1) = -Cs(i);

            elseif p_type(i) == 3            
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cn(i) + Cs(i);
                A_p(i,i+Ny_p*(Nx_p-1)) = -Cw(i);
                A_p(i,i+Ny_p) = -Ce(i);
                A_p(i,i+1) = -Cn(i);
                A_p(i,i-1) = -Cs(i);

            elseif p_type(i) == 4
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cn(i);
                A_p(i,i-Ny_p*(Nx_p-1)) = -Ce(i);
                A_p(i,i+1) = -Cn(i);
                A_p(i,i-Ny_p) = -Cw(i);

            elseif p_type(i) == 5
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cs(i);
                A_p(i,i-Ny_p*(Nx_p-1)) = -Ce(i);
                A_p(i,i-1) = -Cs(i);
                A_p(i,i-Ny_p) = -Cw(i);

            elseif p_type(i) == 6            
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cn(i) + Cs(i);
                A_p(i,i-Ny_p*(Nx_p-1)) = -Ce(i);
                A_p(i,i+1) = -Cn(i);
                A_p(i,i-1) = -Cs(i);
                A_p(i,i-Ny_p) = -Cw(i);

            elseif p_type(i) == 7
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cn(i);
                A_p(i,i+Ny_p) = -Ce(i);
                A_p(i,i+1) = -Cn(i);
                A_p(i,i-Ny_p) = -Cw(i);            

            elseif p_type(i) == 8
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cs(i);
                A_p(i,i+Ny_p) = -Ce(i);
                A_p(i,i-1) = -Cs(i);
                A_p(i,i-Ny_p) = -Cw(i);

            else
                A_p(i,i) = A_p(i,i) + Cw(i) + Ce(i) + Cn(i) + Cs(i);
                A_p(i,i+Ny_p) = -Ce(i);
                A_p(i,i+1) = -Cn(i);
                A_p(i,i-1) = -Cs(i);
                A_p(i,i-Ny_p) = -Cw(i);            
            end            

            b_p(i) = -(ue_star(i)-uw_star(i))/dx -(vn_star(i)-vs_star(i))/dy;

        end

    %% Set the correction of the pressure at the top corner of the domain to zero

    % pressure correction for cell: ind will be zero
    
        ind = Ny_p*Nx_p; 

        A_p(ind,:) = 0;
        A_p(ind,ind) = 1;
        b_p(ind) = 0;

end