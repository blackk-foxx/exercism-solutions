export function encode(plainText: string): string {
  let canonical = plainText.toLowerCase().replace(/\s/g, "");
  return Array.from(canonical)
    .map(c => encodeChar(c))
    .join("")
    .replace(/(.{5})/g, '$1 ')
    .trim();
}

export function decode(cipherText: string): string {
  return Array.from(cipherText)
    .map(c => encodeChar(c))
    .join("");
}

function encodeChar(c: string): string {
  if (c.match(/[a-z]/)) {
    let encodedCharCode = 'z'.charCodeAt(0) - c.charCodeAt(0) + 'a'.charCodeAt(0);
    return String.fromCharCode(encodedCharCode);
  }
  else if (c.match(/[0-9]/))
    return c;
  else
    return "";
}