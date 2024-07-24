%% MAMMOGRAMS IMPORT
source_dir = ''; % Insert the path of the real mammograms to be scaled here
dest_dir = ''; % Insert the path where you want to save the scaled mammograms here
path_source = fullfile(source_dir,'\*.png');

image_list_struct_model = dir(path_source);
image_list_model = {image_list_struct_model.name}';  
IM = {0};

for i = 1 : numel(image_list_model)
  name_model = image_list_model{i};
  full_path_model = fullfile(source_dir, name_model);
  im = imread(full_path_model);
  IM{i} = im; 

I = IM {i};


%% SCALE & PADDING
s = size(I);
r = s(1); 
scale = 512/r;

I_resized = imresize(I, scale);
s_resized = size(I_resized);

PAD = zeros(512,512,3);
PAD = uint8(PAD);

r = s_resized(1);
c = s_resized(2);

if mod(r,2)==0
    PAD((512/2)-(r/2)+1:(512/2)+(r/2),512-c+1:end,:) = I_resized;
else
    PAD((512/2)-((r-1)/2):(512/2)+((r-1)/2),512-c+1:end,:) = I_resized;
end

full_path_dest = fullfile(dest_dir, name_model); 
imwrite(PAD, full_path_dest)

end