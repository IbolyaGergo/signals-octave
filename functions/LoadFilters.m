function filters = LoadFilters(filters_path)
  filters = struct();
  csvfiles = glob( fullfile(filters_path, "*.csv") );

  for i=1:length(csvfiles)
    [~, name, ~] = fileparts(csvfiles{i});
    filters.(name) = dlmread(csvfiles{i});
  endfor
endfunction
