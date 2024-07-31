 function parametric_breast_model_GUI


% The run of this function displays a graphical interface for creating a 
% 2D parametric breast model. Before using this function users have to set
% the paths of the breast shape parameters.


%%%%%--------PATHS SETTING-------%%%%%%%
% Parameters loading (we extracted these breast shape parameters from the 
% mammograms in our selected dataset).
load('', 'a_tot'); % Insert here the path of the file a_tot.mat es: 'C:\MyPath\a_tot'
a = a_tot;
load('', 'b_tot'); % Insert here the path of the file b_tot.mat es: 'C:\MyPath\b_tot'
b = b_tot;
load('', 'phi_tot'); % Insert here the path of the file phi_tot.mat es: 'C:\MyPath\phi_tot'
phi = phi_tot;
load('', 'X0_tot'); % Insert here the path of the file X0_tot.mat es: 'C:\MyPath\X0_tot'
X0 = X0_tot;
load('', 'Y0_tot'); % Insert here the path of the file Y0_tot.mat es: 'C:\MyPath\Y0_tot'
Y0 = Y0_tot;
load('', 'Alpha_e_tot'); % Insert here the path of the file Alpha_e_tot.mat es: 'C:\MyPath\Alpha_e_tot'
Alpha_e = Alpha_e_tot;
%%%%%----------------------------%%%%%%%

% Background colors
background_color = [0.9 0.9 0.9];
figure_color = [0.9 0.9 0.9];
sliders_color = [0.84 0.84 0.84];

% Font size of minima and maxima
size_m = 9.5;

FigH = figure('position',[404 390 1200 700], 'Color',figure_color);
set(gcf,'GraphicsSmoothing','off') % no antialiasing

% Hide the figure number and create a figure title
set(FigH,'NumberTitle','off');
set(FigH, 'Name', '2D Breast Parametric Model');

axes ('xlim', [-1.5 2.5], 'ylim', [-1.5 2.5],'units','normalized', 'position',...
    [0.04 0.05 0.45 0.93],'Box','on', 'NextPlot', 'add');
% The plot will occupy the left half of the figure.
axis equal

% Sliders position
left_s = 670;
start_bottom_s = 645;
width_s = 400;
height_s = 20;
delta = 70;

% Sliders name position
left_sn = left_s - 60;
start_bottom_sn = start_bottom_s - 12;
width_sn = 40;
height_sn = 30;

% Value position
left_v = left_s + 150;
start_bottom_v = start_bottom_s + 10;
width_v = 110;
height_v = 30;

% Minima and maxima values position
width_m = 100;
height_m = 30;
left_min = left_s;
left_max = left_s + width_s - width_m;
start_bottom_m = start_bottom_s - 35;

% Checkbox position
left_cb = left_s + width_s + 10;
width_cb = 105;
height_cb = 30;
bottom_cb1 = start_bottom_s - 5*delta/2;
bottom_cb2 = start_bottom_s-6.22*delta;
bottom_cb3 = start_bottom_s-7.2*delta;

% Panels
width_p = width_s + 190;
left_p = left_sn-10;
bottom1 = start_bottom_s-5*delta-10;
bottom2 = start_bottom_s-6.35*delta;
height1 = 5*delta+60;
height12 = 1.1*delta;
panels_distance = bottom1 - (bottom2 + height12);
bottom3 = bottom2 - panels_distance - height12;

Panel1Position = [left_p bottom1 width_p height1];
Panel1 = uipanel('Parent', FigH,...
                         'Title', 'Shape & Skin Thickness',...
                         'TitlePosition', 'lefttop',...
                         'Tag', 'Panel1',...
                         'Units','pixels',...
                         'Position', Panel1Position,...
                         'BackgroundColor',background_color,...
                         'FontSize', 12,...
                         'Visible', 'on',...
                         'HandleVisibility', 'on'...
                        );

Panel2Position = [left_p bottom2 width_p height12+1];
Panel2 = uipanel('Parent', FigH,...
                         'Title', 'Fibroglandular Tissue',...
                         'TitlePosition', 'lefttop',...
                         'Tag', 'Panel2',...
                         'Units','pixels',...
                         'Position', Panel2Position,...
                         'BackgroundColor',background_color,...
                         'FontSize', 12,...
                         'Visible', 'on',...
                         'HandleVisibility', 'on'...
                        );

Panel3Position = [left_p bottom3 width_p height12+1];
Panel3 = uipanel('Parent', FigH,...
                         'Title', 'Tumors',...
                         'TitlePosition', 'lefttop',...
                         'Tag', 'Panel3',...
                         'Units','pixels',...
                         'Position', Panel3Position,...
                         'BackgroundColor',background_color,...
                         'FontSize', 12,...
                         'Visible', 'on',...
                         'HandleVisibility', 'on'...
                        );




% By uncomment the following lines (from 133 to 140), the default breast 
% shape parameters will be random values from the range of extracted parameters
% a_m = min(a) + (max(a)-min(a)) .* rand(1,1);
% if a_m >= 1; a_m = round(a_m,3,"significant"); else; a_m = round(a_m,2,"significant"); end
% b_m = min(b) + (max(b)-min(b)) .* rand(1,1);
% if b_m >= 1; b_m = round(b_m,3,"significant"); else; b_m = round(b_m,2,"significant"); end
% phi_m = min(phi) + (max(phi)-min(phi)) .* rand(1,1);
% X0_m = min(X0) + (max(X0)-min(X0)) .* rand(1,1);
% Y0_m = min(Y0) + (max(Y0)-min(Y0)) .* rand(1,1);
% alpha_e = min(Alpha_e) + (max(Alpha_e)-min(Alpha_e)) .* rand(1,1);

% By uncomment the following lines (from 144 to 151), the default breast 
% shape parameters will be the median values of the extracted parameters.
% a_m = median(a);
% if a_m >= 1; a_m = round(a_m,3,"significant"); else; a_m = round(a_m,2,"significant"); end
% b_m = median(b);
% if b_m >= 1; b_m = round(b_m,3,"significant"); else; b_m = round(b_m,2,"significant"); end
% phi_m = median(phi);
% X0_m = median(X0);
% Y0_m = median(Y0);
% alpha_e = median(Alpha_e);

% By uncomment the following lines (from 156 to 166), the default breast 
% shape parameters will be the ones corresponding to the specified mammogram of 
% the selected dataset
mammogram = 1; % By default, the user can pick the parameters of the first 
% mammogram but also can change this value to pick the parameters of one of 
% the 163 mammograms in the selected dataset
a_m = a(mammogram);
if a_m >= 1; a_m = round(a_m,3,"significant"); else; a_m = round(a_m,2,"significant"); end
b_m = b(mammogram);
if b_m >= 1; b_m = round(b_m,3,"significant"); else; b_m = round(b_m,2,"significant"); end
phi_m = phi(mammogram);
X0_m = X0(mammogram);
Y0_m = Y0(mammogram);
alpha_e = Alpha_e(mammogram);

% We impose a vertical constraint: the start and end points of the ellipse 
% modeling the breast must lie on the same vertical.
offset = 0.1;
alpha = alpha_e + offset;
x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-phi_m) - b_m.*sin(alpha_e).*sin(-phi_m);
x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
soglia = 0.01;
while abs(x_b1-x_b2) >= soglia
    alpha = alpha + 0.01;
    x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
end

% Model Colors (colorset 1)
color_n = [176 196 222]/255; % lightsteelblue, nipple color
color_gt = [135 206 250]/255; % lightskyblue, glandular tissue color
color_st = [70 130 180]/255; % steelblue, skin thickness color
color_b = [100 149 237]/255; % cornflowerblue, color of the rest of the breast
color_bm = [50 205 50]/255; % limegreen, solid benign tumors color
color_mm = [178 34 34]/255; % firebrick, solid malignant tumors color

