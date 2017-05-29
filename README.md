## A USRP-friendly image for LTE experimentation
  
Pulls the srs projects [srsLTE](https://github.com/srslte/srslte) and [srsUE](https://github.com/srsLTE/srsUE), the USRP drivers from the [Ettus Research PPA](https://launchpad.net/~ettusresearch/+archive/ubuntu/uhd) and builds both eNodeB and UE stack+PHY with the USRP as targeted SDR front-end.  

Run with:
```
docker run -i -t --privileged -v /dev/bus/usb:/dev/bus/usb <image_name> bash

```
  
TODO:  
 - [ ] reduce size (built image weighs in around 1.1GB)
