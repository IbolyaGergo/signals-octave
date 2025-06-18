function [phase_diff_real,phase_diff_imag] = PhaseDiffHVComplex(H_I,H_Q,V_I,V_Q);
  phase_diff_real = H_I .* V_I + H_Q .* V_Q;
  phase_diff_imag = H_I .* V_Q - H_Q .* V_I;
endfunction;