t = linspace(alpha_e,alpha);
theta_m = alpha_e + (alpha-alpha_e)/2; % theta_m is the angle of nipple placement
% x_n e y_n are the nipple coordinates
x_n = X0_m + a_m.*cos(theta_m).*cos(-phi_m) - b_m.*sin(theta_m).*sin(-phi_m);
y_n = Y0_m + a_m.*cos(theta_m).*sin(-phi_m) + b_m.*sin(theta_m).*cos(-phi_m);
PointN = plot(x_n,y_n,'o','LineWidth',2, 'Color', color_n, 'MarkerSize',25, 'MarkerFaceColor', color_n);
% We represent the nipple as a point on the breast profile

% Ellipse parametric equation
x_t = X0_m + a_m.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
y_t = Y0_m + a_m.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);

LineH = plot(x_t,y_t, 'Color', color_b, 'LineWidth', 2);
set(gca,'Color','k', 'XColor','k', 'YColor','k') % background
FillH = fill(x_t,y_t, color_b);
FillH.FaceColor = color_b;
FillH.EdgeColor = color_b;

shift = 0.1;
x_t_shifted = x_t + shift;
y_t_shifted = y_t;
Line_shifted = plot(x_t_shifted,y_t_shifted, 'Color', "none", 'LineWidth', 2); 
% Skin thickness plot
Fill_shifted = fill(x_t_shifted,y_t_shifted, 'k');
Fill_shifted.FaceColor = "none";
Fill_shifted.EdgeColor = "none";

% We set axis limits so that the breast is at the center of the plot
ax = gca;
x_inf = min(x_t) - ((x_b2-min(x_t))/10);
x_sup = x_b2;
ax.XLim = [x_inf x_sup];
y_sup = max(y_t);
y_inf = min(y_t);
ax.YLim = [y_inf y_sup];

% Initialization of the eventdata values
num_a = 0;
num_b = 0;
num_phi = 0;
num_theta = 0;
num_end = 0;
num_skin_thickness = 0;
num_thickness = 0;
num_colorset1 = 1;
num_colorset2 = 0;
numcb1 = 0;
numcb2 = 0;
numcb3 = 0;


%% a SLIDER

TextH_a = uicontrol('style','text','FontSize', 10, ...
    'BackgroundColor',background_color, ...
    'position',[left_v start_bottom_v width_v height_v]);
TextH_a.String = "a = " + num2str(a_m);
TextH_a.Units = "normalized";

NameSlider_a = uicontrol('style','text', 'tag','rollover', 'FontSize', 11,'FontWeight','bold',...
    'BackgroundColor',background_color,...
    'position',[left_sn start_bottom_sn width_sn height_sn],'ToolTipString','ellipse horizontal semi-axis, i.e. width of the breast profile');
NameSlider_a.String = 'a';
NameSlider_a.Units = "normalized";

min_a = min(a);
if min_a >= 1; min_a = round(min_a,3,"significant"); else; min_a = round(min_a,2,"significant"); end
MinSlider_a = uicontrol('style','text', 'FontSize', size_m,...
    'BackgroundColor',background_color,...
    'position',[left_min start_bottom_m width_m height_m]);
MinSlider_a.String = {"min = " + min_a};
MinSlider_a.Units = "normalized";

max_a = max(a);
if max_a >= 1; max_a = round(max_a,3,"significant"); else; max_a = round(max_a,2,"significant"); end
MaxSlider_a = uicontrol('style','text', 'FontSize', size_m,...
    'BackgroundColor',background_color,...
    'position',[left_max start_bottom_m width_m height_m]);
MaxSlider_a.String = {"max = " + max_a};
MaxSlider_a.Units = "normalized";

Slider_a = uicontrol('style','slider','position',[left_s start_bottom_s width_s height_s],...
    'BackgroundColor',sliders_color,...
    'Value', a_m, 'min', min_a, 'max', max_a, 'SliderStep', [0.01/(max_a-min_a) 0.1/(max_a-min_a)]);
Slider_a.Units = "normalized";
addlistener(Slider_a, 'Value', 'PostSet', @callbackfn_a);
movegui(FigH, 'center')

    function callbackfn_a(~, eventdata)
    num_a          = get(eventdata.AffectedObject, 'Value');
    if num_a >= 1; num_a = round(num_a,3,"significant"); else; num_a = round(num_a,2,"significant"); end

    if num_b==0 && num_phi==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-phi_m) - b_m.*sin(alpha_e).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-phi_m) - b_m.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-phi_m) + b_m.*sin(theta).*cos(-phi_m);

    elseif num_b==0 && num_phi==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-phi_m) - b_m.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-phi_m) - b_m.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-phi_m) + b_m.*sin(theta).*cos(-phi_m);

    elseif num_b==0 && num_phi~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-num_phi) - b_m.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - b_m.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + b_m.*sin(theta).*cos(-num_phi);

    elseif num_b==0 && num_phi~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - b_m.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - b_m.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + b_m.*sin(theta).*cos(-num_phi);

    elseif num_b~=0 && num_phi==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-phi_m) - num_b.*sin(alpha_e).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-phi_m) - num_b.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-phi_m) + num_b.*sin(theta).*cos(-phi_m);

    elseif num_b~=0 && num_phi==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-phi_m) - num_b.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-phi_m) - num_b.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-phi_m) + num_b.*sin(theta).*cos(-phi_m);

    elseif num_b~=0 && num_phi~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-num_phi) - num_b.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);

    elseif num_b~=0 && num_phi~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);
    end

    if num_thickness == 0
        Line_shifted.XData = LineH.XData + shift;
    else
        Line_shifted.XData = LineH.XData + num_thickness;
    end
    Line_shifted.YData = LineH.YData;
    Fill_shifted.XData = Line_shifted.XData;
    Fill_shifted.YData = Line_shifted.YData;

    x_inf = min(LineH.XData) - ((x_b2-min(LineH.XData))/10);
    x_sup = x_b2;
    ax.XLim = [x_inf x_sup];
    y_sup = max(LineH.YData);
    y_inf = min(LineH.YData);
    ax.YLim = [y_inf y_sup];
    TextH_a.String = "a = " + num2str(num_a);
    end


%% b SLIDER 

TextH_b = uicontrol('style','text', 'FontSize', 10, ...
    'BackgroundColor',background_color, ...
    'position',[left_v start_bottom_v-delta width_v height_v]);
TextH_b.String = "b = " + num2str(b_m);
TextH_b.Units = "normalized";

NameSlider_b = uicontrol('style','text', 'tag', 'rollover2', 'FontSize', 11,'FontWeight','bold', ...
    'BackgroundColor',background_color, ...
    'position',[left_sn start_bottom_sn-delta width_sn height_sn],'ToolTipString','ellipse vertical semi-axis, i.e. height of the breast profile');
NameSlider_b.String = 'b';
NameSlider_b.Units = "normalized";

min_b = min(b);
if min_b >= 1; min_b = round(min_b,3,"significant"); else; min_b = round(min_b,2,"significant"); end
MinSlider_b = uicontrol('style','text', 'FontSize', size_m, ...
    'BackgroundColor',background_color, ...
    'position',[left_min start_bottom_m-delta width_m height_m]);
MinSlider_b.String = {"min = " + min_b};
MinSlider_b.Units = "normalized";

max_b = max(b);
if max_b >= 1; max_b = round(max_b,3,"significant"); else; max_b = round(max_b,2,"significant"); end
MaxSlider_b = uicontrol('style','text', 'FontSize', size_m, ...
    'BackgroundColor',background_color, ...
    'position',[left_max start_bottom_m-delta width_m height_m]);
MaxSlider_b.String = {"max = " + max_b};
MaxSlider_b.Units = "normalized";

Slider_b = uicontrol('style','slider','position',[left_s start_bottom_s-delta width_s height_s],...
    'BackgroundColor',sliders_color,...
    'Value', b_m, 'min', min_b, 'max', max_b, 'SliderStep', [0.01/(max_b-min_b) 0.1/(max_b-min_b)]);
