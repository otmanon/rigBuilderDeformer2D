% read json
close all;
clear;
cd ./
raw_data_dir_root = "./data/raw_data/";
mesh_name = "fly";
rig_name = "lbs_rig";
%%% For CTHULU
% mesh_name = "cthulu";
% rig_name = "lbs_rig";
% raw_data_dir = strcat("./data/raw_data/", mesh_name, "/");
% [V, E] = png2poly(strcat(raw_data_dir, 'cthulu.png'), 1, 1000);
% 
% scale = mean(max(V) - min(V));
% V = V / scale;
% [V, F] = triangulate(V, E, 'Flags', '-q20');
% 
% build_lbs_rig(V, F, mesh_name, rig_name, raw_data_dir);


%%For Fly

raw_data_dir = strcat(raw_data_dir_root, mesh_name, "/");
rig_data_dir = strcat(raw_data_dir, rig_name, "/")
mkdir(rig_data_dir)

%[V, F] =readOBJ("data\raw_data\fly\fly.obj");
[V, F] =readOBJ(strcat(raw_data_dir, mesh_name, ".obj"));
%readOBJ("")
tsurf(F, V);

build_rig(V, F, mesh_name, rig_name, raw_data_dir);