clear; close all; clc;
cell_visualizations_on_off = true;
mesh_generation(cell_visualizations_on_off)                      %% Create the domain by calling grid_generation.m and set_cell_type.m and creates cell-type visualizations
system_parameters                    %% Set system and solver parameters
guess_initialization               %% Generate the initial guess for the system


for n = 1%:Nt-1                    %%%%%%%%%%%%%% TIME MARCHING
    time_step_initialization       %% Set the variables to begin a new time step
    simple_algorithm               %% Begin recursive calculation of u^n+1 and v^n+1
    % heat_transfer_step           %% Perform a heat transfer step
    plot_store_results             %% Plot results and store the u^n+1, v^n+1, and p^n+1 fields
end