param (
    [string]$WSLVersion = "linux-msft-wsl-5.15.167.4"
)

docker buildx build --build-arg WSL_KERNEL_VERSION=$WSLVersion -o . .