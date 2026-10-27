%% Guardian Mission - Master Initialization and Control Script
clear; clc; close all;
disp('Initializing Workspace...');

% 1. Add the subfolders to MATLAB's search path
addpath(fullfile(pwd, 'Rover'));
addpath(fullfile(pwd, 'Battery'));
N_confirm = 5;

% 2. Load Variables 
% (Because we added the paths above, we can just call the script names directly)
Base
run_MAIN

% 3. Run the Top-Level Harness
disp('Starting 3D Simulation...');
simOut = sim('finals.slx'); 
disp('Mission Complete!');