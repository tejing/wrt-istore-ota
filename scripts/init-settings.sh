#!/bin/sh

. /etc/os-release
. /lib/functions/uci-defaults.sh

# 设置默认密码
# sed -i 's/root:::0:99999:7:::/root:$1$5mjCdAB1$Uk1sNbwoqfHxUmzRIeuZK1:0:0:99999:7:::/g' package/base-files/files/etc/shadow
# sed -i 's/root:::0:99999:7:::/root:$1$5mjCdAB1$Uk1sNbwoqfHxUmzRIeuZK1:0:0:99999:7:::/g' /etc/shadow

### 无线设置
# 删除现有无线配置
uci -q del wireless.default_radio2
uci -q del wireless.default_radio1
uci -q del wireless.default_radio0
uci -q del wireless.wifinet0
uci -q del wireless.wifinet1
uci -q del wireless.wifinet2

# 配置 5GHz 无线接口 (wifinet0)
uci -q set wireless.wifinet0=wifi-iface
uci -q set wireless.wifinet0.device='radio0'
uci -q set wireless.wifinet0.mode='ap'
uci -q set wireless.wifinet0.ssid='OpenWrt_5G'
uci -q set wireless.wifinet0.encryption='none'
uci -q set wireless.wifinet0.network='lan'

# 配置 5GHz 无线电 (radio0)
uci -q set wireless.radio0.htmode='VHT80'
uci -q set wireless.radio0.channel='36'   # 你可以选择合适的频道
uci -q set wireless.radio0.country='AU'   # 根据需要更改国家
uci -q set wireless.radio0.cell_density='3'
uci -q set wireless.radio0.disabled=0     # 启用 radio0

# 配置 2.4GHz 无线接口 (wifinet1)
uci -q set wireless.wifinet1=wifi-iface
uci -q set wireless.wifinet1.device='radio1'
uci -q set wireless.wifinet1.mode='ap'
uci -q set wireless.wifinet1.ssid='OpenWrt_2.4G'
uci -q set wireless.wifinet1.encryption='none'
uci -q set wireless.wifinet1.network='lan'

# 配置 2.4GHz 无线电 (radio1)
uci -q set wireless.radio1.htmode='HT40'
uci -q set wireless.radio1.channel='1'    # 你可以选择合适的频道
uci -q set wireless.radio1.country='AU'   # 根据需要更改国家
uci -q set wireless.radio1.cell_density='3'
uci -q set wireless.radio1.disabled=0     # 启用 radio1

# 提交更改并应用
uci commit wireless

exit 0
