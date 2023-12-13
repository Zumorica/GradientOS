set +o errexit
set +o nounset
set +o pipefail

GUEST_NAME="$1"
HOOK_NAME="$2"
STATE_NAME="$3"

if [ "$GUEST_NAME" != "win10" ] || [ "$HOOK_NAME" != "release" ] || [ "$STATE_NAME" != "end" ]; then
    exit 0
fi

# Stop default network
virsh net-destroy default

# Unload VFIO kernel modules
modprobe -r -a -f vfio vfio_pci vfio_iommu_type1

# Reattach GPU TO host
virsh nodedev-reattach pci_0000_26_00_0
virsh nodedev-reattach pci_0000_27_00_0
virsh nodedev-reattach pci_0000_28_00_0
virsh nodedev-reattach pci_0000_28_00_1
virsh nodedev-reattach pci_0000_28_00_2
virsh nodedev-reattach pci_0000_28_00_3

# Load AMDGPU kernel module
modprobe -a -f drm amdgpu drm_kms_helper

sleep 5

# Bind EFI Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

# Bind VTconsoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# Start plasma wayland
systemctl --user --machine=vera@ restart plasma-\*
systemctl restart display-manager.service