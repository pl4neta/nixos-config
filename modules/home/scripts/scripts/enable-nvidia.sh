#!/bin/sh
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    echo "Enabling NVIDIA for Wayland..."
    sudo modprobe -r nouveau
    sudo modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia
fi
