# The input will be null or an object that _may_ contain keys
#   actual_minutes_in_oven,
#   number_of_layers
#
# If the needed key is missing, use a default value:
#   zero minutes in oven,
#   one layer.
#
# Task: output a JSON object with keys:

[40, .actual_minutes_in_oven // 0] as [$total_baking_time, $elapsed_time] |
[$total_baking_time - $elapsed_time, 2 * (.number_of_layers // 1)] as
  [$remaining_time, $preparation_time] |
{
  "expected_minutes_in_oven": $total_baking_time,
  "remaining_minutes_in_oven": $remaining_time,
  "preparation_time": $preparation_time,
  "total_time": $elapsed_time + $preparation_time
}
