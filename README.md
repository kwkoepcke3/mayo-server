```
echo "net.ipv4.ip_unprivileged_port_start=80" | sudo tee /etc/sysctl.d/99-unprivileged-ports.conf
sudo sysctl --system

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

sudo loginctl enable-linger ${USER}
```

## Traefik
+ $CLOUDFLARE\_EMAIL='example@example.com'
+ $CLOUDFLARE\_DNS\_API\_TOKEN='exampleexampleexample'
+ $TRAEFIK\_BASICAUTH\_ADMIN='example:example'
