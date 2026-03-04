Param(
  [ValidateSet('chrome', 'web-server')]
  [string]$Target = 'chrome',
  [string[]]$ExtraArgs
)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$Flutter = Join-Path $Root 'scripts/ci/flutter_cmd.sh'
$DemoMode = if ($env:DEMO_MODE) { $env:DEMO_MODE } else { 'false' }

if ($DemoMode -ne 'true') {
  if (-not $env:SUPABASE_URL) { throw 'SUPABASE_URL is required when DEMO_MODE=false' }
  if (-not $env:SUPABASE_ANON_KEY) { throw 'SUPABASE_ANON_KEY is required when DEMO_MODE=false' }
}

$LogDir = Join-Path $Root 'tmp/evidence'
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
$LogFile = Join-Path $LogDir ("web_run_{0}.log" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))

$args = @('run', '-d', $Target, "--dart-define=DEMO_MODE=$DemoMode")
if ($env:SUPABASE_URL) { $args += "--dart-define=SUPABASE_URL=$($env:SUPABASE_URL)" }
if ($env:SUPABASE_ANON_KEY) { $args += "--dart-define=SUPABASE_ANON_KEY=$($env:SUPABASE_ANON_KEY)" }
if ($env:MINIMAX_API_KEY) { $args += "--dart-define=MINIMAX_API_KEY=$($env:MINIMAX_API_KEY)" }
if ($Target -eq 'web-server') {
  $port = if ($env:WEB_PORT) { $env:WEB_PORT } else { '18080' }
  $host = if ($env:WEB_HOSTNAME) { $env:WEB_HOSTNAME } else { '0.0.0.0' }
  $args += @('--web-port', $port, '--web-hostname', $host)
}
if ($env:RUN_VERBOSE -ne 'false') { $args += '--verbose' }
if ($ExtraArgs) { $args += $ExtraArgs }

Write-Host "Running: $Flutter $($args -join ' ')"
Write-Host "Log file: $LogFile"

# Stream output and keep log for evidence pack.
& $Flutter @args 2>&1 | Tee-Object -FilePath $LogFile
