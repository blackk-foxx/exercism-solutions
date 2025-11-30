def halt_slice_length_error:
  "slice length cannot be " + . | halt_error;

def validate(seriesLength; sliceLength):
  if seriesLength == 0 then "series cannot be empty" | halt_error
  elif sliceLength > seriesLength then "greater than series length" | halt_slice_length_error
  elif sliceLength == 0 then "zero" | halt_slice_length_error
  elif sliceLength < 0 then "negative" | halt_slice_length_error
  else .
  end;

[.series, (.series | length), .sliceLength] as [$series, $seriesLength, $sliceLength]
| validate($seriesLength; $sliceLength)
| [range(0; 1 + $seriesLength - $sliceLength)] 
| map($series[. : . + $sliceLength])
