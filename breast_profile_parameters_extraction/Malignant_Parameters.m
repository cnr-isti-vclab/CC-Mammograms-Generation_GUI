%% EXTRACTION OF PARAMETERS FROM MALIGNANT MAMMOGRAMS

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

path_malignant_right = fullfile(right_path,'\*.jpg');
path_malignant_left = fullfile(left_path,'\*.jpg');

% We create a structure containing the image filenames
image_list_struct_malignant_right = dir(path_malignant_right);
image_list_struct_malignant_left = dir(path_malignant_left);

% We insert the image filenames into an array
image_list_malignant_right = {image_list_struct_malignant_right.name}';
image_list_malignant_left = {image_list_struct_malignant_left.name}';  

% We initialize the array where the images will be stored
Malignant = {0};

% First, we store the images of the right breasts
for i = 1 : numel(image_list_malignant_right)
  name_malignant_right = image_list_malignant_right{i};
  full_path_malignant_right = fullfile(right_path, name_malignant_right);
  im_malignant_right = imread(full_path_malignant_right);
  im_gray_malignant_right = rgb2gray(im_malignant_right);
  Malignant{i} = im_gray_malignant_right;

% NOTE: It is observed that each image has three channels, but they are 
% all identical (this can be verified using the isequal function). 
% Therefore, we can convert the images to grayscale (reducing from three 
% channels to one) without losing any information.

end


% Next, we store the images of the left breasts. To ensure all images are 
% oriented the same way, we will need to flip the left breast images.

for i = 1+numel(image_list_malignant_right) : numel(image_list_malignant_right)+numel(image_list_malignant_left)
  name_malignant_left = image_list_malignant_left{i-numel(image_list_malignant_right)};
  full_path_malignant_left = fullfile(left_path, name_malignant_left);
  
  im_malignant_left = imread(full_path_malignant_left);
  im_gray_malignant_left = rgb2gray(im_malignant_left);
  im_gray_malignant_left_flip = fliplr(im_gray_malignant_left);
  
  Malignant{i} = im_gray_malignant_left_flip;

end

% We have obtained an array with 43 cells; each cell contains a mammogram 
% with malignant findings.




%% EXTRACTION OF BREAST PROFILES

CE_m = {0}; % contrast enhanced mammograms
BW_m = {0}; % binarized mammograms
IM_close_m = {0}; % Here, we will insert the images where the breast region 
% is white and the background is black
IM_edge_m = {0}; % mammograms' edges
r_max_m = 0; % Initialize the maximum number of rows for the images
c_max_m = 0; % Initialize the maximum number of columns for the images


for i = 1:length(Malignant)
    CE_m{i} = histeq(Malignant{i});
    BW_m{i} = imbinarize(CE_m{i},'adaptive');
    [r_m,c_m] = size(Malignant{i}); 
    r_max_m = max(r_max_m,r_m);
    c_max_m = max (c_max_m,c_m);
    se_m = strel('arbitrary',ones(r_m+1000,c_m+1000)); % To fill the breast, 
    % the size of nhood must be at least equal to the size of the image itself
    IM_close_m{i} = imclose(BW_m{i},se_m);
    IM_edge_m{i} = edge(IM_close_m{i},'Canny'); 
    %imshow(IM_edge_m{i})
end


% We standardize the dimensions of the images using zero padding
IM_m = {0};

for i = 1:length(IM_edge_m)
    I_m = zeros(r_max_m,c_max_m);
    [r_m,c_m] = size(IM_edge_m{i});
    if mod(r_m,2)==0
        I_m(floor(r_max_m/2)-(r_m/2-1):floor(r_max_m/2)+r_m/2,c_max_m-c_m+1:end) = IM_edge_m{i};
    else
        I_m(floor(r_max_m/2)-(floor(r_m/2)-1):floor(r_max_m/2)+ceil(r_m/2),c_max_m-c_m+1:end) = IM_edge_m{i};
    end
    
    IM_m{i} = I_m;

end