Slider_b.Units = "normalized";
addlistener(Slider_b, 'Value', 'PostSet', @callbackfn_b);
movegui(FigH, 'center')

    function callbackfn_b(~, eventdata)
    num_b          = get(eventdata.AffectedObject, 'Value');
    if num_b >= 1; num_b = round(num_b,3,"significant"); else; num_b = round(num_b,2,"significant"); end

    if num_a==0 && num_phi==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-phi_m) - num_b.*sin(alpha_e).*sin(-phi_m);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-phi_m) - num_b.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-phi_m) + num_b.*sin(theta).*cos(-phi_m);

    elseif num_a==0 && num_phi==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-phi_m) - num_b.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-phi_m) - num_b.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-phi_m) + num_b.*sin(theta).*cos(-phi_m);

    elseif num_a==0 && num_phi~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-num_phi) - num_b.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);

    elseif num_a==0 && num_phi~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);

    elseif num_a~=0 && num_phi==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-phi_m) - num_b.*sin(alpha_e).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-phi_m) - num_b.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-phi_m) + num_b.*sin(theta).*cos(-phi_m);

    elseif num_a~=0 && num_phi==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-phi_m) - num_b.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-phi_m) - num_b.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-phi_m) + num_b.*sin(theta).*cos(-phi_m);

    elseif num_a~=0 && num_phi~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-num_phi) - num_b.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);

    elseif num_a~=0 && num_phi~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);
    end
    
    if num_thickness == 0
        Line_shifted.XData = LineH.XData + shift;
    else
        Line_shifted.XData = LineH.XData + num_thickness;
    end
    Line_shifted.YData = LineH.YData;
    Fill_shifted.XData = Line_shifted.XData;
    Fill_shifted.YData = Line_shifted.YData;

    x_inf = min(LineH.XData) - ((x_b2-min(LineH.XData))/10);
    x_sup = x_b2;
    ax.XLim = [x_inf x_sup];
    y_sup = max(LineH.YData);
    y_inf = min(LineH.YData);
    ax.YLim = [y_inf y_sup];
    TextH_b.String = "b = " + num2str(num_b);
    end


%% phi SLIDER

phi_deg = rad2deg(phi_m);
if (phi_deg >= 10) && (phi_deg<=-10); phi_deg = round(phi_deg,3,"significant"); else; phi_deg = round(phi_deg,2,"significant"); end

TextH_phi = uicontrol('style','text','FontSize', 10, ...
    'BackgroundColor',background_color, ...
    'position',[left_v start_bottom_v-2*delta width_v height_v]);
TextH_phi.String = "phi = " + phi_deg + '°';
TextH_phi.Units = "normalized";

NameSlider_phi = uicontrol('style','text','tag','rollover3', 'FontSize', 11,'FontWeight','bold', ...
    'BackgroundColor',background_color, ...
    'position',[left_sn start_bottom_sn-2*delta width_sn height_sn],'ToolTipString','ellipse orientation angle, i.e. breast profile orientation');
NameSlider_phi.String = 'phi';
NameSlider_phi.Units = "normalized";

min_phi = min(phi);
min_phi_deg = rad2deg(min_phi);
if min_phi_deg >= 1; min_phi_deg = round(min_phi_deg,3,"significant"); else; min_phi_deg = round(min_phi_deg,2,"significant"); end
MinSlider_phi = uicontrol('style','text', 'FontSize', size_m, ...
    'BackgroundColor',background_color, ...
    'position',[left_min start_bottom_m-2*delta width_m height_m]);
MinSlider_phi.String = {"min = " + min_phi_deg + '°'};
MinSlider_phi.Units = "normalized";

max_phi = max(phi);
max_phi_deg = rad2deg(max_phi);
if max_phi_deg >= 100; max_phi_deg = round(max_phi_deg,3,"significant"); else; max_phi_deg = round(max_phi_deg,2,"significant"); end
MaxSlider_phi = uicontrol('style','text','FontSize', size_m, ...
    'BackgroundColor',background_color, ...
    'position',[left_max start_bottom_m-2*delta width_m height_m]);
MaxSlider_phi.String = {"max = " + max_phi_deg + '°'};
MaxSlider_phi.Units = "normalized";

Slider_phi = uicontrol('style','slider','position',[left_s start_bottom_s-2*delta width_s height_s], ...
    'BackgroundColor',sliders_color,...
    'Value', phi_m, 'min', min_phi, 'max', max_phi, 'SliderStep', [(max_phi-min_phi)/1000 0.1/(max_phi-min_phi)]);
Slider_phi.Units = "normalized";
addlistener(Slider_phi, 'Value', 'PostSet', @callbackfn_phi);
movegui(FigH, 'center')

    function callbackfn_phi(~, eventdata)
    num_phi          = get(eventdata.AffectedObject, 'Value');

    if num_a==0 && num_b==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-num_phi) - b_m.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-num_phi) - b_m.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-num_phi) + b_m.*sin(theta).*cos(-num_phi);

    elseif num_a==0 && num_b==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-num_phi) - b_m.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-num_phi) - b_m.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-num_phi) + b_m.*sin(theta).*cos(-num_phi);

    elseif num_a==0 && num_b~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-num_phi) - num_b.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);

    elseif num_a==0 && num_b~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);

    elseif num_a~=0 && num_b==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-num_phi) - b_m.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - b_m.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + b_m.*sin(theta).*cos(-num_phi);

    elseif num_a~=0 && num_b==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - b_m.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - b_m.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + b_m.*sin(theta).*cos(-num_phi);

    elseif num_a~=0 && num_b~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-num_phi) - num_b.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = alpha_e + (alpha-alpha_e)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);

    elseif num_a~=0 && num_b~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);
    end
    
    if num_thickness == 0
        Line_shifted.XData = LineH.XData + shift;
    else
        Line_shifted.XData = LineH.XData + num_thickness;
    end
    Line_shifted.YData = LineH.YData;
    Fill_shifted.XData = Line_shifted.XData;
    Fill_shifted.YData = Line_shifted.YData;

    x_inf = min(LineH.XData) - ((x_b2-min(LineH.XData))/10);
    x_sup = x_b2;
    ax.XLim = [x_inf x_sup];
    y_sup = max(LineH.YData);
    y_inf = min(LineH.YData);
    ax.YLim = [y_inf y_sup];

    num3_deg = rad2deg(num_phi);
    if (num3_deg >= 10) && (num3_deg <= -10); num3_deg = round(num3_deg,2); else; num3_deg = round(num3_deg, 1); end
    TextH_phi.String = "phi = " + num2str(num3_deg) + "°";
    end



%% End SLIDER

alpha_e_deg = rad2deg(alpha_e);
if alpha_e_deg >= 100; alpha_e_deg = round(alpha_e_deg,3,"significant"); else; alpha_e_deg = round(alpha_e_deg,2,"significant"); end

TextH_end = uicontrol('style','text','FontSize', 10,...
    'BackgroundColor',background_color, ...
    'position',[left_v start_bottom_v-3*delta width_v height_v]);
TextH_end.String = "End = " + num2str(alpha_e_deg) + "°";
TextH_end.Units = "normalized";

NameSlider_end = uicontrol('style','text','tag', 'rollover4', 'FontSize', 11,'FontWeight','bold',...
    'BackgroundColor',background_color, ...
    'position',[left_sn start_bottom_sn-3*delta width_sn height_sn],'ToolTipString','angle between x axis and ellipse start, i.e. angle between x axis and breast profile start');
NameSlider_end.String = 'End';
NameSlider_end.Units = "normalized";

min_end = min(Alpha_e);
min_end_deg = rad2deg(min_end);
if min_end_deg >= 100; min_end_deg = round(min_end_deg,3,"significant"); else; min_end_deg = round(min_end_deg,2,"significant"); end
MinSlider_end = uicontrol('style','text', 'FontSize', size_m,...
    'BackgroundColor',background_color, ...
    'position',[left_min start_bottom_m-3*delta width_m height_m]);
MinSlider_end.String = {"min = " + min_end_deg + "°"};
MinSlider_end.Units = "normalized";

max_end = max(Alpha_e);
max_end_deg = rad2deg(max_end);
if max_end_deg >= 100; max_end_deg = round(max_end_deg,3,"significant"); else; max_end_deg = round(max_end_deg,2,"significant"); end
MaxSlider_end = uicontrol('style','text', 'FontSize', size_m,...
    'BackgroundColor',background_color, ...
    'position',[left_max start_bottom_m-3*delta width_m height_m]);
