#!/bin/bash
set -e

echo "=== 更新系统 ==="
sudo pacman -Syu --noconfirm

echo "=== 安装基本图形环境（Wayland + drivers）==="
sudo pacman -S --noconfirm \
    mesa \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal-gtk \
    wlroots \
    wayland \
    wayland-protocols \
    libinput \
    seatd \
    dbus \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji

echo "=== 安装 niri + ghostty ==="
sudo pacman -S --noconfirm niri ghostty

echo "=== 安装输入法 ibus + rime ==="
sudo pacman -S --noconfirm ibus ibus-rime

echo "=== 安装显示管理器 sddm ==="
sudo pacman -S --noconfirm sddm
sudo systemctl enable sddm

# ⚠️ 替换为 lightdm 如下：
# sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
# sudo systemctl enable lightdm

echo "=== 添加启动 Niri 所需环境变量 ==="
cat <<EOF >> ~/.profile

# --- Wayland 输入法环境变量 (ibus) ---
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export INPUT_METHOD=ibus
ibus-daemon -drx

# --- 启动 seatd（需要 niri 权限）---
[ -z \$WAYLAND_DISPLAY ] && seatd-launch
EOF

echo "=== 设置 SDDM 自动登录（可选）==="
read -p "设置自动登录当前用户？(y/N): " AUTOLOGIN
if [[ "$AUTOLOGIN" == "y" ]]; then
    USERNAME=$(whoami)
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Autologin]\nUser=${USERNAME}\nSession=niri.desktop" | sudo tee /etc/sddm.conf.d/autologin.conf
fi

echo "=== 完成！建议重启系统 ==="
