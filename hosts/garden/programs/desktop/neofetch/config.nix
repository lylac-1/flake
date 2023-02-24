''
  print_info() {
    info title
    info "OS" distro
    info "KERNEL" kernel
    info "UP TIME" uptime
    info "PKG" packages

    #info "CPU" cpu
    #info "GPU" gpu
    #info "MEM" memory
    info cols
  }
  distro_shorthand="on"
  os_arch="off"
  uptime_shorthand="tiny"
  memory_unit="gib"
  cpu_brand="off"
  cpu_speed="off"
  cpu_cores="off"
  gpu_brand="off"
  block_width=2
  ascii_distro="nixos_small"
  ascii_bold="off"
''
