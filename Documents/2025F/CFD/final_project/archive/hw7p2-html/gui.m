% Create UI as a figure
base = uifigure('Name', 'ANTSSSSS', "Icon","tyicon-transparent.png", 'color', [.3,.3,.3]);


%% Inputs

fig = uigridlayout(base,[20,4]);

%%%Title
welcome = uilabel(fig);
% , 'Text', 'Welcome to ANSYS Lite, aka ANTSSSSS', 'FontSize',20,'FontColor','blue');
% <font style='color:green;'>This table</font> is <em>not complete</em>.

welcome.Text = "<font style='font-weight: bold; color: orange; font-family: sans-serif; font-size: 20;'>A</font>" + ...
               "<font style='font-weight: bold; color: black; font-family: sans-serif; font-size: 20;'>NSYS Lite, aka ANTSSSSS</font>";
welcome.Interpreter = "html";
welcome.Layout.Row = 1; 
welcome.Layout.Column = [1,4];


%%Left u
u_lef = uilabel(fig, 'Text', 'u_left');
u_lef_type_dropdown = uidropdown(fig, "Items", ["Dirichlet", "FreeSlip", "Neumann"]);
u_lef_value_box = create_textbox(fig, 'Value:', 'cos(8*pi*y)', [30, 60, 120, 22]);

u_lef.Layout.Row = 3; 
u_lef.Layout.Column = 1;
u_lef_type_dropdown.Layout.Row = 4; 
u_lef_type_dropdown.Layout.Column = 1;
u_lef_value_box.Layout.Row = 4; 
u_lef_value_box.Layout.Column = 2;

%%Right u
u_rig = uilabel(fig, 'Text', 'u_right');
u_rig_type_dropdown = uidropdown(fig, "Items", ["Neumann", "FreeSlip", "Dirichlet"]);
u_rig_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

u_rig.Layout.Row = 5; 
u_rig.Layout.Column = 1;
u_rig_type_dropdown.Layout.Row = 6; 
u_rig_type_dropdown.Layout.Column = 1;
u_rig_value_box.Layout.Row = 6; 
u_rig_value_box.Layout.Column = 2;

%Bottom u
u_bot = uilabel(fig, 'Text', 'u_bottom');
u_bot_type_dropdown = uidropdown(fig, "Items", [ "FreeSlip", "Dirichlet", "Neumann"]);
u_bot_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

u_bot.Layout.Row = 7; 
u_bot.Layout.Column = 1;
u_bot_type_dropdown.Layout.Row = 8; 
u_bot_type_dropdown.Layout.Column = 1;
u_bot_value_box.Layout.Row = 8; 
u_bot_value_box.Layout.Column = 2;

%Top u
u_top = uilabel(fig, 'Text', 'u_top');
u_top_type_dropdown = uidropdown(fig, "Items", [ "FreeSlip", "Dirichlet", "Neumann"]);
u_top_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

u_top.Layout.Row = 9; 
u_top.Layout.Column = 1;
u_top_type_dropdown.Layout.Row = 10; 
u_top_type_dropdown.Layout.Column = 1;
u_top_value_box.Layout.Row = 10; 
u_top_value_box.Layout.Column = 2;

%Left v
v_lef = uilabel(fig, 'Text', 'v_left');
v_lef_type_dropdown = uidropdown(fig, "Items", [ "FreeSlip", "Dirichlet", "Neumann"]);
v_lef_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

v_lef.Layout.Row = 12;  
v_lef.Layout.Column = 1;
v_lef_type_dropdown.Layout.Row = 13;  
v_lef_type_dropdown.Layout.Column = 1;
v_lef_value_box.Layout.Row = 13;  
v_lef_value_box.Layout.Column = 2;

% Right V
v_rig = uilabel(fig, 'Text', 'v_right');
v_rig_type_dropdown = uidropdown(fig, "Items", [ "FreeSlip", "Dirichlet", "Neumann"]);
v_rig_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

v_rig.Layout.Row = 14;  
v_rig.Layout.Column = 1;
v_rig_type_dropdown.Layout.Row = 15;  
v_rig_type_dropdown.Layout.Column = 1;
v_rig_value_box.Layout.Row = 15;  
v_rig_value_box.Layout.Column = 2;

% Bottom V
v_bot = uilabel(fig, 'Text', 'v_bottom');
v_bot_type_dropdown = uidropdown(fig, "Items", ["Dirichlet", "FreeSlip", "Neumann"]);
v_bot_value_box = create_textbox(fig, 'Value:', 'cos(8*pi*x)', [30, 60, 120, 22]);

v_bot.Layout.Row = 16;  
v_bot.Layout.Column = 1;
v_bot_type_dropdown.Layout.Row = 17;  
v_bot_type_dropdown.Layout.Column = 1;
v_bot_value_box.Layout.Row = 17;  
v_bot_value_box.Layout.Column = 2;

% Top V
v_top = uilabel(fig, 'Text', 'v_top');
v_top_type_dropdown = uidropdown(fig, "Items", ["Neumann", "FreeSlip", "Dirichlet"]);
v_top_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

