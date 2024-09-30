%% EXTRACTION OF PARAMETERS FROM MIXED MAMMOGRAMS (with both benign and malignant findings)

F1 = figure('Name','Breast Profiles','NumberTitle','off'); % In this figure, 
% the breast profile will be plotted
F2 = figure('Name','Ellipse Fitting','NumberTitle','off'); % In this figure, 
% the breast contour will be plotted along with the fitted ellipse, and the 
% start and end points of the contour on the ellipse.
F3 = figure('Name','Ellipse Fitted','NumberTitle','off'); % In this figure, 
% the fitted ellipse will be plotted, showing the part used for breast 
% profile approximation

%% IMPORT OF MAMMOGRAMS

%-------------------------------------------------------------------------%
% Before running the function, it is necessary to specify the paths to the 
% folders containing the mammograms of the right and left breasts.

right_path = ''; % Insert here the paths to the folder containing the 
% mammograms of the right breasts
left_path = ''; % Insert here the paths to the folder containing the 
% mammograms of the left breasts
%-------------------------------------------------------------------------%

path_mix_right = fullfile(right_path,'\*.jpg');
path_mix_left = fullfile(left_path,'\*.jpg');

% We create a structure containing the image filenames
image_list_struct_mix_right = dir(path_mix_right);
image_list_struct_mix_left = dir(path_mix_left);

% We insert the image filenames into an array
image_list_mix_right = {image_list_struct_mix_right.name}';
image_list_mix_left = {image_list_struct_mix_left.name}';  

% We initialize the array where the images will be stored
Mix = {0};

% First, we store the images of the right breasts
for i = 1 : numel(image_list_mix_right)
  name_mix_right = image_list_mix_right{i};
  full_path_mix_right = fullfile(right_path, name_mix_right);
  im_mix_right = imread(full_path_mix_right);
  im_gray_mix_right = rgb2gray(im_mix_right);
  Mix{i} = im_gray_mix_right;

% NOTE: It is observed that each image has three channels, but they are 
% all identical (this can be verified using the isequal function). 
% Therefore, we can convert the images to grayscale (reducing from three 
% channels to one) without losing any information.

end


% Next, we store the images of the left breasts. To ensure all images are 
% oriented the same way, we will need to flip the left breast images.

for i = 1+numel(image_list_mix_right) : numel(image_list_mix_right)+numel(image_list_mix_left)
  name_mix_left = image_list_mix_left{i-numel(image_list_mix_right)};
  full_path_mix_left = fullfile(left_path, name_mix_left);
  
  im_mix_left = imread(full_path_mix_left);
  im_gray_mix_left = rgb2gray(im_mix_left);
  im_gray_mix_left_flip = fliplr(im_gray_mix_left);
  
  Mix{i} = im_gray_mix_left_flip;

end

% We have obtained an array with 5 cells; each cell contains a mammogram 
% with both benign and malignant findings.




%% EXTRACTION OF BREAST PROFILES

CE_mix = {0}; % contrast enhanced mammograms
BW_mix = {0}; % binarized mammograms
IM_close_mix = {0}; % Here, we will insert the images where the breast region 
% is white and the background is black
IM_edge_mix = {0}; % mammograms' edges
r_max_mix = 0; % Initialize the maximum number of rows for the images
c_max_mix = 0; % Initialize the maximum number of columns for the images


for i = 1:length(Mix)
    CE_mix{i} = histeq(Mix{i});
    BW_mix{i} = imbinarize(CE_mix{i},'adaptive');
    [r_mix,c_mix] = size(Mix{i}); 
    r_max_mix = max(r_max_mix,r_mix);
    c_max_mix = max (c_max_mix,c_mix);
    se_mix = strel('arbitrary',ones(r_mix+1000,c_mix+1000)); % To fill the breast, 
    % the size of nhood must be at least equal to the size of the image itself
    IM_close_mix{i} = imclose(BW_mix{i},se_mix);
    IM_edge_mix{i} = edge(IM_close_mix{i},'Canny'); 
    % imshow(IM_edge_mix{i})
end


% We standardize the dimensions of the images using zero padding
IM_mix = {0};

for i = 1:length(IM_edge_mix)
    I_mix = zeros(r_max_mix,c_max_mix);
    [r_mix,c_mix] = size(IM_edge_mix{i});
    if mod(r_mix,2)==0
        I_mix(floor(r_max_mix/2)-(r_mix/2-1):floor(r_max_mix/2)+r_mix/2,c_max_mix-c_mix+1:end) = IM_edge_mix{i};
    else
        I_mix(floor(r_max_mix/2)-(floor(r_mix/2)-1):floor(r_max_mix/2)+ceil(r_mix/2),c_max_mix-c_mix+1:end) = IM_edge_mix{i};
    end
    
    IM_mix{i} = I_mix;

