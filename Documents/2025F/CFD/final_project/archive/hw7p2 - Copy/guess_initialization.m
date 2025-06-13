%% Guess initialization

% Create the guessed values
u_guess = ones(length(grids.y_u),length(grids.x_u)); 
v_guess = zeros(length(grids.y_v),length(grids.x_v)); 
p_guess = zeros(length(grids.y_p),length(grids.x_p)); 

% Store the values of the guess for a time history
u_time = u_guess;
v_time = v_guess;
p_time = p_guess;