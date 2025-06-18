#skombinuje hruby a jemny kanal podmienknou
#signal_i = (high_i < condition) ? low_i : high_multiplier * high_i
function [output] = FasterCombineChannels(high, low, condition, high_multiplier);
  high_multiplier32 = cast(high_multiplier, "int32");
  is_low = ( abs(high) < condition );
  output = is_low .* cast(low, "int32") + high_multiplier32*(1-is_low) .* cast(high, "int32");
endfunction;
