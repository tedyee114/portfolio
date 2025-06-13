

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot the results
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

col = jet(70);
if mod(n,2) == 0 & n > 140
    figure(2);
    hold on; 
    u_temp = [u_bot+zeros(1,Nx_u); u_guess; u_top+zeros(1,Nx_u)];
    v_temp = [v_lef+zeros(Ny_v,1)  v_guess  v_rig+zeros(Ny_v,1)];

    x_vt = [0 x_v 1]; [X_v, Y_v] = meshgrid(x_vt,y_v);
    y_ut = [0 y_u 1]; [X_u, Y_u] = meshgrid(x_u,y_ut);

    [X,Y] = meshgrid(linspace(0,1,100),linspace(0,1,40));

    U = griddata(X_u(:),Y_u(:),u_temp(:),X,Y);
    V = griddata(X_v(:),Y_v(:),v_temp(:),X,Y);

%     imagesc(x_p,y_p,reshape(p_guess,Ny_p,Nx_p)); hold on;
%     quiver(X,Y,U,V,'k')
    plot(u_guess,y_u,'.-','MarkerSize',30,'LineWidth',4,'Color',col(n-140,:))
    axis([-1 1 0 1])
    colorbar
    drawnow

end
    
    
%% Store the results
 
u_time(:,:,n+1) = u_guess;
v_time(:,:,n+1) = v_guess;
p_time(:,:,n+1) = p_guess;
