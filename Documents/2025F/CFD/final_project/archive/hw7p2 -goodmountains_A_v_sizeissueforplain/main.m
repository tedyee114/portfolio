
clear; close all; clc;
tic

%% 
cell_visualizations_on_off =1;
blocked = 1;
rainshadow = 0;
%%%%ideally a geometry gui would set the values currently in
%%%%system_parameters, then once submitted would generate, then gui would
%%%%setup methods then begin once the initialize and run button is clicked
system_parameters                                     %% Set system, geometry, and solver parameters
solver_gui
if blocked ==1
    set_cell_type_blocked
else
    set_cell_type
end
if rainshadow ==1
    create_mountain
end
plot_cell_type
guess_initialization                                  %% Generate the initial guess for the system


for n = 1:4%Nt-1                                       %%%%%%%%%%%%%% TIME MARCHING
    disp('time_step_initialization')
    time_step_initialization                          %% Set the variables to begin a new time step
    disp('simple_algorithm')
    simple_algorithm                                  %% Begin recursive calculation of u^n+1 and v^n+1 using A_u, A_v, and A_p
    disp('heat_transfer_step')
    heat_transfer_step                                %% Perform a heat transfer step
    disp('plot_store_results')
    plot_store_results                                %% Plot results and store the u^n+1, v^n+1, and p^n+1 fields
    disp('clouds')
    clouds                                            %% Clouds and Rain
end

toc
