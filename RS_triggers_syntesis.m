%% Clearing workspace
clc
clear all
close all
format short

%% Set up your conditions
type = 'S'; % R S or E
basis = 'NOR'; % NOR or NAND
active = [0 0];

%% Display truth table
number_of_rows = 8;
truth_table = get_truth_table(type, basis, active, number_of_rows);
disp(truth_table)

%% Display R* and S* tables
R_star = flip_to_etalon(reshape(truth_table(:, 5), [4, 2])')
S_star = flip_to_etalon(reshape(truth_table(:, 6), [4, 2])')
