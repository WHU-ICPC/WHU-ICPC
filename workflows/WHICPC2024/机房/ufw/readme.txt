## 用ufw设置ip白名单


### 检查 iptables
```
acm@acm-Wenxiang-D660:/media/acm/hz$ sudo iptables -L -v
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
26960 1914K ACCEPT     all  --  lo     any     anywhere             anywhere            
    0     0 DROP       tcp  --  any    any     anywhere             anywhere             tcp dpt:x11
16809 5513K ACCEPT     all  --  any    any     anywhere             anywhere            

Chain FORWARD (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
26960 1914K ACCEPT     all  --  any    lo      anywhere             anywhere            
    0     0 ACCEPT     all  --  any    any     anywhere             anywhere
``` 

### 删除 ufw 规则前面的 accept any 规则，编号为 1-index
sudo iptables -D INPUT 3
sudo iptables -D OUTPUT 2


### 开启ufw
sudo bash ufw_setup.sh


### 保存修改
sudo sh -c 'iptables-save > /etc/iptables.rules'
