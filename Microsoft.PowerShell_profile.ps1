
# https://github.com/antfu-collective/ni
if (-not (Test-Path $profile)) {
  New-Item -ItemType File -Path (Split-Path $profile) -Force -Name (Split-Path $profile -Leaf)
}

$profileEntry = 'Remove-Item Alias:ni -Force -ErrorAction Ignore'
$profileContent = Get-Content $profile
if ($profileContent -notcontains $profileEntry) {
  ("`n" + $profileEntry) | Out-File $profile -Append -Force -Encoding UTF8
}
Remove-Item Alias:ni -Force -ErrorAction Ignore


# 别名
# npm run dev
function d { nr dev }
function d: {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string]$projectName
    )
    nr "dev:$projectName"
}

# npm run build
function b { nr build }
function b: {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string]$projectName
    )
    nr "build:$projectName"
}