MaxSlider_end.String = {"max = " + max_end_deg + "°"};
MaxSlider_end.Units = "normalized";

Slider_end = uicontrol('style','slider','position',[left_s start_bottom_s-3*delta width_s height_s],...
    'BackgroundColor',sliders_color,...
    'Value', alpha_e, 'min', min_end, 'max', max_end);
Slider_end.Units = "normalized";
addlistener(Slider_end, 'Value', 'PostSet', @callbackfn_end);
movegui(FigH, 'center')

    function callbackfn_end(~, eventdata)
    num_end          = get(eventdata.AffectedObject, 'Value');

    if num_a==0 && num_b==0 && num_phi==0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-phi_m) - b_m.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end 
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-phi_m) - b_m.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-phi_m) + b_m.*sin(theta).*cos(-phi_m);

    elseif num_a==0 && num_b==0 && num_phi~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-num_phi) - b_m.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end  
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-num_phi) - b_m.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-num_phi) + b_m.*sin(theta).*cos(-num_phi);

    elseif num_a==0 && num_b~=0 && num_phi==0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-phi_m) - num_b.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end  
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-phi_m) - num_b.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-phi_m) + num_b.*sin(theta).*cos(-phi_m);

    elseif num_a==0 && num_b~=0 && num_phi~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end  
        PointN.XData = X0_m + a_m.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);

    elseif num_a~=0 && num_b==0 && num_phi==0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-phi_m) - b_m.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end  
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-phi_m) - b_m.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-phi_m) + b_m.*sin(theta).*cos(-phi_m);

    elseif num_a~=0 && num_b==0 && num_phi~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - b_m.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end  
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - b_m.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + b_m.*sin(theta).*cos(-num_phi);

    elseif num_a~=0 && num_b~=0 && num_phi==0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-phi_m) - num_b.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end  
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-phi_m) - num_b.*sin(theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-phi_m) + num_b.*sin(theta).*cos(-phi_m);

    elseif num_a~=0 && num_b~=0 && num_phi~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);
        FillH.XData = LineH.XData;
        FillH.YData = LineH.YData;

        if num_theta==0
            theta = num_end + (alpha-num_end)/2; 
        else
            theta = num_theta;
        end  
        PointN.XData = X0_m + num_a.*cos(theta).*cos(-num_phi) - num_b.*sin(theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(theta).*sin(-num_phi) + num_b.*sin(theta).*cos(-num_phi);
    end

    if num_thickness == 0
        Line_shifted.XData = LineH.XData + shift;
    else
        Line_shifted.XData = LineH.XData + num_thickness;
    end
    Line_shifted.YData = LineH.YData;
    Fill_shifted.XData = Line_shifted.XData;
    Fill_shifted.YData = Line_shifted.YData;

    x_inf = min(LineH.XData) - ((x_b2-min(LineH.XData))/10);
    x_sup = x_b2;
    ax.XLim = [x_inf x_sup];
    y_sup = max(LineH.YData);
    y_inf = min(LineH.YData);
    ax.YLim = [y_inf y_sup];

    num7_deg = rad2deg(num_end);
    if num7_deg >= 100; num7_deg = round(num7_deg,3,"significant"); else; num7_deg = round(num7_deg,2,"significant"); end
    TextH_end.String = "End = " + num2str(num7_deg) + "°";
    end


%% theta SLIDER

theta_m_deg = rad2deg(theta_m);
if theta_m_deg >= 100; theta_m_deg = round(theta_m_deg,3,"significant"); else; theta_m_deg = round(theta_m_deg,2,"significant"); end

TextH_theta = uicontrol('style','text', 'FontSize', 10, ...
    'BackgroundColor',background_color, ...
    'position',[left_v start_bottom_v-4*delta width_v height_v]);
TextH_theta.String = "theta = " + num2str(theta_m_deg) + '°';
TextH_theta.Units = "normalized";

NameSlider_theta = uicontrol('style','text','tag','rollover5', 'FontSize', 11,'FontWeight','bold', ...
    'BackgroundColor',background_color, ...
    'position',[left_sn start_bottom_sn-4*delta width_sn height_sn],'ToolTipString','angle between ellipse horizontal semi-axis and nipple');
NameSlider_theta.String = 'theta';
NameSlider_theta.Units = "normalized";

min_theta = theta_m - pi/3;
min_theta_deg = rad2deg(min_theta);
if min_theta_deg >= 100; min_theta_deg = round(min_theta_deg,3,"significant"); else; min_theta_deg = round(min_theta_deg,2,"significant"); end
MinSlider_theta = uicontrol('style','text', 'FontSize', size_m,...
    'BackgroundColor',background_color, ...
    'position',[left_min start_bottom_m-4*delta width_m height_m]);
MinSlider_theta.String = {"min = " + min_theta_deg + "°"};
MinSlider_theta.Units = "normalized";

max_theta = theta_m + pi/3;
max_theta_deg = rad2deg(max_theta);
if max_theta_deg >= 100; max_theta_deg = round(max_theta_deg,3,"significant"); else; max_theta_deg = round(max_theta_deg,2,"significant"); end
MaxSlider_theta = uicontrol('style','text', 'FontSize', size_m,...
    'BackgroundColor',background_color, ...
    'position',[left_max start_bottom_m-4*delta width_m height_m]);
MaxSlider_theta.String = {"max = " + max_theta_deg + "°"};
MaxSlider_theta.Units = "normalized";


Slider_theta = uicontrol('style','slider','position',[left_s start_bottom_s-4*delta width_s height_s],...
    'BackgroundColor',sliders_color,...
    'Value', theta_m, 'min', min_theta, 'max', max_theta);
Slider_theta.Units = "normalized";
addlistener(Slider_theta, 'Value', 'PostSet', @callbackfn_theta);
movegui(FigH, 'center')

    function callbackfn_theta(~, eventdata)
    num_theta          = get(eventdata.AffectedObject, 'Value');
    
    if num_a==0 && num_b==0 && num_phi==0 
        PointN.XData = X0_m + a_m.*cos(num_theta).*cos(-phi_m) - b_m.*sin(num_theta).*sin(-phi_m);
        PointN.YData = Y0_m + a_m.*cos(num_theta).*sin(-phi_m) + b_m.*sin(num_theta).*cos(-phi_m);

    elseif num_a==0 && num_b==0 && num_phi~=0 
        PointN.XData = X0_m + a_m.*cos(num_theta).*cos(-num_phi) - b_m.*sin(num_theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(num_theta).*sin(-num_phi) + b_m.*sin(num_theta).*cos(-num_phi);

    elseif num_a==0 && num_b~=0 && num_phi==0
        PointN.XData = X0_m + a_m.*cos(num_theta).*cos(-phi_m) - num_b.*sin(num_theta).*sin(-phi_m);
        PointN.YData = Y0_m + a_m.*cos(num_theta).*sin(-phi_m) + num_b.*sin(num_theta).*cos(-phi_m);

    elseif num_a==0 && num_b~=0 && num_phi~=0
        PointN.XData = X0_m + a_m.*cos(num_theta).*cos(-num_phi) - num_b.*sin(num_theta).*sin(-num_phi);
        PointN.YData = Y0_m + a_m.*cos(num_theta).*sin(-num_phi) + num_b.*sin(num_theta).*cos(-num_phi);

    elseif num_a~=0 && num_b==0 && num_phi==0
        PointN.XData = X0_m + num_a.*cos(num_theta).*cos(-phi_m) - b_m.*sin(num_theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(num_theta).*sin(-phi_m) + b_m.*sin(num_theta).*cos(-phi_m);

    elseif num_a~=0 && num_b==0 && num_phi~=0
        PointN.XData = X0_m + num_a.*cos(num_theta).*cos(-num_phi) - b_m.*sin(num_theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(num_theta).*sin(-num_phi) + b_m.*sin(num_theta).*cos(-num_phi);

    elseif num_a~=0 && num_b~=0 && num_phi==0
        PointN.XData = X0_m + num_a.*cos(num_theta).*cos(-phi_m) - num_b.*sin(num_theta).*sin(-phi_m);
        PointN.YData = Y0_m + num_a.*cos(num_theta).*sin(-phi_m) + num_b.*sin(num_theta).*cos(-phi_m);

    elseif num_a~=0 && num_b~=0 && num_phi~=0 
        PointN.XData = X0_m + num_a.*cos(num_theta).*cos(-num_phi) - num_b.*sin(num_theta).*sin(-num_phi);
        PointN.YData = Y0_m + num_a.*cos(num_theta).*sin(-num_phi) + num_b.*sin(num_theta).*cos(-num_phi);
    end

    num5_deg = rad2deg(num_theta);
    if num5_deg >= 100; num5_deg = round(num5_deg,3,"significant"); else; num5_deg = round(num5_deg,2,"significant"); end
    TextH_theta.String = "theta = " + num2str(num5_deg) + "°";
    end


%% SKIN THICKNESS CHECKBOX

Button_skin_thickness = uicontrol('style','checkbox','position',[left_s start_bottom_s-5*delta width_s/2 height_s], ...
    'BackgroundColor',color_st,...
    'String', '  Skin Thickness', ...
    'FontSize', 11,'FontWeight','bold', 'Value', 0,'ToolTipString','if checked it inserts skin thickness and enables the thickness slider');
Button_skin_thickness.Units = "normalized";
addlistener(Button_skin_thickness, 'Value', 'PostSet', @callbackfn_skin_thickness);
movegui(FigH, 'center')


    function callbackfn_skin_thickness(~, eventdata)
    num_skin_thickness          = get(eventdata.AffectedObject, 'Value');
    if num_skin_thickness ~= 0
        LineH.Color = color_st;
        FillH.FaceColor = color_st;
        FillH.EdgeColor = color_st;
        Line_shifted.Color = color_b;
        Fill_shifted.FaceColor = color_b;
        Fill_shifted.EdgeColor = color_b;
        set(Slider_thickness, 'Enable', 'on');
    else
        LineH.Color = color_b;
        FillH.FaceColor = color_b;
        FillH.EdgeColor = color_b;
        Line_shifted.Color = 'none';
        Fill_shifted.FaceColor = 'none';
        Fill_shifted.EdgeColor = 'none';
        set(Slider_thickness, 'Enable', 'off');
    end

end


%% THICKNESS SLIDER

Slider_thickness = uicontrol('style','slider','position',[left_s+width_s/3 start_bottom_s-5*delta 2*width_s/3 height_s],...
    'BackgroundColor',sliders_color,...
    'Value', shift, 'min', 0.01, 'max', 0.15, 'Enable','off');
Slider_thickness.Units = "normalized";
addlistener(Slider_thickness, 'Value', 'PostSet', @callbackfn_thickness);
movegui(FigH, 'center')

    function callbackfn_thickness(~, eventdata)
        num_thickness          = get(eventdata.AffectedObject, 'Value');

    if num_a==0 && num_b==0 && num_phi==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-phi_m) - b_m.*sin(alpha_e).*sin(-phi_m);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);

    elseif num_a==0 && num_b==0 && num_phi==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-phi_m) - b_m.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);

    elseif num_a==0 && num_b==0 && num_phi~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-num_phi) - b_m.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);

    elseif num_a==0 && num_b==0 && num_phi~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-num_phi) - b_m.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);

    elseif num_a==0 && num_b~=0 && num_phi==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-phi_m) - num_b.*sin(alpha_e).*sin(-phi_m);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);

    elseif num_a==0 && num_b~=0 && num_phi==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-phi_m) - num_b.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);

    elseif num_a==0 && num_b~=0 && num_phi~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + a_m.*cos(alpha_e).*cos(-num_phi) - num_b.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);

    elseif num_a==0 && num_b~=0 && num_phi~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + a_m.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + a_m.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + a_m.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + a_m.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);

    elseif num_a~=0 && num_b==0 && num_phi==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-phi_m) - b_m.*sin(alpha_e).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);

    elseif num_a~=0 && num_b==0 && num_phi==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-phi_m) - b_m.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - b_m.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - b_m.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + b_m.*sin(t).*cos(-phi_m);

    elseif num_a~=0 && num_b==0 && num_phi~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-num_phi) - b_m.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);

    elseif num_a~=0 && num_b==0 && num_phi~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - b_m.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - b_m.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - b_m.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + b_m.*sin(t).*cos(-num_phi);

    elseif num_a~=0 && num_b~=0 && num_phi==0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-phi_m) - num_b.*sin(alpha_e).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);

    elseif num_a~=0 && num_b~=0 && num_phi==0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-phi_m) - num_b.*sin(num_end).*sin(-phi_m);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-phi_m) - num_b.*sin(alpha).*sin(-phi_m);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-phi_m) - num_b.*sin(t).*sin(-phi_m);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-phi_m) + num_b.*sin(t).*cos(-phi_m);

    elseif num_a~=0 && num_b~=0 && num_phi~=0 && num_end==0
        alpha = alpha_e + offset;
        x_b1 = X0_m + num_a.*cos(alpha_e).*cos(-num_phi) - num_b.*sin(alpha_e).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(alpha_e,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);

    elseif num_a~=0 && num_b~=0 && num_phi~=0 && num_end~=0
        alpha = num_end + offset;
        x_b1 = X0_m + num_a.*cos(num_end).*cos(-num_phi) - num_b.*sin(num_end).*sin(-num_phi);
        x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            while abs(x_b1-x_b2) >= soglia
                alpha = alpha + 0.01;
                x_b2 = X0_m + num_a.*cos(alpha).*cos(-num_phi) - num_b.*sin(alpha).*sin(-num_phi);
            end
        t = linspace(num_end,alpha);
        LineH.XData = X0_m + num_a.*cos(t).*cos(-num_phi) - num_b.*sin(t).*sin(-num_phi);
        LineH.YData = Y0_m + num_a.*cos(t).*sin(-num_phi) + num_b.*sin(t).*cos(-num_phi);

    end

       LineH.Color = color_st;
       FillH.FaceColor = color_st;
       FillH.EdgeColor = color_st;
       Line_shifted.XData = LineH.XData + num_thickness;
       Line_shifted.YData = LineH.YData;

       Fill_shifted.XData = Line_shifted.XData;
       Fill_shifted.YData = Line_shifted.YData;
       Line_shifted.Color = color_b;
       Fill_shifted.FaceColor = color_b;
       Fill_shifted.EdgeColor = color_b;

    end



