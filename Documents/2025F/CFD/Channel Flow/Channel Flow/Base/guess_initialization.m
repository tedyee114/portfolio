%% Guess initialization


%% Create the guessed values

u_guess = ones(length(y_u),length(x_u)); 
v_guess = zeros(length(y_v),length(x_v)); 
p_guess = zeros(length(y_p),length(x_p)); 

%% Store the values of the guess for a time history

u_time = u_guess;
v_time = v_guess;
p_time = p_guess;