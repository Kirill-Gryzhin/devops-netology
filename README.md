# Задание 1

1. Изучите проект.
2. Заполните файл personal.auto.tfvars.
3. Инициализируйте проект, выполните код. Он выполнится, даже если доступа к preview нет.

Примечание. Если у вас не активирован preview-доступ к функционалу «Группы безопасности» в Yandex Cloud, запросите доступ у поддержки облачного провайдера. Обычно его выдают в течение 24-х часов.

Приложите скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud или скриншот отказа в предоставлении доступа к preview-версии.

------

# Ответ 1

![image](https://github.com/Kirill-Gryzhin/devops-netology/assets/137723281/0de74bbb-3b98-4a03-812b-8aaf41d30924)


# Задание 2

1. Создайте файл count-vm.tf. Опишите в нём создание двух **одинаковых** ВМ  web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )
2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ с именами "main" и "replica" **разных** по cpu/ram/disk , используя мета-аргумент **for_each loop**. Используйте для обеих ВМ одну общую переменную типа list(object({ vm_name=string, cpu=number, ram=number, disk=number  })). При желании внесите в переменную все возможные параметры.
3. ВМ из пункта 2.2 должны создаваться после создания ВМ из пункта 2.1.
4. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ 2.
5. Инициализируйте проект, выполните код.

------

# Ответ 2

1. 
```

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
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }

}
```
2. 3. 4. 
```
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
    serial-port-enable = var.vms_ssh_root_key.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh-key}"
    
  }
}
```