%% FIBROGLANDULAR TISSUE PUSHBOTTON

TextH_glandular_tissue = uicontrol('style','text', 'FontSize', 9, ...
    'BackgroundColor',background_color, ...
    'position',[left_sn+width_s/6+30 start_bottom_s-5.92*delta-height_s-5 2*width_s/3 height_s+5]);
TextH_glandular_tissue.String = "click above to draw fibroglandular tissue outline";
TextH_glandular_tissue.Units = "normalized";

Button_glandular_tissue = uicontrol('style','pushbutton','position',[left_sn+width_s/6+30 start_bottom_s-5.92*delta 2*width_s/3 height_s], ...
    'BackgroundColor',color_gt,...
    'String', 'Draw Fibrolandular Tissue Outline', 'Enable','off', ...
    'FontSize', 11,'FontWeight','bold', 'Value', 0,'ToolTipString','with this button you can draw freehand the fibroglandular tissue outline');
Button_glandular_tissue.Units = "normalized";
addlistener(Button_glandular_tissue, 'Value', 'PostSet', @callbackfn_glandular_tissue);
movegui(FigH, 'center')

glandular_tissue = 0; 
    function callbackfn_glandular_tissue(~, ~)
    TextH_glandular_tissue.String = "drag and drop on plot to draw fibroglandular tissue outline";
    glandular_tissue = drawfreehand('Color',color_gt, 'FaceAlpha', 1, 'DrawingArea','unlimited');
    TextH_glandular_tissue.String = "click above to draw fibroglandular tissue outline";
    set(Button_glandular_tissue,'Enable','off');
    TextH_glandular_tissue.String = "only one fibroglandular tissue region";
    end




