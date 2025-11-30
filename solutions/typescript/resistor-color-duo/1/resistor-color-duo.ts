export function decodedValue(colors: string[]): number {
  return colors
      .slice(0, 2)
      .reverse()
      .reduce(
        (acc: number, color: string, index: number) => acc + COLORS.indexOf(color) * 10 ** index,
        0
      )
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
]
