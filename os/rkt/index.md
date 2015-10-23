---
title: rkt
layout: os-default

---

## rkt
---

As of RancherOS v0.4.0+, [rkt](https://github.com/coreos/rkt) works out of the box.

### Installing rkt

```sh
$ wget https://github.com/coreos/rkt/releases/download/v0.8.1/rkt-v0.8.1.tar.gz
$ gzip -dc rkt-v0.8.1.tar.gz | tar xvf -
$ cd rkt-v0.8.1
$ ./rkt help
```

### Start rkt Metadata Service

```sh
$ sudo ./rkt metadata &
```

### Running a container

```sh
$ sudo ./rkt run coreos.com/etcd:v2.0.4
```

### More info

For more information on running rkt and how it works, refer to the [official documentation](https://coreos.com/rkt/docs/).

<br>