end

% The following lines allow you to visualize the profile of each mammogram 
% and optionally save them in a folder.

% contour_dest_path = ''; % Insert the path to the folder where you want to
% save the breast profiles

for i = 1:length(IM_mix)
    figure(F1)
    imshow(IM_mix{i})
%     file_name_mix_contour = sprintf('Mix Contour_%d.jpg', i);% name Image with a sequence of number
%     fullFileName_mix_contour = fullfile(contour_dest_path, file_name_mix_contour);
%     saveas(f(i),fullFileName_mix_contour); 
end




%% ELLIPSE FITTING

IM_edge_mix_flip = {0};

X_mix = {0}; % Array where all the x coordinate vectors will be stored
Y_mix = {0}; % Array where all the y coordinate vectors will be stored

Start_mix = zeros(length(IM_mix),2);
End_mix = zeros(length(IM_mix),2);

a_mix = zeros(1,length(IM_mix));
b_mix = zeros(1,length(IM_mix));
phi_mix = zeros(1,length(IM_mix));
X0_mix = zeros(1,length(IM_mix));
Y0_mix = zeros(1,length(IM_mix));


for i = 1: length(IM_mix) 
    IM_edge_mix_flip{i} = flipud(IM_mix{i}); 
    [y,x] = find(IM_edge_mix_flip{i});
    norm = max(max(x), max(y));
    x_norm = x/norm;
    y_norm = y/norm;
    X_mix{i} = x_norm;
    Y_mix{i} = y_norm;

    Start_tmp = min(y_norm); % Temporary y coordinate of the i-th starting point
    End_tmp = max(y_norm); % Temporary y coordinate of the i-th ending point
    
    figure(F2)
    plot (x_norm,y_norm,'o','Color','c')
    hold on
    ellipse_t = fit_ellipse(x_norm,y_norm);  
    hold on

    
    % Parameters of the ellipse
    a_mix(i) =  ellipse_t.a;
    b_mix(i) =  ellipse_t.b;
    phi_mix(i) =  ellipse_t.phi;
    X0_mix(i) =  ellipse_t.X0_in;
    Y0_mix(i) =  ellipse_t.Y0_in;
    
    if a_mix(i)== 0 && b_mix(i) == 0 && phi_mix(i) == 0 && X0_mix(i) == 0 && Y0_mix(i) == 0
        msg = sprintf('Image %d-th not suitable for ellipse fitting', i);
        warning(msg)
        continue
    end

    % Find the starting point of the portion of the ellipse that fits the data
    xx = sym('xx');
    eqx_s = (((xx-X0_mix(i))*cos(-phi_mix(i)) + (Start_tmp-Y0_mix(i))*sin(-phi_mix(i)))^2)/a_mix(i)^2 + (((xx-X0_mix(i))*sin(-phi_mix(i)) - (Start_tmp-Y0_mix(i))*cos(-phi_mix(i)))^2)/b_mix(i)^2==1;
    Sx_s = solve(eqx_s,xx);
    
    Start_mix(i,1) = real(Sx_s(1));
    yy = sym('yy');
    eqy_s = (((Start_mix(i,1)-X0_mix(i))*cos(-phi_mix(i)) + (yy-Y0_mix(i))*sin(-phi_mix(i)))^2)/a_mix(i)^2 + (((Start_mix(i,1)-X0_mix(i))*sin(-phi_mix(i)) - (yy-Y0_mix(i))*cos(-phi_mix(i)))^2)/b_mix(i)^2==1;
    Sy_s = solve(eqy_s,yy);
    Start_mix(i,2) = Sy_s(1);
    plot(Start_mix(i,1),Start_mix(i,2), '*','Color','g','LineWidth',2,'MarkerSize',10) % plot of the start point of the breast profiles on the ellipse

    % Find the ending point of the portion of the ellipse that fits the data
    eqx_e = (((xx-X0_mix(i))*cos(-phi_mix(i)) + (End_tmp-Y0_mix(i))*sin(-phi_mix(i)))^2)/a_mix(i)^2 + (((xx-X0_mix(i))*sin(-phi_mix(i)) - (End_tmp-Y0_mix(i))*cos(-phi_mix(i)))^2)/b_mix(i)^2==1;
    Sx_e = solve(eqx_e,xx);
    
    End_mix(i,1) = real(Sx_e(1));
    eqy_e = (((End_mix(i,1)-X0_mix(i))*cos(-phi_mix(i)) + (yy-Y0_mix(i))*sin(-phi_mix(i)))^2)/a_mix(i)^2 + (((End_mix(i,1)-X0_mix(i))*sin(-phi_mix(i)) - (yy-Y0_mix(i))*cos(-phi_mix(i)))^2)/b_mix(i)^2==1;
    Sy_e = solve(eqy_e,yy);
    End_mix(i,2) = Sy_e(2);
    plot(End_mix(i,1),End_mix(i,2), '*','LineWidth',2, 'Color', "#EDB120", 'MarkerSize',10) % plot of the end point of the breast profiles on the ellipse
    axis equal
    legend({'Breast Contour','','','Ellipse Fitting','Start','End'},'Location','northeast')

    % with the following lines the user can save the ellipse fittings
    % ellipse_fitting_path = '';
    % file_name_fig = sprintf('Fit%d.jpg', i);% name Image with a sequence of number
    % fullFileName_fig = fullfile(ellipse_fitting_path, file_name_fig);
    % saveas(f(i),fullFileName_fig); 

    hold off
