# Reset flags set by writeShellApplication
set +o errexit
set +o nounset
set +o pipefail

GUEST_NAME="$1"
HOOK_NAME="$2"
STATE_NAME="$3"

if [ "$GUEST_NAME" != "win10" ]; then
    exit 0
fi

if [ "$HOOK_NAME" == "prepare" ] && [ "$STATE_NAME" == "begin" ]; then
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
    virsh nodedev-detach pci_0000_28_00_0
    virsh nodedev-detach pci_0000_28_00_1
    virsh nodedev-detach pci_0000_28_00_2
    virsh nodedev-detach pci_0000_28_00_3

    sleep 10

    # Load VFIO kernel modules
    modprobe -a -f vfio vfio_pci vfio_iommu_type1
    exit 0
elif [ "$HOOK_NAME" == "release" ] && [ "$STATE_NAME" == "end" ]; then
    # Stop default network
    virsh net-destroy default

    # Unload VFIO kernel modules
    modprobe -r -a -f vfio vfio_pci vfio_iommu_type1

    # Reattach GPU TO host
    virsh nodedev-reattach pci_0000_28_00_0
    virsh nodedev-reattach pci_0000_28_00_1
    virsh nodedev-reattach pci_0000_28_00_2
    virsh nodedev-reattach pci_0000_28_00_3

    sleep 5

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
fi