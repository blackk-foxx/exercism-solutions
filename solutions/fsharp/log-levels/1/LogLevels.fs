module LogLevels

let message(logLine: string): string = 
    logLine.Substring(logLine.IndexOf(":") + 1).Trim()

let logLevel(logLine: string): string = 
    let beginLevel = logLine.IndexOf("[") + 1
    let endLevel = logLine.IndexOf("]") - 1
    logLine.Substring(beginLevel, endLevel).ToLower()

let reformat(logLine: string): string = 
    sprintf "%s (%s)" (message(logLine)) (logLevel(logLine))
