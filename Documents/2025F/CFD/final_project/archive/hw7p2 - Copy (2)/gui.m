% Create UI as a figure
base = uifigure('Name', 'ANTSSSSS', "Icon","tyicon-transparent.png", 'color', [.3,.3,.3]);
% base.WindowState = maximized;

% Turn Cell-Type Visualizations on and Off
cell_visualizations_on_off = 1;

%% Inputs

fig = uigridlayout(base,[20,4]);

%%Left u
u_lef = uilabel(fig, 'Text', 'u_left');
u_lef_type_dropdown = uidropdown(fig, "Items", ["Dirichlet", "FreeSlip", "Neumann"]);
u_lef_value_box = create_textbox(fig, 'Value:', 'cos(8*pi*grids.y_u)', [30, 60, 120, 22]);

u_lef.Layout.Row = 1; 
u_lef.Layout.Column = 1;
u_lef_type_dropdown.Layout.Row = 2; 
u_lef_type_dropdown.Layout.Column = 1;
u_lef_value_box.Layout.Row = 2; 
u_lef_value_box.Layout.Column = 2;

%%Right u
u_rig = uilabel(fig, 'Text', 'u_right');
u_rig_type_dropdown = uidropdown(fig, "Items", ["Neumann", "FreeSlip", "Dirichlet"]);
u_rig_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

u_rig.Layout.Row = 3; 
u_rig.Layout.Column = 1;
u_rig_type_dropdown.Layout.Row = 4; 
u_rig_type_dropdown.Layout.Column = 1;
u_rig_value_box.Layout.Row = 4; 
u_rig_value_box.Layout.Column = 2;

%Bottom u
u_bot = uilabel(fig, 'Text', 'u_bottom');
u_bot_type_dropdown = uidropdown(fig, "Items", [ "FreeSlip", "Dirichlet", "Neumann"]);
u_bot_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

u_bot.Layout.Row = 5; 
u_bot.Layout.Column = 1;
u_bot_type_dropdown.Layout.Row = 6; 
u_bot_type_dropdown.Layout.Column = 1;
u_bot_value_box.Layout.Row = 6; 
u_bot_value_box.Layout.Column = 2;

%Top u
u_top = uilabel(fig, 'Text', 'u_top');
u_top_type_dropdown = uidropdown(fig, "Items", [ "FreeSlip", "Dirichlet", "Neumann"]);
u_top_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

u_top.Layout.Row = 7; 
u_top.Layout.Column = 1;
u_top_type_dropdown.Layout.Row = 8; 
u_top_type_dropdown.Layout.Column = 1;
u_top_value_box.Layout.Row = 8; 
u_top_value_box.Layout.Column = 2;

%Left v
v_lef = uilabel(fig, 'Text', 'v_left');
v_lef_type_dropdown = uidropdown(fig, "Items", [ "FreeSlip", "Dirichlet", "Neumann"]);
v_lef_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

v_lef.Layout.Row = 10;  % Changed row from 9 to 10
v_lef.Layout.Column = 1;
v_lef_type_dropdown.Layout.Row = 11;  % Changed row from 10 to 11
v_lef_type_dropdown.Layout.Column = 1;
v_lef_value_box.Layout.Row = 11;  % Changed row from 10 to 11
v_lef_value_box.Layout.Column = 2;

% Right V
v_rig = uilabel(fig, 'Text', 'v_right');
v_rig_type_dropdown = uidropdown(fig, "Items", [ "FreeSlip", "Dirichlet", "Neumann"]);
v_rig_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

v_rig.Layout.Row = 12;  % Changed row from 11 to 12
v_rig.Layout.Column = 1;
v_rig_type_dropdown.Layout.Row = 13;  % Changed row from 12 to 13
v_rig_type_dropdown.Layout.Column = 1;
v_rig_value_box.Layout.Row = 13;  % Changed row from 12 to 13
v_rig_value_box.Layout.Column = 2;

% Bottom V
v_bot = uilabel(fig, 'Text', 'v_bottom');
v_bot_type_dropdown = uidropdown(fig, "Items", ["Dirichlet", "FreeSlip", "Neumann"]);
v_bot_value_box = create_textbox(fig, 'Value:', 'cos(8*pi*grids.x_v)', [30, 60, 120, 22]);

v_bot.Layout.Row = 14;  % Changed row from 13 to 14
v_bot.Layout.Column = 1;
v_bot_type_dropdown.Layout.Row = 15;  % Changed row from 14 to 15
v_bot_type_dropdown.Layout.Column = 1;
v_bot_value_box.Layout.Row = 15;  % Changed row from 14 to 15
v_bot_value_box.Layout.Column = 2;

% Top V
v_top = uilabel(fig, 'Text', 'v_top');
v_top_type_dropdown = uidropdown(fig, "Items", ["Neumann", "FreeSlip", "Dirichlet"]);
v_top_value_box = create_textbox(fig, 'Value:', '0', [30, 60, 120, 22]);

v_top.Layout.Row = 16;  % Changed row from 15 to 16
v_top.Layout.Column = 1;
v_top_type_dropdown.Layout.Row = 17;  % Changed row from 16 to 17
v_top_type_dropdown.Layout.Column = 1;
v_top_value_box.Layout.Row = 17;  % Changed row from 16 to 17
v_top_value_box.Layout.Column = 2;

% 
% ax = axes(fig);
% ax.Layout.Row = [1 24];ax.Layout.Column = 3;
% ax = axes(fig);
% ax.Layout.Row = [1 24];ax.Layout.Column = 4;


panel_1 = uipanel(fig);
panel_1.Layout.Row = [1, 16];
panel_1.Layout.Column = 3;

panel_2 = uipanel(fig);
panel_2.Layout.Row = [1, 16];
panel_2.Layout.Column = 4;


% % Initial parameter values
% nu = 0.1;
% c = 0.5;
% dx = 0.025;
% dy = 0.025;
% 
% % Create the submit button
% submit_btn = uibutton(fig, 'Text', 'Submit', 'Position', [10, 200, 120, 30], 'ButtonPushedFcn', @(btn, event) update_plot());
% 
% function update_plot()
%     % Read the new values from the text boxes
%     nu = str2double(nu_box.Value);
%     c = str2double(c_box.Value);
%     dx = str2double(dx_box.Value);
%     dy = str2double(dy_box.Value);
% 
%     % Validate input values
%     if any(isnan([nu, c, dx, dy])) || nu <= 0 || c <= 0 || dx <= 0 || dy <= 0
%         uialert(fig, 'Please enter valid positive numeric values.', 'Input Error');
%     end
%     pause('off')
% end
% 

function textbox = create_textbox(fig, name, initial_value, position)
    % Create a text box for the UI
    textbox = uieditfield(fig, 'text', 'Position', position);
    textbox.Value = initial_value;
    textbox.Tooltip = name;
end