def steps:
  if . < 1 then "Only positive integers are allowed" | halt_error
  elif . == 1 then 0
  elif . % 2 == 0 then 1 + ((. / 2) | debug | steps)
  else 1 + ((. * 3 + 1) | debug | steps)
  end
;
