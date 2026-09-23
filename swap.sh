#!/bin/bash

# =====================================
# Swap Space Creation Script
# Student Name:
# Roll Number:
# =====================================

# Exit immediately if a command exits with a non-zero status
set -e

SWAP_FILE="/swapfile"
SWAP_SIZE_MB=1024 # 1 GB Swap space

echo "======================================"
echo " Linux Swap Space Creation Practical"
echo "======================================"

# 1. Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run as root." >&2
    exit 1
fi

# 2. Check if a swap file already exists at the location
if [ -f "$SWAP_FILE" ]; then
    echo "WARNING: $SWAP_FILE already exists. Deactivating and removing it to reinitialize..."
    swapoff "$SWAP_FILE" || true
    rm -f "$SWAP_FILE"
fi

# 3. Create the empty storage space for the swap file
echo "Step 1: Allocating ${SWAP_SIZE_MB}MB space at ${SWAP_FILE}..."
# dd is used here for universal compatibility across older and newer filesystems
dd if=/dev/zero of="$SWAP_FILE" bs=1M count=$SWAP_SIZE_MB status=progress

# 4. Secure the swap file permissions (Crucial step: Only root can read/write)
echo "Step 2: Restricting file permissions (chmod 600)..."
chmod 600 "$SWAP_FILE"

# 5. Format the allocated file as Linux Swap space
echo "Step 3: Formatting file as swap partition area..."
mkswap "$SWAP_FILE"

# 6. Enable the newly created swap space
echo "Step 4: Activating the swap space..."
swapon "$SWAP_FILE"

# 7. Add to /etc/fstab for persistent mounting on reboot if not already present
echo "Step 5: Configuring persistent mount in /etc/fstab..."
if grep -q "$SWAP_FILE" /etc/fstab; then
    echo "Fstab entry already exists."
else
    echo "$SWAP_FILE swap swap defaults 0 0" >> /etc/fstab
    echo "Added entry to /etc/fstab successfully."
fi

# 8. Verify the new swap space status
echo -e "\n======================================"
echo " Verification:"
echo "======================================"
swapon --show
echo -e "\nMemory summary details:"
free -h

echo -e "\nSwap space created successfully!"
exit 0
