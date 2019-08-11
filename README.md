Minimal KiCad image based on Ubuntu
===================================

This is a Docker image contains specific versions of the [KiCad EDA suite]. It
has a minimal amount of cruft left behind from installation and no KiCad
libraries.

It is designed to be used as a base for more purpose specific images.

Versions
--------

This image makes it possible to use specific combinations of Ubuntu and KiCad
versions. The image tags are formatted in the folowing way:

	<kicad version>-<ubuntu version>

E.g, to run KiCad 4.07 on Ubuntu 16.04 use:

	docker run -it productize/kicad:4.07-16.04

Alternativly, just using the KiCad version will use the KiCad version on the
latest stable Ubuntu release. The `latest` tag contains the latest KiCad stable
release on the latest Ubuntu stable release.

[KiCad EDA suite]: http://kicad-pcb.org/

Local build
-----------

There are two scripts for convenience to allow build specific version of KiCad
on top of specific version of Ubuntu and start the container with host user
priviledges and map host user home to container home to be able access local
files.

First clone this repo:

```
git clone <paste link copied from right pane here>
```

To build the container image with default versions (KiCad 5.1, Ubuntu 19.04) run:

```
./docker-kicad-build
```

then start the container simply with

```
./docker-kicad-start
```

For specific versions, for example KiCad 5.0 and Ubuntu 19.04 create image with below
command. Note that only versions which are available in https://launchpad.net/~js-reynaud
can be build. These scripts don't compile KiCad, only ready made packages are installed:

```
./docker-kicad-build 5 19.04
```

and start it with:

```
./docker-kicad-start 5 19.04
```

have a look at scripts and Dockerfile for details if something doesn't work.
