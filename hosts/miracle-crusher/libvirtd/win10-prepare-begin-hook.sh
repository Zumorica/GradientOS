set +o errexit
set +o nounset
set +o pipefail

GUEST_NAME="$1"
HOOK_NAME="$2"
STATE_NAME="$3"

if [ "$GUEST_NAME" != "win10" ] || [ "$HOOK_NAME" != "prepare" ] || [ "$STATE_NAME" != "begin" ]; then
    exit 0
fi

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# Unbind EFI Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Stop plasma wayland
systemctl --user --machine=vera@ stop plasma-\*
systemctl stop display-manager.service

sleep 5

# Start default network
virsh net-start default

# Kill anything still using the GPU.
kill -9 "$(lsof | grep amdgpu | awk '$2 != "PID" { print $2 }')"

# Unload AMDGPU kernel module
modprobe -r -a -f drm_kms_helper amdgpu drm

# Detach GPU from host
virsh nodedev-detach pci_0000_26_00_0
virsh nodedev-detach pci_0000_27_00_0
virsh nodedev-detach pci_0000_28_00_0
virsh nodedev-detach pci_0000_28_00_1
virsh nodedev-detach pci_0000_28_00_2
virsh nodedev-detach pci_0000_28_00_3

sleep 10

# Load VFIO kernel modules
modprobe -a -f vfio vfio_pci vfio_iommu_type1