export function commands(code: number): string[] {
  const ACTIONS = ["wink", "double blink", "close your eyes", "jump"];
  let result = ACTIONS
    .filter((_: string, index: number) => code & (2 ** index));
  if (code & 0x10) result.reverse();
  return result;
}
