# blackstrap WSL kernel

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/metabronx/blackstrap-wsl-kernel/build.yaml?label=latest%20build&style=flat-square)

A Windows Subsystem for Linux kernel originally built for blackstrap VPN.

This kernel can be used wherever WSL needs to support applications that require `CONNMARK`, like Wireguard in Docker (<https://docs.linuxserver.io/images/docker-wireguard>).

The Dockerfile pulls and builds the latest released version of the WSL Linux kernel from <https://github.com/microsoft/WSL2-Linux-Kernel>. Building the kernel takes 10-15 minutes.

The built kernel is saved to `/wsl-kernel` within the image and can be copied out for use:

```powershell
# build
./build.ps1

or
./build.ps1 -WSLVersion linux-msft-wsl-5.15.167.4
```

To use it, specify the custom kernel in your `~/.wslconfig` file and restart WSL with `wsl --shutdown`. Also ensure to escape the path (`\` should be `\\`) you set.

See: https://github.com/MicrosoftDocs/WSL/releases/tag/18947

```plain
[wsl2]
kernel=C:\\Users\\<USER>\\WSL2\\kernel
```

# License

Put a license here.
