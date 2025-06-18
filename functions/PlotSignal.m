## Create time and frequency domain plots of a list of signals
function PlotSignal(signal, Fs, signal_name, mode)
  subplot(211);
  plot(abs(signal));
  xlabel('Sample Number');
  ylabel('Amplitude')
  title(signal_name, "fontsize", 16);

  padded_signal = postpad(signal, 10000);
  number_of_samples = length(padded_signal);
  f_range = (0:1/number_of_samples:0.5)*Fs*10^(-6); ## MHz

  switch (mode)
    case "log"
      subplot(212);
      plot( f_range,...
            20*log10( abs( fft( padded_signal ) )(1:number_of_samples/2+1, :) ) );
      xlabel('Frequency [MHz]');
      ylabel('Magnitude [dB]')
      axis([0 f_range(end)]);
    case "abs"
      subplot(212);
      plot( f_range,...
            abs( fft( padded_signal ) )(1:number_of_samples/2+1, :) ) ;
      xlabel('Frequency [MHz]');
      ylabel('Magnitude')
      axis([0 f_range(end)]);
  endswitch
endfunction

