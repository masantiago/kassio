# kassio

## Requirements
* kubectl
* k3d
* k9s
* helm
* helmfile

## Basic installation
### Cluster creation
- k3d cluster made of one master, and no workers
- External 8080 port to publish ingress
- Shared volume (`~/storage-local-path`) in host linked to local storage of rancher

```console
$ k3d cluster create kassio --port 8080:80@loadbalancer --volume ~/storage-local-path/:/var/lib/rancher/k3s/storage@all
```

### Default kassio intallation

Clone repository and export location of configuration:
```console
$ git clone -b feature/k3d_install git@github.com:masantiago/kassio.git 
$ cd kassio
$ export KASSIO_PATH=`pwd`
```

#### Only frontend ####
Default configuration in `defaul.yaml` only frontend is activated.

```console
$ helmfile --interactive apply
```
Include in `/etc/hosts` the local domain for the component:
```console
127.0.0.1   frontend.kassio
```

Go to URL `http://frontend.kassio:8080`. By default, it will response 404 due to the proxy constraints of Home Assistant. It must be configured to by pass it. Go to the `~/storage-local-path` and navegate to the pvc folder created for the frontend. There must be a file called `configuration.yaml`. Add the following lines:

```
# Proxy
http:
  use_x_forwarded_for: true
  trusted_proxies:
  - 127.0.0.1
  - 192.168.1.0/24 # Replace with your local network CIDR
  - 10.42.0.0/16
  - 10.43.0.0/16
```

Restart the deployment `kassio-frontend` from k9s. Use `r` shortcut. Retry again the URL.
