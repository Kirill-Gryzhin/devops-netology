data "yandex_compute_image" "ubuntu1" {
  family = var.vm_web_compute_image
}

resource "yandex_compute_instance" "platform1" {
    depends_on = [yandex_compute_instance.platform] 
    for_each = tomap ({for key ,value in var.vm_res : key => value})
name = each.value.name
platform_id  = each.value.platform_id
resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
 }
    boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type          = each.value.type
      size          = each.value.size
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
