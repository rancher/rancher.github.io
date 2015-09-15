---
title: Contributing to RancherOS
layout: os-default

---

## Contributing to RancherOS
---

### Developing

Development is easiest done with QEMU on Linux. OS X works too, although QEMU doesn't have KVM support then. If you are running Linux in a virtual machine, then we recommend you run VMWare Fusion/Workstation and enable VT-x support.  Then QEMU will have KVM support and run sufficiently fast inside your Linux VM.

#### Building

Bash, Docker 1.8+ and Make required.

```bash
$ ./build.sh
```

The build will run in a docker container named "ros-build". When the build is done, the ISO, vmlinuz and initrd should be in `dist/artifacts`. 

Run `./build.sh` (or `make all`) to perform the full build.  After that, if you only make changes to the Go code, just run `make`. Otherwise (e.g. on changes to make files, 'build.conf' or 'os-config.yml'), run the full build again.

#### Testing

Run `time KVM=1 ./scripts/ci` to run the all integration tests. The tests will run in a docker container named "ros-ci".

#### Running

Prerequisites: QEMU, coreutils, cdrtools/genisoimage/mkisofs. 
On OS X, `brew` is recommended to install those. On Linux, use your distro package manager.

To launch RancherOS in QEMU from your dev version, run `./scripts/run`. You can use `--append your.kernel=params here` and `--cloud-config your-cloud-config.yml` to configure the RancherOS instance you're launching.

You can SSH in using `./scripts/ssh`.  Your SSH keys should have been populated (if you didn't provide your own cloud-config) so you won't need a password.  If you don't have SSH keys, or something is wrong with your cloud-config, then the password is "`rancher`".

If you're on OS X, you can run RancherOS using [_xhyve_](https://github.com/mist64/xhyve) instead of QEMU: just pass `--xhyve` to `./scripts/run` and `./scripts/ssh`.


### Repositories

All of repositories are located within our main GitHub [page](https://github.com/rancher). 

[RancherOS Repo](https://github.com/rancher/os): This repo contains the bulk of the RancherOS code.

[RancherOS Images Repo](https://github.com/rancher/os-images): This repo is for RancherOS system container images.

[RancherOS Services Repo](https://github.com/rancher/os-services): This repo is where any [system-services]({{site.baseurl}}/os/system-services/) can be contributed.

[RancherOS Vagrant Repo](https://github.com/rancher/os-vagrant): We've created an easy way to spin up RancherOS using [Vagrant]({{site.baseurl}}/os/getting-started/docs). 


### Bugs

If you find any bugs or are having any trouble, please contact us by filing an [issue](https://github.com/rancher/os/issues/new). 

If you have any updates to our documentation, please make any PRs to our [docs repo](https://github.com/rancher/rancher.github.io).

<br>
<br>