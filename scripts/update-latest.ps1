param(
  [Parameter(Mandatory = $true)]
  [string]$Version,

  [Parameter(Mandatory = $true)]
  [string]$Message,

  [string]$DownloadUrl = "https://jn-skillhub.bytedance.net/skills/Atom-%E6%9C%8D%E8%A3%85%E7%94%9F%E6%88%90"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
$manifestPath = Join-Path $repoRoot "latest.json"

$manifest = [ordered]@{
  name = "Atom-服装生成"
  latest_version = $Version
  download_url = $DownloadUrl
  message = $Message
  updated_at = (Get-Date).ToString("yyyy-MM-dd")
  manifest_url = "https://raw.githubusercontent.com/higaichao/atom-outfit-skill-release/master/latest.json"
}

$manifest | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $manifestPath -Encoding UTF8

Push-Location $repoRoot
try {
  git add latest.json
  git commit -m "Update manifest to $Version"
  git push
} finally {
  Pop-Location
}

Write-Host "Updated latest.json to $Version"
