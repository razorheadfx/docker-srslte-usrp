## A USRP-friendly image for LTE experimentation

Pulls the srsLTE project [srsLTE](https://github.com/srslte/srslte) (> 2.0),  the USRP drivers from the [Ettus Research PPA](https://launchpad.net/~ettusresearch/+archive/ubuntu/uhd) and builds both eNodeB and UE binaries with the USRP as targeted SDR front-end.

Build with:

    docker build -t srs docker-srslte-usrp/

Run with:
```
#this also mounts the conf directory to /conf for convenient ue config editing on the host
#cd docker-srslte-usrp
start.sh
```

Run eNodeB directly:

    bash -c "srsenb enb.conf & tail --follow=/tmp/enb.log --retry"

TODO:
- [ ] [reduce size][multistage] (built image weighs in around 1.15GB)
- [ ] figure out required capabilities (instead of `--privileged`)


[multistage]: https://docs.docker.com/engine/userguide/eng-image/multistage-build/
