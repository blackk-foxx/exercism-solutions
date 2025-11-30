export function find(haystack: number[], needle: number): number | never {
  return find_in_range(haystack, 0, haystack.length, needle);
}

function find_in_range(haystack: number[], begin: number, end: number, needle: number): number | never {
  if (begin == end) throw new Error("Value not in array");
  let mid = Math.trunc((begin + end) / 2);
  if (needle == haystack[mid]) 
    return mid;
  else if (needle < haystack[mid]) 
    return find_in_range(haystack, begin, mid, needle);
  else 
    return find_in_range(haystack, mid + 1, end, needle);
}
