## A USRP-friendly image for LTE experimentation

Pulls the srsLTE project [srsLTE] (> 2.0), the USRP drivers from the [Ettus
Research PPA] and builds both eNodeB and UE binaries with the USRP as targeted
SDR front-end.

Since this is a [multistage] build, you need at least **Docker 17.05**.

Build with:

    docker build -t srs docker-srslte-usrp

## Build args

* `UBUNTU_VERSION` codename of the base Ubuntu (default `xenial`)
* `SRSLTE_REPO` source repo of srsLTE (default
  `https://github.com/srsLTE/srsLTE`)
* `SRSLTE_CHECKOUT` branch/tag/commit to check out (default `master`)

## Deploy

Run with:

    start.sh

This also mounts the conf directory to /conf for convenient config editing on
the host. Get example configs from the *srsenb* and *srsue* folders of the
source repo.

Run eNodeB directly (on the container):

    bash -c "srsenb enb.conf & tail --follow --retry /tmp/enb.log"

Use `uhd_find_device` to check if the container sees the USRP.

## TODO
- [ ] figure out required capabilities (instead of `--privileged`)


[srsLTE]: https://github.com/srslte/srslte
[Ettus Research PPA]: https://launchpad.net/~ettusresearch/+archive/ubuntu/uhd
[multistage]: https://docs.docker.com/engine/userguide/eng-image/multistage-build/
