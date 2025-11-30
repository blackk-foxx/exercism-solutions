export function decodedResistorValue(colors: string[]): string {
  let mantissa = colors
    .slice(0, 2)
    .reverse()
    .reduce(
      (acc: number, color: string, index: number) => 
        acc + COLORS.indexOf(color) * 10 ** index,
      0
    )
  let order = COLORS.indexOf(colors[2]);
  return express(mantissa * 10 ** order);
}

function express(value: number): string {
  const prefix = [
    "",
    "kilo",
    "mega",
    "giga",
  ];
  let order = Math.floor(log1000(value));
  let scaledValue = value / (1000 ** order);
  let scaledUnits = `${prefix[order]}ohms`
  return `${scaledValue} ${scaledUnits}`;
}

function log1000(value: number): number {
  if (value == 0) return 0;
  return Math.log(value) / Math.log(1000);
}

const COLORS = [
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white",
];
