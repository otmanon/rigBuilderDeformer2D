% read json
close all;
clear;
cd ./
raw_data_dir_root = "./data/raw_data/";

%For Fly
mesh_name = "ginger";
rig_name = "lbs_rig";
raw_data_dir = strcat(raw_data_dir_root, mesh_name, "/");

[V, F] =readOBJ(strcat(raw_data_dir, rig_name, "/", mesh_name, ".obj"));
V = V(:, 1:2);
W = readDMAT(strcat(raw_data_dir, rig_name, "/W.DMAT"));
p0 = readDMAT(strcat(raw_data_dir, rig_name, "/p0.DMAT"));
p_out_file = strcat(raw_data_dir, rig_name, "/anim/p_deformed.DMAT");




deform_rig(V, F, W, p0, p_out_file);