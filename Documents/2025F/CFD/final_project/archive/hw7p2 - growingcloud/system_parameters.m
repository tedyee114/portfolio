%% System parameters
dx = 1/40;
dy = 1/40;
x_min = 0; x_max = 5;
y_min = 0; y_max = 1;
N.x_p = length(x_min:dx:x_max);
N.y_p = length(y_min:dy:y_max);

%% Set obstruction geometry data
y_obs_top = -0.1;
x_obs_front = 2;

% Temporal Domain
dt = 0.2;
t = 0:dt:4;
Nt = length(t);

% Set the Reynolds number
Re = 1;

% Set the relaxation parameters
alpha_u = .2;
alpha_v = .2;
alpha_p = .0025;

% Set the boundary speeds
speeds.u_bot =  0; speeds.v_bot = 0;
speeds.u_top =  0; speeds.v_top = 0;
speeds.u_lef =  1; speeds.v_lef = 0; 
speeds.u_rig =  0; speeds.v_rig = 0; 

% Set the stop conditions
II_max = 300;
u_tol = 10^-6;
II = 1;
u_change = 1;


%% Mountain Parameters
rise_slope = .75;
fall_slope = -2;
x_mountain_start = floor(N.x_p*50/100);
x_mountain_peak = floor(N.x_p*80/100);
x_mountain_end = floor(N.x_p*120/100);
ambienthumidity = 0;
scalefactor     = 10000;                    %Default = 10000. Vertical scale factor in simulation length units to m, i.e., 1 simulation length unit is 10km

%%Atmospheric Parameters
T_surface       = 300;                      %Default = 300 Kelvin. Temperature at sea level
lapse_rate      = 9.8/1000*scalefactor;     %Default = 9.8/1000 Kelvin/meter.  Lapse rate
criticalmass    = .031;                      %Default = 3.2 for phi_wall=1,phi_in=0. Nonrealistic parameter controlling rain threshold
rainremovalrate = .75;                       %default = 0.6 under 0.5 is 100% removal,  up to 1 is 50%. it skips over cells via round(rainremovalrate*rand)

%% Set the heat transfer properties
phi_in = .04;                % how much moisture comes in with wind from  left side
phi_wall = 0;                % how much moisture comes from the top side. 0 in atmosphere
kappa = 26.3e-3/scalefactor; % 26.3e-3 for air at 300K