Below is an updated `README.md` that’s cleaner, more structured, and follows modern GitHub documentation conventions. Feel free to adjust headings and details to match your specific needs.

---

# blackstrap WSL Kernel

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/metabronx/blackstrap-wsl-kernel/build.yaml?label=latest%20build&style=flat-square)](https://github.com/metabronx/blackstrap-wsl-kernel/actions)

A **custom Windows Subsystem for Linux (WSL) kernel** forked from [this repository](https://github.com/metabronx/blackstrap_wsl-kernel.git).  
It adds support for `CONNMARK`, which is missing in the default WSL kernel. This feature is essential for Istio and other networking-related tools (e.g., WireGuard in Docker).

---

## Why a Custom Kernel?

By default, Microsoft’s WSL kernel may be missing certain kernel modules or configurations needed by advanced networking technologies. In particular:

- **Istio** sidecars in Docker (or Kubernetes on WSL) may require `CONNMARK` for proper traffic routing.
- **Other tools** (like WireGuard in Docker) also benefit from this feature.

This repository automates the process of downloading, configuring, and building a WSL-compatible kernel that includes these missing features.

---

## How to Use

### Option 1: Download the Pre-compiled Kernel

1. **Visit the [Releases page](../../releases)** of this GitHub repo.
2. Download the latest build artifact (e.g., `wsl-kernel-*` file).
3. **Copy** the downloaded kernel to a convenient path in Windows (for example, `C:\Users\<USER>\WSL2\wsl-kernel-*`).
4. **Edit** your WSL configuration file:

   ```ini
   # ~/.wslconfig or C:\Users\<USER>\.wslconfig

   [wsl2]
   kernel = C:\\Users\\<USER>\\WSL2\\wsl-kernel-*
   ```

   > **Note**: Use double backslashes in the path.

5. **Restart WSL**:

   ```powershell
   wsl --shutdown
   ```

6. **Verify** the kernel version inside WSL:

   ```bash
   cat /proc/version
   uname -v
   ```

You should see the custom kernel and its build date.

---

### Option 2: Build the Kernel Yourself

1. **Clone** or **fork** this repository:
   
   ```bash
   git clone https://github.com/metabronx/blackstrap-wsl-kernel.git
   ```

2. **Build** with the provided PowerShell script. This script downloads the official WSL kernel source and compiles it with the `CONNMARK` configuration enabled:
   
   ```powershell
   # Default build (latest version)
   ./build.ps1

   # OR specify a particular WSL Linux version
   ./build.ps1 -WSLVersion linux-msft-wsl-5.15.167.4
   ```

   > **Note**: The build can take 10–15 minutes.

3. Once the build completes, you’ll have a **newly built kernel** at `/wsl-kernel-*` within the Docker image. To use it on Windows:
   1. **Create** a container from the built image (or use the `docker cp` approach).
   2. **Copy** the kernel file to your Windows filesystem.
   3. **Point** your `~/.wslconfig` to that file (see instructions under [Option 1](#option-1-download-the-pre-compiled-kernel)).

4. **Restart WSL**:

   ```powershell
   wsl --shutdown
   ```

5. **Confirm** the custom kernel:

   ```bash
   uname -v
   cat /proc/version
   ```

---


### Acknowledgments

- Original WSL2 kernel from [Microsoft’s WSL2-Linux-Kernel repository](https://github.com/microsoft/WSL2-Linux-Kernel).  
- Forked and customized to enable `CONNMARK` and other features needed by Istio, WireGuard, and more. 