v_top.Layout.Row = 18;  
v_top.Layout.Column = 1;
v_top_type_dropdown.Layout.Row = 19;  
v_top_type_dropdown.Layout.Column = 1;
v_top_value_box.Layout.Row = 19;  
v_top_value_box.Layout.Column = 2;

panel_1 = uipanel(fig);
panel_1.Layout.Row = [3, 18];
panel_1.Layout.Column = 3;

panel_2 = uipanel(fig);
panel_2.Layout.Row = [3, 18];
panel_2.Layout.Column = 4;

mesh_generation                                       %% Create the domain by calling grid_generation.m and set_cell_type.m and creates cell-type visualizations

% Initial parameter values
BC.u_lef_type = "Dirichlet";        %x=0
BC.u_lef_value = "cos(8*pi*y)";
BC.u_rig_type = "Neumann";         %x=1
BC.u_rig_value = 0;
BC.u_bot_type = "FreeSlip";
BC.u_bot_value = 0;
BC.u_top_type = "FreeSlip";
BC.u_top_value = 0;

BC.v_lef_type = "FreeSlip";
BC.v_lef_value = 0;
BC.v_rig_type = "FreeSlip";
BC.v_rig_value = 0;
BC.v_bot_type = "Dirichlet";        %y=0
BC.v_bot_value = "cos(8*pi*x)";
BC.v_top_type = "Neumann";          %y=1
BC.v_top_value = 0;

% Create the submit button
submit_btn = uibutton(fig, 'Text', 'Initialize and Run', 'Position', [10, 220, 120, 30], 'ButtonPushedFcn', @(btn, event) update_plot(fig, grids, N,base));

% Store the UI component handles in guidata
guidata(fig, struct('u_lef_type_dropdown', u_lef_type_dropdown, 'u_lef_value_box', u_lef_value_box, ...
                    'u_rig_type_dropdown', u_rig_type_dropdown, 'u_rig_value_box', u_rig_value_box, ...
                    'u_bot_type_dropdown', u_bot_type_dropdown, 'u_bot_value_box', u_bot_value_box, ...
                    'u_top_type_dropdown', u_top_type_dropdown, 'u_top_value_box', u_top_value_box, ...
                    'v_lef_type_dropdown', v_lef_type_dropdown, 'v_lef_value_box', v_lef_value_box, ...
                    'v_rig_type_dropdown', v_rig_type_dropdown, 'v_rig_value_box', v_rig_value_box, ...
                    'v_bot_type_dropdown', v_bot_type_dropdown, 'v_bot_value_box', v_bot_value_box, ...
                    'v_top_type_dropdown', v_top_type_dropdown, 'v_top_value_box', v_top_value_box));

uiwait(base);

%% The callback function
function BC = update_plot(fig, grids, N,base)
    try
        % Retrieve the stored value from guidata
        data = guidata(fig);
        disp(fieldnames(data));  % This will help in debugging if the fields exist

        % Retrieve and evaluate inputs for boundary conditions
        BC.u_lef_value = evaluate_input(data.u_lef_value_box.Value, grids, N);
        BC.u_rig_value = evaluate_input(data.u_rig_value_box.Value, grids, N);
        BC.u_bot_value = evaluate_input(data.u_bot_value_box.Value, grids, N);
        BC.u_top_value = evaluate_input(data.u_top_value_box.Value, grids, N);
        BC.u_lef_type  = data.u_lef_type_dropdown.Value;
        BC.u_rig_type  = data.u_rig_type_dropdown.Value;
        BC.u_bot_type  = data.u_bot_type_dropdown.Value;
        BC.u_top_type  = data.u_top_type_dropdown.Value;

        
        BC.v_lef_value = evaluate_input(data.v_lef_value_box.Value, grids, N);
        BC.v_rig_value = evaluate_input(data.v_rig_value_box.Value, grids, N);
        BC.v_bot_value = evaluate_input(data.v_bot_value_box.Value, grids, N);
        BC.v_top_value = evaluate_input(data.v_top_value_box.Value, grids, N);
        BC.v_lef_type  = data.v_lef_type_dropdown.Value;
        BC.v_rig_type  = data.v_rig_type_dropdown.Value;
        BC.v_bot_type  = data.v_bot_type_dropdown.Value;
        BC.v_top_type  = data.v_top_type_dropdown.Value;

        assignin('base', 'BC', BC);
        disp('✅ BC stored in base workspace');
        uiresume(base);

    catch ME
        disp('❌ Error in update_plot:');
        disp(getReport(ME, 'extended'));
    end
end

function value = evaluate_input(input_str, grids, N)
    try
        % Replace 'x' and 'y' with grid variables
        input_str = strrep(input_str, 'x', 'grids.x_u');
        input_str = strrep(input_str, 'y', 'grids.y_v');

        func = str2func(['@(grids) ' input_str]);
        value = func(grids);

        if isscalar(value)
            if isvector(value)
                value = value * ones(N.y_p, 1);
            else
                value = value * ones(N.x_p, 1);
            end
        end
    catch ME
        error('Error evaluating input "%s": %s', input_str, ME.message);
    end
end



function textbox = create_textbox(fig, name, initial_value, position)
    % Create a text box for the UI
    textbox = uieditfield(fig, 'text', 'Position', position);
    textbox.Value = initial_value;
    textbox.Tooltip = name;
end