end




%% Calculation of the Alpha_e parameter

% Initialize two vectors to store the start and end angles of the ellipse arcs
Alpha_s_mix = zeros (1,length(Start_mix));
Alpha_e_mix = zeros(1,length(End_mix));


%__________________________________________________________________________

% By Roger Stafford (slightly modified)

for i = 1:length(IM_mix)
    figure(F3) 
% If (x0,y0) is the center of the ellipse, if a and b are the two semi-axis 
% lengths, and if p is the counterclockwise angle of the a-semi-axis 
% orientation with respect the the x-axis, then the entire ellipse can be 
% represented parametrically by the equations
%x_p = X0(i) + a(i)*cos(-phi(i))*cos(t) - b(i)*sin(-phi(i))*sin(t);
%y_p = Y0(i) + a(i)*sin(-phi(i))*cos(t) + b(i)*cos(-phi(i))*sin(t);

%where t is a parameter varying from -pi to +pi. If (x1,y1) and (x2,y2) 
% are the two endpoints of the elliptical arc in question in such a way 
% that the desired arc goes counterclockwise from (x1,y1) to (x2,y2), then 
% the corresponding endpoint parameters t1 and t2 can be solved for as follows:
   A = [a_mix(i)*cos(-phi_mix(i)),-b_mix(i)*sin(-phi_mix(i));a_mix(i)*sin(-phi_mix(i)),b_mix(i)*cos(-phi_mix(i))];
   T1 = A\[End_mix(i,1)-X0_mix(i);End_mix(i,2)-Y0_mix(i)]; % Solve for cos(t1) and sin(t1)
   t1 = atan2(T1(2),T1(1)); % Determine t1
   T2 = A\[Start_mix(i,1)-X0_mix(i);Start_mix(i,2)-Y0_mix(i)]; % Solve for cos(t2) and sin(t2)
   t2 = atan2(T2(2),T2(1)); % Determine t2
   if t2 < t1, t2 = t2 + 2*pi; end % Ensure that t2 >= t1
   Alpha_e_mix(1,i) = t1;
   Alpha_s_mix(1,i) = t2;
   t_p = linspace(t1,t2); % Make t start at t1 and end at t2
   x_p = X0_mix(i) + a_mix(i)*cos(-phi_mix(i))*cos(t_p) - b_mix(i)*sin(-phi_mix(i))*sin(t_p);
   y_p = Y0_mix(i) + a_mix(i)*sin(-phi_mix(i))*cos(t_p) + b_mix(i)*cos(-phi_mix(i))*sin(t_p);

   %The x and y vectors will trace the desired elliptical arc. To verify this 
   % with a plot, you can do this:
   tt_p = linspace(-pi,pi);
   xx_p = X0_mix(i) + a_mix(i)*cos(-phi_mix(i))*cos(tt_p) - b_mix(i)*sin(-phi_mix(i))*sin(tt_p);
   yy_p = Y0_mix(i) + a_mix(i)*sin(-phi_mix(i))*cos(tt_p) + b_mix(i)*cos(-phi_mix(i))*sin(tt_p);
   figure % In this figure, the fitting ellipse will be plotted, showing
   % the part used for breast profile approximation
   plot(xx_p,yy_p,'c--')
   hold on
   plot(x_p,y_p,'LineWidth',2, 'Color',"#0072BD")
   plot(X0_mix(i),Y0_mix(i),'+','LineWidth',2, 'Color', "#D95319", 'MarkerSize',10)
   plot(End_mix(i,1),End_mix(i,2),'*','LineWidth',2, 'Color', "#EDB120", 'MarkerSize',10)
   plot(Start_mix(i,1),Start_mix(i,2),'*','Color','g','LineWidth',2,'MarkerSize',10)
   axis equal

   hold off

end 
%__________________________________________________________________________




