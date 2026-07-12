-- Env Variables
-- hl.env("GDK_SCALE", "2")
-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_SIZE", "24")

hl.env("QT_SCALE_FACTOR", "1")
hl.env("GDK_SCALE", "1")
hl.env("XCURSOR_SIZE", "32")

-- GPU priority
hl.env("AQ_DRM_DEVICES", "/dev/dri/card2:/dev/dri/card0")

-- Backend support
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")

hl.env("NVD_BACKEND", "direct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("HYPRSHOT_DIR", "/home/adetola/Pictures/Screenshot")
