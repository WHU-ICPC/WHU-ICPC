## 为 A201 和 A301 分配静态IP

### 分配静态ip
sudo bash setip.sh


### 用systemd设置开机自动运行

sudo nano /etc/systemd/system/setip.service
```
[Unit]
Description=Set IP Address

[Service]
Type=oneshot
ExecStart=/home/acm/.scripts/setip/setip.sh

[Install]
WantedBy=multi-user.target
```


sudo chmod +x /home/acm/.scripts/setip/setip.sh
sudo systemctl daemon-reload
sudo systemctl enable setip.service

sudo reboot