%% SOLID BENIGN TUMORS PUSHBOTTON

TextH_benign = uicontrol('style','text', 'FontSize', 9, ...
    'BackgroundColor',background_color, ...
    'position',[left_sn+10 start_bottom_s-7.14*delta-height_s ((60+width_s)/2)-20 height_s]);
TextH_benign.String = "click above to add benign tumor on plot";
TextH_benign.Units = "normalized";

Button_benign = uicontrol('style','pushbutton','position',[left_sn+10 start_bottom_s-7.14*delta ((60+width_s)/2)-20 height_s], ...
    'BackgroundColor',color_bm,...
    'String', 'Insert Solid Benign Tumor','Enable', 'off', ...
    'FontSize', 11,'FontWeight','bold', 'Value', 0,'ToolTipString','with this button you can insert a circular solid benign tumor');
Button_benign.Units = "normalized";
addlistener(Button_benign, 'Value', 'PostSet', @callbackfn_benign);
movegui(FigH, 'center')

count_benign = 0;

benign_tumor1 = 0; benign_tumor2 = 0; benign_tumor3 = 0; benign_tumor4 = 0; benign_tumor5 = 0; benign_tumor6 = 0; benign_tumor7 = 0; benign_tumor8 = 0; benign_tumor9 = 0; benign_tumor10 = 0;
benign_tumor11 = 0; benign_tumor12 = 0; benign_tumor13 = 0; benign_tumor14 = 0; benign_tumor15 = 0; benign_tumor16 = 0; benign_tumor17 = 0; benign_tumor18 = 0; benign_tumor19 = 0; benign_tumor20 = 0;
benign_tumor21 = 0; benign_tumor22 = 0; benign_tumor23 = 0; benign_tumor24 = 0; benign_tumor25 = 0; benign_tumor26 = 0; benign_tumor27 = 0; benign_tumor28 = 0; benign_tumor29 = 0; benign_tumor30 = 0;
benign_tumor31 = 0; benign_tumor32 = 0; benign_tumor33 = 0; benign_tumor34 = 0; benign_tumor35 = 0; benign_tumor36 = 0; benign_tumor37 = 0; benign_tumor38 = 0; benign_tumor39 = 0; benign_tumor40 = 0;
benign_tumor41 = 0; benign_tumor42 = 0; benign_tumor43 = 0; benign_tumor44 = 0; benign_tumor45 = 0; benign_tumor46 = 0; benign_tumor47 = 0; benign_tumor48 = 0; benign_tumor49 = 0; benign_tumor50 = 0;


function callbackfn_benign(~, ~)
    count_benign = count_benign+1;
    if count_benign > 50
        close(FigH)
        return
    end
    TextH_benign.String = "drag and drop on plot to draw tumor";
    eval(sprintf("benign_tumor%d = drawellipse('Color', color_bm, 'FaceAlpha', 1, 'DrawingArea','unlimited');", count_benign))
    TextH_benign.String = "click above to add benign tumor on plot";
end



%% SOLID MALIGNANT TUMORS PUSHBUTTON

TextH_malignant = uicontrol('style','text', 'FontSize', 9, ...
    'BackgroundColor',background_color, ...
    'position',[left_sn+((60+width_s)/2)+10 start_bottom_s-7.14*delta-height_s ((60+width_s)/2)-20 height_s]);
TextH_malignant.String = "click above to add malignant tumor on plot";
TextH_malignant.Units = "normalized";

Button_malignant = uicontrol('style','pushbutton','position',[left_sn+((60+width_s)/2)+10 start_bottom_s-7.14*delta ((60+width_s)/2)-20 height_s], ...
    'BackgroundColor',color_mm,...
    'String', 'Insert Solid Malignant Tumor', 'Enable', 'off', ...
    'FontSize', 11,'FontWeight','bold', 'Value', 0,'ToolTipString','with this button you can insert a circular solid malignant tumor');
Button_malignant.Units = "normalized";
addlistener(Button_malignant, 'Value', 'PostSet', @callbackfn_malignant);
movegui(FigH, 'center')

count_malignant = 0;

malignant_tumor1 = 0; malignant_tumor2 = 0; malignant_tumor3 = 0; malignant_tumor4 = 0; malignant_tumor5 = 0; malignant_tumor6 = 0; malignant_tumor7 = 0; malignant_tumor8 = 0; malignant_tumor9 = 0; malignant_tumor10 = 0;
malignant_tumor11 = 0; malignant_tumor12 = 0; malignant_tumor13 = 0; malignant_tumor14 = 0; malignant_tumor15 = 0; malignant_tumor16 = 0; malignant_tumor17 = 0; malignant_tumor18 = 0; malignant_tumor19 = 0; malignant_tumor20 = 0;
malignant_tumor21 = 0; malignant_tumor22 = 0; malignant_tumor23 = 0; malignant_tumor24 = 0; malignant_tumor25 = 0; malignant_tumor26 = 0; malignant_tumor27 = 0; malignant_tumor28 = 0; malignant_tumor29 = 0; malignant_tumor30 = 0;
malignant_tumor31 = 0; malignant_tumor32 = 0; malignant_tumor33 = 0; malignant_tumor34 = 0; malignant_tumor35 = 0; malignant_tumor36 = 0; malignant_tumor37 = 0; malignant_tumor38 = 0; malignant_tumor39 = 0; malignant_tumor40 = 0;
malignant_tumor41 = 0; malignant_tumor42 = 0; malignant_tumor43 = 0; malignant_tumor44 = 0; malignant_tumor45 = 0; malignant_tumor46 = 0; malignant_tumor47 = 0; malignant_tumor48 = 0; malignant_tumor49 = 0; malignant_tumor50 = 0;

function callbackfn_malignant(~, ~)
    count_malignant = count_malignant + 1;
    if count_malignant > 50
        close(FigH)
        return
    end
    TextH_malignant.String = "drag and drop on plot to draw tumor";
    eval(sprintf("malignant_tumor%d = drawellipse('Color', color_mm, 'FaceAlpha', 1, 'DrawingArea','unlimited');", count_malignant));
    TextH_malignant.String = "click above to add malignant tumor on plot";
end

TextH_warning = uicontrol('style','text', 'FontSize', 10, ...
    'BackgroundColor',background_color, ...
    'position',[left_p start_bottom_s-7.95*delta width_p height_s]);
TextH_warning.String = "WARNING! If you go back to the panel 'Shape & Skin thickness' glandular tissue and tumors will be deleted";
TextH_warning.ForegroundColor = 'red';
TextH_warning.Units = "normalized";


%% COLORSET SWITCH

Button_colorset1 = uicontrol('style','togglebutton','position',[left_sn+10 start_bottom_s-8.8*delta 80 height_cb], ...
    'BackgroundColor',background_color,...
    'String', 'Colorset 1', ...
    'FontSize', 11,'FontWeight','bold', 'Value', 1);
Button_colorset1.Units = "normalized";
addlistener(Button_colorset1, 'Value', 'PostSet', @callbackfn_colorset1);
movegui(FigH, 'center')

