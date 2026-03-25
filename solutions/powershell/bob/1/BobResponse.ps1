Function Is-Yelling($prompt) {
    $letters = $prompt.ToCharArray().Where({[char]::IsLetter($_)})
    if ($letters.Where({[char]::IsLower($_)}, 'First')) {
        return $false
    }
    $letters.Length -gt 0
}

Function Is-Question($prompt) {
    $prompt.EndsWith('?')
}

Function Is-Silence($prompt) {
    $prompt.Length -eq 0
}

Function Get-BobResponse() {
    <#
    .SYNOPSIS
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.
    
    .DESCRIPTION
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.

    Bob answers 'Sure.' if you ask him a question.

    He answers 'Whoa, chill out!' if you yell at him.

    He answers 'Calm down, I know what I'm doing!' if you yell a question at him.

    He says 'Fine. Be that way!' if you address him without actually saying
    anything.

    He answers 'Whatever.' to anything else.
    
    .PARAMETER HeyBob
    The sentence you say to Bob.
    
    .EXAMPLE
    Get-BobResponse -HeyBob "Hi Bob"
    #>
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )

    $prompt = $HeyBob.Trim()
    if (Is-Silence($prompt)) {
        Write-Output "Fine. Be that way!"
    }
    elseif ((Is-Yelling($prompt)) -and (Is-Question($prompt))) {
        Write-Output "Calm down, I know what I'm doing!"
    }
    elseif (Is-Yelling($prompt)) {
        Write-Output "Whoa, chill out!"
    }
    elseif (Is-Question($prompt)) {
        Write-Output "Sure."
    }
    else {
        Write-Output "Whatever."
    }
}
