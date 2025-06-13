clear; close all; clc;

%% Create the domain

mesh_generation

%% Set system and solver parameters

system_parameters

%% Generate the initial guess for the system
ambienthumidity = 0;
guess_initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% TIME MARCHING %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for n = 1%:Nt-1
    
    %% Set the variables to begin a new time step
    disp('time_step_initialization')
    time_step_initialization
    
    %% Begin recursive calculation of u^n+1 and v^n+1
    disp('simple_algorithm')
    simple_algorithm
    
    %% Perform a heat transfer step
    disp('heat_transfer_step')
    heat_transfer_step
    
    %% Plot results and store the u^n+1, v^n+1, and p^n+1 fields
    disp('plot_store_results')
    plot_store_results

    %% Clouds and Rain
    disp('clouds')
    clouds
end