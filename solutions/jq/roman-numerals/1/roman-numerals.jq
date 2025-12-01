def roman_numeral_for_value:
  {
    "1": "I",
    "4": "IV",
    "5": "V",
    "9": "IX",
    "10": "X",
    "40": "XL",
    "50": "L",
    "90": "XC",
    "100": "C",
    "400": "CD",
    "500": "D",
    "900": "CM",
    "1000": "M"
  };

def roman_numeral_value_pairs:
  roman_numeral_for_value
  | to_entries
  | map({"value": (.key | tonumber), "numeral": .value});

def closest_roman_numeral:
  . as $number
  | roman_numeral_value_pairs
  | max_by(select(.value <= $number) | .value);

def to_roman:
  . as $number 
  | if $number == 0 then ""
    else 
      $number 
      | closest_roman_numeral
      | .numeral + (($number - .value) | to_roman)
    end;

.number | to_roman