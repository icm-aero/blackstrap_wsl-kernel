param (
    [string]$version,         # Version tag for the release
    [string]$artifactPath     # Path to the artifact file or folder
)

# Ensure GitHub CLI is installed
if (-not (Get-Command "gh" -ErrorAction SilentlyContinue)) {
    Write-Host "Error: GitHub CLI (gh) is not installed. Install it from https://cli.github.com/"
    exit 1
}

# Ensure version is provided
if (-not $version) {
    Write-Host "Error: Version tag is required. Example: 1.0.0"
    exit 1
}

# Ensure artifact path exists
if (-not (Test-Path $artifactPath)) {
    Write-Host "Error: Artifact path does not exist: $artifactPath"
    exit 1
}

# Get GitHub repository from the current directory
Write-Host "Detecting GitHub repository in the current directory..."
$repo = gh repo view --json nameWithOwner --jq ".nameWithOwner"

if (-not $repo) {
    Write-Host "Error: Could not detect a GitHub repository in this directory. Ensure this is a cloned GitHub repo."
    exit 1
}

Write-Host "Detected repository: $repo"

# Create a GitHub Release
Write-Host "Creating GitHub Release for version $version..."
gh release create $version $artifactPath --repo $repo --title "Release $version" --notes "Automated release for version $version"

Write-Host "GitHub Release created successfully."
