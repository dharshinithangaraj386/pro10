#!/usr/bin/env bats

@test "swap.sh exists" {
    [ -f swap.sh ]
}

@test "swap.sh executable" {
    [ -x swap.sh ]
}

@test "Uses swapoff command" {
    run grep "swapoff" swap.sh
    [ "$status" -eq 0 ]
}

@test "Removes existing swapfile" {
    run grep "rm -f /swapfile" swap.sh
    [ "$status" -eq 0 ]
}

@test "Creates swap file" {
    run grep "dd if=/dev/zero" swap.sh
    [ "$status" -eq 0 ]
}

@test "Uses chmod 600" {
    run grep "chmod 600 /swapfile" swap.sh
    [ "$status" -eq 0 ]
}

@test "Creates swap signature" {
    run grep "mkswap /swapfile" swap.sh
    [ "$status" -eq 0 ]
}

@test "Activates swap" {
    run grep "swapon /swapfile" swap.sh
    [ "$status" -eq 0 ]
}

@test "Displays swap" {
    run grep "swapon --show" swap.sh
    [ "$status" -eq 0 ]
}
