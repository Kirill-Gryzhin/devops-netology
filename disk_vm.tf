resource "yandex_compute_disk" "empty-disk" {
  count = 3
  name       = "empty-disk-${count.index +1}"
  type       = "network-hdd"
   image_id = data.yandex_compute_image.ubuntu.image_id
   size = 10
}



data "yandex_compute_image" "ubuntu2" {
  family = var.vm_web_compute_image
}

resource "yandex_compute_instance" "platform2" {
count = 1
platform_id = "standard-v1"
name = "storage"

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
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.empty-disk.*.id
    content {
      disk_id = secondary_disk.value
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
    
    ssh-keys           = "ubuntu:${local.ssh-key}"
    
  }
}