function callbackfn_colorset1(~, eventdata)
    num_colorset1          = get(eventdata.AffectedObject, 'Value');
    if num_colorset1 == 1
        set(Button_colorset2, 'Value', 0);
        color_n = [176 196 222]/255; % lightsteelblue, nipple color
        color_gt = [135 206 250]/255; % lightskyblue, glandular tissue color
        color_st = [70 130 180]/255; % steelblue, skin thickness color
        color_b = [100 149 237]/255; % cornflowerblue, color of the rest of the breast
        color_bm = [50 205 50]/255; % limegreen, solid benign tumors color
        color_mm = [178 34 34]/255; % firebrick, solid malignant tumors color

        PointN.Color = color_n;
        PointN.MarkerFaceColor = color_n;

        LineH.Color = color_b;
        FillH.FaceColor = color_b;
        FillH.EdgeColor = color_b;

        glandular_tissue.Color = color_gt;

        if count_malignant ~= 0
            for i_m = 1:count_malignant
                if (eval(sprintf("isgraphics(malignant_tumor%d);",i_m))) == true
                    eval(sprintf("malignant_tumor%d.Color = color_mm;",i_m))
                end
            end
        end
        if count_benign ~= 0
            for i_b = 1:count_benign
                if (eval(sprintf("isgraphics(benign_tumor%d);",i_b))) == true
                   eval(sprintf("benign_tumor%d.Color = color_bm;",i_b)) 
                end 
            end
        end

        if num_skin_thickness ~= 0
            LineH.Color = color_st;
            FillH.FaceColor = color_st;
            FillH.EdgeColor = color_st;
            Line_shifted.Color = color_b;
            Fill_shifted.FaceColor = color_b;
            Fill_shifted.EdgeColor = color_b;
        else
            LineH.Color = color_b;
            FillH.FaceColor = color_b;
            FillH.EdgeColor = color_b;
            Line_shifted.Color = 'none';
            Fill_shifted.FaceColor = 'none';
            Fill_shifted.EdgeColor = 'none';
        end

    else
        set(Button_colorset2, 'Value', 1);
        color_n = [0 0 100]/255; % nipple color
        color_gt = [0 0 150]/255; % glandular tissue color
        color_st = [0 0 200]/255; % skin thickness color
        color_b = [0 0 255]/255; % color of the rest of the breast
        color_bm = [0 255 0]/255; % benign tumors color
        color_mm = [255 0 0]/255; % malignant tumors color

        PointN.Color = color_n;
        PointN.MarkerFaceColor = color_n;

        LineH.Color = color_b;
        FillH.FaceColor = color_b;
        FillH.EdgeColor = color_b;

        glandular_tissue.Color = color_gt;

        if count_malignant ~= 0
            for i_m = 1:count_malignant
                if (eval(sprintf("isgraphics(malignant_tumor%d);",i_m))) == true
                    eval(sprintf("malignant_tumor%d.Color = color_mm;",i_m))
                end
            end
        end
        if count_benign ~= 0
            for i_b = 1:count_benign
                if (eval(sprintf("isgraphics(benign_tumor%d);",i_b))) == true
                   eval(sprintf("benign_tumor%d.Color = color_bm;",i_b)) 
                end 
            end
        end

        if num_skin_thickness ~= 0
            LineH.Color = color_st;
            FillH.FaceColor = color_st;
            FillH.EdgeColor = color_st;
            Line_shifted.Color = color_b;
            Fill_shifted.FaceColor = color_b;
            Fill_shifted.EdgeColor = color_b;
        else
            LineH.Color = color_b;
            FillH.FaceColor = color_b;
            FillH.EdgeColor = color_b;
            Line_shifted.Color = 'none';
            Fill_shifted.FaceColor = 'none';
            Fill_shifted.EdgeColor = 'none';
        end
    end
end

Button_colorset2 = uicontrol('style','togglebutton','position',[left_sn+10+80 start_bottom_s-8.8*delta 80 height_cb], ...
    'BackgroundColor',background_color,...
    'String', 'Colorset 2', ...
    'FontSize', 11,'FontWeight','bold', 'Value', 0);
Button_colorset2.Units = "normalized";
addlistener(Button_colorset2, 'Value', 'PostSet', @callbackfn_colorset2);
movegui(FigH, 'center')

function callbackfn_colorset2(~, eventdata)
    num_colorset2          = get(eventdata.AffectedObject, 'Value');
    if num_colorset2 == 0
        set(Button_colorset1, 'Value', 1);
        color_n = [176 196 222]/255; % lightsteelblue, nipple color
        color_gt = [135 206 250]/255; % lightskyblue, glandular tissue color
        color_st = [70 130 180]/255; % steelblue, skin thickness color
        color_b = [100 149 237]/255; % cornflowerblue, color of the rest of the breast
        color_bm = [50 205 50]/255; % limegreen, solid benign tumors color
        color_mm = [178 34 34]/255; % firebrick, solid malignant tumors color

        PointN.Color = color_n;
        PointN.MarkerFaceColor = color_n;

        LineH.Color = color_b;
        FillH.FaceColor = color_b;
        FillH.EdgeColor = color_b;

        glandular_tissue.Color = color_gt;

        if count_malignant ~= 0
            for i_m = 1:count_malignant
                if (eval(sprintf("isgraphics(malignant_tumor%d);",i_m))) == true
                    eval(sprintf("malignant_tumor%d.Color = color_mm;",i_m))
                end
            end
        end
        if count_benign ~= 0
            for i_b = 1:count_benign
                if (eval(sprintf("isgraphics(benign_tumor%d);",i_b))) == true
                   eval(sprintf("benign_tumor%d.Color = color_bm;",i_b)) 
                end 
            end
        end

        if num_skin_thickness ~= 0
            LineH.Color = color_st;
            FillH.FaceColor = color_st;
            FillH.EdgeColor = color_st;
            Line_shifted.Color = color_b;
            Fill_shifted.FaceColor = color_b;
            Fill_shifted.EdgeColor = color_b;
        else
            LineH.Color = color_b;
            FillH.FaceColor = color_b;
            FillH.EdgeColor = color_b;
            Line_shifted.Color = 'none';
            Fill_shifted.FaceColor = 'none';
            Fill_shifted.EdgeColor = 'none';
        end

    else
        set(Button_colorset1, 'Value', 0);
        color_n = [0 0 100]/255; % nipple color
        color_gt = [0 0 150]/255; % glandular tissue color
        color_st = [0 0 200]/255; % skin thickness color
        color_b = [0 0 255]/255; % color of the rest of the breast
        color_bm = [0 255 0]/255; % benign tumors color
        color_mm = [255 0 0]/255; % malignant tumors color

        PointN.Color = color_n;
        PointN.MarkerFaceColor = color_n;

        LineH.Color = color_b;
        FillH.FaceColor = color_b;
        FillH.EdgeColor = color_b;

        glandular_tissue.Color = color_gt;

        if count_malignant ~= 0
            for i_m = 1:count_malignant
                if (eval(sprintf("isgraphics(malignant_tumor%d);",i_m))) == true
                    eval(sprintf("malignant_tumor%d.Color = color_mm;",i_m))
                end
            end
        end
        if count_benign ~= 0
            for i_b = 1:count_benign
                if (eval(sprintf("isgraphics(benign_tumor%d);",i_b))) == true
                   eval(sprintf("benign_tumor%d.Color = color_bm;",i_b)) 
                end 
            end
        end

        if num_skin_thickness ~= 0
            LineH.Color = color_st;
            FillH.FaceColor = color_st;
            FillH.EdgeColor = color_st;
            Line_shifted.Color = color_b;
            Fill_shifted.FaceColor = color_b;
            Fill_shifted.EdgeColor = color_b;
        else
            LineH.Color = color_b;
            FillH.FaceColor = color_b;
            FillH.EdgeColor = color_b;
            Line_shifted.Color = 'none';
            Fill_shifted.FaceColor = 'none';
            Fill_shifted.EdgeColor = 'none';
        end
    end
end



%% SAVE BUTTON

saveButton = uicontrol('style','pushbutton','position',[left_sn+200 start_bottom_s-8.8*delta 100 height_cb], ...
    'BackgroundColor',background_color,...
    'String', 'Save Model', ...
    'FontSize', 12,'FontWeight','bold', 'Value', 0);
saveButton.Units = "normalized";
addlistener(saveButton, 'Value', 'PostSet', @callbackfn_save_button);
movegui(FigH, 'center')
    function callbackfn_save_button(~,~)
        filter = {'*.png';'*.jpg';'*.tif';'*.pdf';'*.eps'};
        [im_filename,im_filepath] = uiputfile(filter);
        if ischar(im_filename)
            exportgraphics(ax,[im_filepath im_filename],'BackgroundColor','black');
        end
    end


%% RESET BUTTON

resetButton = uicontrol('style','pushbutton','position',[left_sn+330 start_bottom_s-8.8*delta 100 height_cb], ...
    'BackgroundColor',background_color,...
    'String', 'Reset', ...
    'FontSize', 12,'FontWeight','bold', 'Value', 0, ...
    'ToolTipString','push if you want to restart the model generation with the current breast shape parameters');
