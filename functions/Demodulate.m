function iq = Demodulate(samples)
  [N, ~] = size(samples);

  # Mixing
  c = 2 * cos(0.5*pi*((1:N)-1));
  s = 2 * sin(0.5*pi*((1:N)-1));

  I = c' .* samples;
  Q = s' .* samples;

  iq = complex(I, Q);
end