% Images 6, 9 and 11 are problematic; it is necessary to remove the vertical 
% pixel row that closes the contour.
IM_m {6} = edge(IM_m{6},'Sobel', [], 'horizontal');
IM_m {9} = edge(IM_m{9},'Sobel', [], 'horizontal');
IM_m {11} = edge(IM_m{11},'Sobel', [], 'horizontal');


% The following lines allow you to visualize the profile of each mammogram 
% and optionally save them in a folder.

% contour_dest_path = ''; % Insert the path to the folder where you want to
% save the breast profiles

for i = 1:length(IM_m)
    figure(F1)
    imshow(IM_m{i})
%     file_name_malignant_contour = sprintf('Malignant Contour_%d.jpg', i);% name Image with a sequence of number
%     fullFileName_malignant_contour = fullfile(contour_dest_path, file_name_malignant_contour);
%     saveas(f(i),fullFileName_malignant_contour); 
end




%% ELLIPSE FITTING

IM_edge_m_flip = {0};

X_m = {0}; % Array where all the x coordinate vectors will be stored
Y_m = {0}; % Array where all the y coordinate vectors will be stored

Start_m = zeros(length(IM_m),2);
End_m = zeros(length(IM_m),2);

a_m = zeros(1,length(IM_m));
b_m = zeros(1,length(IM_m));
phi_m = zeros(1,length(IM_m));
X0_m = zeros(1,length(IM_m));
Y0_m = zeros(1,length(IM_m));


for i = 1: length(IM_m) 
    IM_edge_m_flip{i} = flipud(IM_m{i}); 
    [y,x] = find(IM_edge_m_flip{i});
    norm = max(max(x), max(y));
    x_norm = x/norm;
    y_norm = y/norm;
    X_m{i} = x_norm;
    Y_m{i} = y_norm;

    Start_tmp = min(y_norm); % Temporary y coordinate of the i-th starting point
    End_tmp = max(y_norm); % Temporary y coordinate of the i-th ending point

    figure(F2)
    plot (x_norm,y_norm,'o','Color','c')
    hold on
    ellipse_t = fit_ellipse(x_norm,y_norm);  
    hold on

    % Parameters of the ellipse
    a_m(i) =  ellipse_t.a;
    b_m(i) =  ellipse_t.b;
    phi_m(i) =  ellipse_t.phi;
    X0_m(i) =  ellipse_t.X0_in;
    Y0_m(i) =  ellipse_t.Y0_in;
    
    if a_m(i)== 0 && b_m(i) == 0 && phi_m(i) == 0 && X0_m(i) == 0 && Y0_m(i) == 0
        msg = sprintf('Image %d-th not suitable for ellipse fitting', i);
        warning(msg)
        continue
    end
    
    
    % Find the starting point of the portion of the ellipse that fits the data
    xx = sym('xx');
    eqx_s = (((xx-X0_m(i))*cos(-phi_m(i)) + (Start_tmp-Y0_m(i))*sin(-phi_m(i)))^2)/a_m(i)^2 + (((xx-X0_m(i))*sin(-phi_m(i)) - (Start_tmp-Y0_m(i))*cos(-phi_m(i)))^2)/b_m(i)^2==1;
    Sx_s = solve(eqx_s,xx);
    
    Start_m(i,1) = real(Sx_s(1));
    yy = sym('yy');
    eqy_s = (((Start_m(i,1)-X0_m(i))*cos(-phi_m(i)) + (yy-Y0_m(i))*sin(-phi_m(i)))^2)/a_m(i)^2 + (((Start_m(i,1)-X0_m(i))*sin(-phi_m(i)) - (yy-Y0_m(i))*cos(-phi_m(i)))^2)/b_m(i)^2==1;
    Sy_s = solve(eqy_s,yy);
    Start_m(i,2) = Sy_s(1);
    plot(Start_m(i,1),Start_m(i,2), '*','Color','g','LineWidth',2,'MarkerSize',10) % plot of the start point of the breast profiles on the ellipse
    
    % Find the ending point of the portion of the ellipse that fits the data
    eqx_e = (((xx-X0_m(i))*cos(-phi_m(i)) + (End_tmp-Y0_m(i))*sin(-phi_m(i)))^2)/a_m(i)^2 + (((xx-X0_m(i))*sin(-phi_m(i)) - (End_tmp-Y0_m(i))*cos(-phi_m(i)))^2)/b_m(i)^2==1;
    Sx_e = solve(eqx_e,xx);
    
    End_m(i,1) = real(Sx_e(1));
    eqy_e = (((End_m(i,1)-X0_m(i))*cos(-phi_m(i)) + (yy-Y0_m(i))*sin(-phi_m(i)))^2)/a_m(i)^2 + (((End_m(i,1)-X0_m(i))*sin(-phi_m(i)) - (yy-Y0_m(i))*cos(-phi_m(i)))^2)/b_m(i)^2==1;
    Sy_e = solve(eqy_e,yy);
    End_m(i,2) = Sy_e(2);
    plot(End_m(i,1),End_m(i,2), '*','LineWidth',2, 'Color', "#EDB120", 'MarkerSize',10) % plot of the end point of the breast profiles on the ellipse
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
Alpha_s_m = zeros (1,length(Start_m));
Alpha_e_m = zeros(1,length(End_m));


