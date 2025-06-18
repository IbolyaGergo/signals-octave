## signal = struct("data", data, "Fs", Fs, "N", N, "delta_t", delta_t,
##                 "time_s", time_s, "range_s", range_s);
function downsampled = DownSample_Signal(signal, dsfactor)
  ## Init
  downsampled = signal;

  fields = fieldnames(signal.data);
  for i=1:length(fields)
    downsampled.data.(fields{i}) = downsample(signal.data.(fields{i}), dsfactor);
  endfor

  downsampled.Fs = signal.Fs/dsfactor;
  downsampled.N = signal.N/dsfactor;
  downsampled.delta_t = signal.delta_t * dsfactor;

  downsampled.time_s = downsample(signal.time_s, dsfactor);
  downsampled.range_s= downsample(signal.range_s, dsfactor);

endfunction
