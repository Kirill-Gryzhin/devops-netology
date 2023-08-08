
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_compute_image
}

resource "yandex_compute_instance" "platform" {
count = 2
platform_id = "standard-v1"
name = "web-${count.index +1}"

resources {
    cores  = 2
    memory = 1
    core_fraction = 5
  }
    boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = 10
    }   
    }
  
  scheduling_policy {
    preemptible = true
  }

network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true

    security_group_ids = [yandex_vpc_security_group.example.id]
}
 
 metadata = {
    serial-port-enable = var.vms_ssh_root_key.serial-port-enable
    ssh-keys           = var.vms_ssh_root_key.ssh-keys
  }

}