%__________________________________________________________________________

% By Roger Stafford (slightly modified)

for i = 1:length(IM_m)
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
   A = [a_m(i)*cos(-phi_m(i)),-b_m(i)*sin(-phi_m(i));a_m(i)*sin(-phi_m(i)),b_m(i)*cos(-phi_m(i))];
   T1 = A\[End_m(i,1)-X0_m(i);End_m(i,2)-Y0_m(i)]; % Solve for cos(t1) and sin(t1)
   t1 = atan2(T1(2),T1(1)); % Determine t1
   T2 = A\[Start_m(i,1)-X0_m(i);Start_m(i,2)-Y0_m(i)]; % Solve for cos(t2) and sin(t2)
   t2 = atan2(T2(2),T2(1)); % Determine t2
   if t2 < t1, t2 = t2 + 2*pi; end % Ensure that t2 >= t1
   Alpha_e_m(1,i) = t1;
   Alpha_s_m(1,i) = t2;
   t_p = linspace(t1,t2); % Make t start at t1 and end at t2
   x_p = X0_m(i) + a_m(i)*cos(-phi_m(i))*cos(t_p) - b_m(i)*sin(-phi_m(i))*sin(t_p);
   y_p = Y0_m(i) + a_m(i)*sin(-phi_m(i))*cos(t_p) + b_m(i)*cos(-phi_m(i))*sin(t_p);

   %The x and y vectors will trace the desired elliptical arc. To verify this 
   % with a plot, you can do this:
   tt_p = linspace(-pi,pi);
   xx_p = X0_m(i) + a_m(i)*cos(-phi_m(i))*cos(tt_p) - b_m(i)*sin(-phi_m(i))*sin(tt_p);
   yy_p = Y0_m(i) + a_m(i)*sin(-phi_m(i))*cos(tt_p) + b_m(i)*cos(-phi_m(i))*sin(tt_p);
   plot(xx_p,yy_p,'c--')
   hold on
   plot(x_p,y_p,'LineWidth',2, 'Color',"#0072BD")
   plot(X0_m(i),Y0_m(i),'+','LineWidth',2, 'Color', "#D95319", 'MarkerSize',10)
   plot(End_m(i,1),End_m(i,2),'*','LineWidth',2, 'Color', "#EDB120", 'MarkerSize',10)
   plot(Start_m(i,1),Start_m(i,2),'*','Color','g','LineWidth',2,'MarkerSize',10)
   axis equal

   % with the following lines the user can save the fitted ellipse
   % fitted_ellipse_path = '';
   % file_name_fig = sprintf('Fitted%d.jpg', i);% name Image with a sequence of number
   % fullFileName_fig = fullfile(fitted_ellipse_path, file_name_fig);
   % saveas(f(i),fullFileName_fig);

   hold off

end 
%__________________________________________________________________________









