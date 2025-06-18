## signal = struct("data", data, "Fs", Fs, "N", N, "delta_t", delta_t,
##                 "time_s", time_s, "range_s", range_s);
function demodulated = Demodulate_Signal(signal)
  ## Init
  demodulated = signal;

  fields = fieldnames(signal.data);
  for i=1:length(fields)
    demodulated.data.(fields{i}) = Demodulate( signal.data.(fields{i}) );
  endfor
endfunction
