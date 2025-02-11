#!/bin/sh
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "Enabling Nouveau for Wayland..."
    sudo modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia
    sudo modprobe nouveau
fi
