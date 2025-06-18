clc; close all; clear all;

##################################################################################################
##                                    Load data
##################################################################################################
## Get the path of the script directory
BASE_DIR = fullfile( fileparts( mfilename('fullpath') ), ".." );

mat_file = glob( fullfile(BASE_DIR, "preprocessed_data", "*/*/*.mat") ){1};

data = load(mat_file);

## extracting useful samples
pulse_length = 5000;
orig = data;
fields = fieldnames(orig);
for i=1:length(fields)
  orig.(fields{i}) = orig.(fields{i})(1:pulse_length,:);
endfor

##################################################################################################
##                                    Processing
##################################################################################################
pkg load signal;

## Load filters
filters_path = fullfile(BASE_DIR, "filters");
filters = LoadFilters(filters_path);

## downsamplig factors
dsfactor_0 = 2;
dsfactor_1 = 16;

bp_filtered = orig;
downsampled_0 = orig;
demodulated = orig;
lp_filtered = orig;
downsampled_1 = orig;
for i=1:length(fields)
  ## BP filter
  bp_filtered.(fields{i}) = filter(filters.bp_2845_4MHz, 1, orig.(fields{i}) );

  ## Downsampling by dsfactor_0
  downsampled_0.(fields{i}) = downsample(bp_filtered.(fields{i}), dsfactor_0);

  ## IQ demodulation
  demodulated.(fields{i}) = Demodulate(downsampled_0.(fields{i}));

  ## LP filter
  lp_filtered.(fields{i}) = filter(filters.lp_20MHz, 1, demodulated.(fields{i}) );

  ## Downsampling by dsfactor_1
  downsampled_1.(fields{i}) = downsample(lp_filtered.(fields{i}), dsfactor_1);
endfor

figure, plot( orig.Tx(:,1) );
figure, plot( bp_filtered.Tx(:,1) );
figure, plot( abs(downsampled_1.Tx(:,1)) );

##results_path = fullfile(BASE_DIR, "processed_data", "processed.mat");
##save('-v7', results_path, 'orig', 'bp_filtered', 'downsampled_0',...
##                          'demodulated', 'lp_filtered', 'downsampled_1');


