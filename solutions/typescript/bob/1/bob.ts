export function hey(message: string): string {
  if (isYelling(message) && isQuestion(message))
    return "Calm down, I know what I'm doing!";
  if (isYelling(message))
    return "Whoa, chill out!";
  if (isQuestion(message))
    return "Sure.";
  if (isSilence(message))
    return "Fine. Be that way!";
  return "Whatever.";
}

function isYelling(message: string): boolean {
  let letters = Array.from(message)
    .filter(c => c.match(/[a-zA-Z]/));
  return (letters.length > 0) && 
    (letters.every(c => c >= 'A' && c <= 'Z'));
}

function isQuestion(message: string): boolean {
  return message.trim().endsWith('?');
}

function isSilence(message: string): boolean {
  return message.trim().length == 0;
}