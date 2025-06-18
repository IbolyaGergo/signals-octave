clc; close all; clear all;

##################################################################################################
##                                    Load data
##################################################################################################
## Get the path of the script directory
BASE_DIR = fullfile( fileparts( mfilename('fullpath') ), ".." );

mat_file = glob( fullfile(BASE_DIR, "preprocessed_data", "*/*/*.mat") ){1};

data = load(mat_file);

N = length(data.Tx);
Fs = 250e6; # samples/sec
delta_t = 1/Fs;
time_s = 0:delta_t:((N - 1)*delta_t);
c_light = 300e+6; # speed of light in m/s
range_s = 0.5*c_light*time_s; # range

orig = struct("data", data, "Fs", Fs, "N", N, "delta_t", delta_t,
              "time_s", time_s, "range_s", range_s);


clearvars mat_file data N Fs delta_t time_s c_light range_s
####################################################################################################
####                                    Processing
####################################################################################################
pkg load signal;

## Load filters
filters_path = fullfile(BASE_DIR, "filters");
filters = LoadFilters(filters_path);

#### downsamplig factors
dsfactor_0 = 2;
dsfactor_1 = 16;

## BP filter
bp_filtered = FIRFilter_Signal(filters.bp_2845_4MHz, orig);

## Downsampling by dsfactor_0
downsampled_0 = DownSample_Signal(bp_filtered, dsfactor_0);

## IQ demodulation
demodulated = Demodulate_Signal(downsampled_0);

## LP filter
lp_filtered = FIRFilter_Signal(filters.lp_20MHz, demodulated);

## Downsampling by dsfactor_1
downsampled_1 = DownSample_Signal(lp_filtered, dsfactor_1);


figure, plot( orig.data.Tx(1:2000,1) );
figure, plot( bp_filtered.data.Tx(1:2000,1) );
figure, plot( downsampled_0.data.Tx(1:1000,1) );
figure, plot( real(lp_filtered.data.Tx(1:1000,1)) );
hold on;
plot( imag(lp_filtered.data.Tx(1:1000,1)) )
figure, plot( real(downsampled_1.data.Tx(1:100,1)) );
hold on;
plot( imag(downsampled_1.data.Tx(1:100,1)) );
figure, plot( abs(downsampled_1.data.Tx(1:100,1)) );

figure, plot(orig.time_s, orig.data.Tx);
figure, plot(downsampled_1.time_s, abs(downsampled_1.data.Tx));

##results_path = fullfile(BASE_DIR, "processed_data", "processed.mat");
##save('-v7', results_path, 'orig', 'bp_filtered', 'downsampled_0',...
##                          'demodulated', 'lp_filtered', 'downsampled_1');