resetButton.Units = "normalized";
addlistener(resetButton, 'Value', 'PostSet', @callbackfn_reset_button);
movegui(FigH, 'center')
    function callbackfn_reset_button(~,~)
            
            
            set(Slider_a, 'Enable', 'on', 'Value', a_m);
            set(Slider_b, 'Enable', 'on', 'Value', b_m);
            set(Slider_phi, 'Enable', 'on', 'Value', phi_m);
            set(Slider_end, 'Enable', 'on', 'Value', alpha_e);
            set(Slider_theta, 'Enable', 'on', 'Value', theta_m);
            set(Button_skin_thickness, 'Enable', 'on');
            set(Slider_thickness, 'Enable', 'off');

            set(Button_glandular_tissue, 'Enable', 'off');
            set(third_checkbox, 'Enable', 'off');
            set(third_checkbox, 'Value', 0);
            set(second_checkbox, 'Enable', 'off');
            set(second_checkbox, 'Value', 0);
            set(first_checkbox, 'Enable', 'on');
            set(first_checkbox, 'Value', 0);
            set(Button_skin_thickness, 'Value', 0);
            
    end

%% FIRST STEP CHECKBOX: SUBMIT SHAPE

first_checkbox = uicontrol('style','checkbox','position',[left_cb bottom_cb1 width_cb height_cb], ...
    'BackgroundColor',background_color,...
    'FontSize', 11,'FontWeight','bold', 'Value', 0,'ToolTipString','check when done with breast shape parameters & skin thickness');
first_checkbox.Units = "normalized";
first_checkbox.String='<html>&nbsp Submit<br /> &nbsp Shape</html>';
addlistener(first_checkbox, 'Value', 'PostSet', @callbackfn_cb1);
movegui(FigH, 'center')

    function callbackfn_cb1(~, eventdata)
        numcb1          = get(eventdata.AffectedObject, 'Value');
        if numcb1 ~= 0
            set(Slider_a, 'Enable', 'off');
            set(Slider_b, 'Enable', 'off');
            set(Slider_phi, 'Enable', 'off');
            set(Slider_end, 'Enable', 'off');
            set(Slider_theta, 'Enable', 'off');
            set(Button_skin_thickness, 'Enable', 'off');
            set(Slider_thickness, 'Enable', 'off');
            set(Button_glandular_tissue, 'Enable', 'on');
            set(second_checkbox, 'Enable', 'on')
        else
            set(Slider_a, 'Enable', 'on');
            set(Slider_b, 'Enable', 'on');
            set(Slider_phi, 'Enable', 'on');
            set(Slider_end, 'Enable', 'on');
            set(Slider_theta, 'Enable', 'on');
            set(Button_skin_thickness, 'Enable', 'on');
            if num_skin_thickness ~=0
                set(Slider_thickness, 'Enable', 'on');
            else
                set(Slider_thickness, 'Enable', 'off');
            end
            set(Button_glandular_tissue, 'Enable', 'off');
            TextH_glandular_tissue.String = "click above to draw firboglandular tissue outline";
            set(second_checkbox, 'Enable', 'off')
            if isgraphics(glandular_tissue) == true
                delete(glandular_tissue)
            end
            if count_malignant~=0
                for i_m = 1:count_malignant
                    if (eval(sprintf("isgraphics(malignant_tumor%d);",i_m))) == true
                        eval(sprintf("delete(malignant_tumor%d)",i_m))
                    end
                end
            end
            if count_benign~=0
                for i_b = 1:count_benign
                    if (eval(sprintf("isgraphics(benign_tumor%d);",i_b))) == true
                        eval(sprintf("delete(benign_tumor%d)",i_b))
                    end
                end
            end
        end
    end


%% SECOND STEP CHECKBOX: SUBMIT GLANDULAR TISSUE

second_checkbox = uicontrol('style','checkbox','position',[left_cb bottom_cb2 width_cb 2*height_cb], ...
    'BackgroundColor',background_color,...
    'Enable', 'off', ...
    'FontSize', 11,'FontWeight','bold', 'Value', 0,'ToolTipString','check when you have inserted the glandular tissue');
second_checkbox.Units = "normalized";
second_checkbox.String='<html>&nbsp Submit Fibro-<br /> &nbsp glandular<br /> &nbsp Tissue</html>';
addlistener(second_checkbox, 'Value', 'PostSet', @callbackfn_cb2);
movegui(FigH, 'center')



    function callbackfn_cb2(~, eventdata)
        numcb2          = get(eventdata.AffectedObject, 'Value');
        if numcb2 ~= 0
            set(first_checkbox, 'Enable', 'off')
            glandular_tissue.InteractionsAllowed = "none";
            set(Button_malignant, 'Enable', 'on');
            set(Button_benign, 'Enable', 'on');
            set(third_checkbox, 'Enable', 'on')
        else
            set(first_checkbox, 'Enable', 'on')
            glandular_tissue.InteractionsAllowed = "all";
            set(Button_malignant, 'Enable', 'off');
            set(Button_benign, 'Enable', 'off');
            set(third_checkbox, 'Enable', 'off')
        end
    end
    


%% THIRD STEP CHECKBOX: SUBMIT TUMORS

third_checkbox = uicontrol('style','checkbox','position',[left_cb bottom_cb3 width_cb height_cb], ...
    'BackgroundColor',background_color,...
    'Enable', 'off', ...
    'FontSize', 11,'FontWeight','bold', 'Value', 0,'ToolTipString','check if you have inserted tumor/s');
third_checkbox.Units = "normalized";
third_checkbox.String='<html>&nbsp Submit<br /> &nbsp Tumors</html>';
addlistener(third_checkbox, 'Value', 'PostSet', @callbackfn_cb3);
movegui(FigH, 'center')



    function callbackfn_cb3(~, eventdata)
        numcb3          = get(eventdata.AffectedObject, 'Value');
        if numcb3 ~= 0
            set(Button_malignant, 'Enable', 'off');
            set(Button_benign, 'Enable', 'off');
            set(second_checkbox, 'Enable', 'off')
        if count_malignant~=0
            for i_m = 1:count_malignant
                if (eval(sprintf("isgraphics(malignant_tumor%d);",i_m))) == true
                    eval(sprintf("malignant_tumor%d.InteractionsAllowed = 'none';",i_m))
                    eval(sprintf("malignant_tumor%d.FaceAlpha = 1;",i_m))
                end
            end
        end
        if count_benign~=0
            for i_b = 1:count_benign
                if (eval(sprintf("isgraphics(benign_tumor%d);",i_b))) == true
                    eval(sprintf("benign_tumor%d.InteractionsAllowed = 'none';",i_b))
                    eval(sprintf("benign_tumor%d.FaceAlpha = 1;",i_b))
                end
            end
        end
        delete(findobj(gca(),'Type','DataTip'));
        h.AlphaData = 0;

        else
            set(Button_malignant, 'Enable', 'on');
            set(Button_benign, 'Enable', 'on');
            set(second_checkbox, 'Enable', 'on')
        if count_malignant ~= 0
            for i_m = 1:count_malignant 
                if (eval(sprintf("isgraphics(malignant_tumor%d);",i_m))) == true
                    eval(sprintf("malignant_tumor%d.InteractionsAllowed = 'all';",i_m))
                    eval(sprintf("malignant_tumor%d.FaceAlpha = 1;",i_m))
                end
            end
        end
        if count_benign ~= 0
            for i_b = 1:count_benign
                if (eval(sprintf("isgraphics(benign_tumor%d);",i_b))) == true
                    eval(sprintf("benign_tumor%d.InteractionsAllowed = 'all';",i_b))
                    eval(sprintf("benign_tumor%d.FaceAlpha = 1;",i_b))
                end
            end
        end
        h.AlphaData = 1;
        end
    end
    


FigH.WindowState = 'maximized';
Panel1.Units = 'normalized';
Panel2.Units = 'normalized';
Panel3.Units = 'normalized';
pause(0.4)

end