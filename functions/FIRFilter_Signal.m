## signal = struct("data", data, "Fs", Fs, "N", N, "delta_t", delta_t,
##                 "time_s", time_s, "range_s", range_s);
function filtered = FIRFilter_Signal(filter_type, signal)
  ## Init
  filtered = signal;

  fields = fieldnames(signal.data);
  for i=1:length(fields)
    filtered.data.(fields{i}) = filter( filter_type, 1, signal.data.(fields{i}) );
  endfor
endfunction
