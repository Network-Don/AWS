$daysDir = "days"
$readmePath = "README.md"

if (-not (Test-Path $daysDir)) {
    Write-Host "Directory '$daysDir' not found."
    exit 1
}
if (-not (Test-Path $readmePath)) {
    Write-Host "File '$readmePath' not found."
    exit 1
}

function Extract-Title($filePath) {
    # Read file using .NET to ensure proper UTF-8 handling
    $content = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)
    foreach ($line in $content) {
        $line = $line.Trim()
        if ($line.StartsWith("#")) {
            $text = $line.TrimStart("#").Trim()
            # Strip emojis and leading symbols (Unicode range safe regex)
            $text = $text -replace '^[^a-zA-Z0-9]*', ''
            $text = $text.Trim()
            
            # Split by dash/hyphen/em-dash/en-dash (using char codes for en-dash: 0x2013, em-dash: 0x2014)
            $enDash = [char]0x2013
            $emDash = [char]0x2014
            # Require spaces around standard hyphen, allow optional spaces around en-dash and em-dash
            $splitPattern = "\s+(?:$enDash|$emDash|-)\s+|\s*(?:$enDash|$emDash)\s*"
            $parts = $text -split $splitPattern, 2
            
            if ($parts.Count -gt 1) {
                # Match Week X Day Y or Day X
                if ($parts[0] -match '^(?:Week\s*\d+\s*Day\s*\d+|Week\s*\d+\s*[·\s-]*\s*Day\s*\d+|Day\s*\d+)') {
                    return $parts[1].Trim()
                } else {
                    return $text
                }
            } else {
                return $text
            }
        }
    }
    return "Untitled"
}

# Find all day-*.md files
$dayFiles = Get-ChildItem -Path $daysDir -Filter "day-*.md" | ForEach-Object {
    if ($_.Name -match '^day-(\d+)(?:-[\w-]+)?\.md$') {
        [PSCustomObject]@{
            DayNum = [int]$Matches[1]
            Filename = $_.Name
            FilePath = $_.FullName
        }
    }
} | Sort-Object DayNum

if (-not $dayFiles) {
    Write-Host "No day markdown files found."
    exit 1
}

# Group by week (5 days per week)
$weeks = @{}
foreach ($df in $dayFiles) {
    # Ensure week is a clean integer to prevent type mismatch in hashtable keys
    $week = [int][Math]::Floor(($df.DayNum - 1) / 5) + 1
    if (-not $weeks.ContainsKey($week)) {
        $weeks[$week] = [System.Collections.Generic.List[PSCustomObject]]::new()
    }
    $title = Extract-Title $df.FilePath
    $weeks[$week].Add([PSCustomObject]@{
        DayNum = $df.DayNum
        Title = $title
        Filename = $df.Filename
    })
}

$sortedWeeks = $weeks.Keys | Sort-Object
$weekBlocks = [System.Collections.Generic.List[string]]::new()

$checkMark = [char]0x2705

foreach ($w in $sortedWeeks) {
    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add("**Week $w**")
    $days = $weeks[$w] | Sort-Object DayNum
    foreach ($d in $days) {
        $dayInWeek = (($d.DayNum - 1) % 5) + 1
        $lines.Add("- $checkMark **[Day $($dayInWeek): $($d.Title)](./days/$($d.Filename))**  ")
    }
    $weekBlocks.Add(($lines -join "`n"))
}

$progressContent = $weekBlocks -join "`n`n<br>`n`n"

# Read README.md using .NET to ensure proper UTF-8 handling
$readmeContent = [System.IO.File]::ReadAllText($readmePath, [System.Text.Encoding]::UTF8)

$startMarker = "<!-- START_PROGRESS_TRACKER -->"
$endMarker = "<!-- END_PROGRESS_TRACKER -->"

$startIdx = $readmeContent.IndexOf($startMarker)
$endIdx = $readmeContent.IndexOf($endMarker)

if ($startIdx -eq -1 -or $endIdx -eq -1) {
    Write-Host "Error: Could not find progress tracker comment markers in README.md."
    exit 1
}

$newReadme = $readmeContent.Substring(0, $startIdx + $startMarker.Length) + "`n" + $progressContent + "`n" + $readmeContent.Substring($endIdx)

[System.IO.File]::WriteAllText($readmePath, $newReadme, [System.Text.Encoding]::UTF8)

Write-Host "Successfully updated README.md progress section!"
