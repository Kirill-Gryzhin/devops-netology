### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote-модуля.
2. Создайте одну ВМ, используя этот модуль. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```.

------
###  Ответ 1

2. 
```
 data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
 vars = {
  ssh_public_key     = file("~/.ssh/id_ed25519.pub")
 }
```
 3.
 ``` 
 packages:
 - vim
 - nginx
```
 4.
 ```
 ydoolb@ydoolb-laptop:~/devops-netology$ ssh ubuntu@158.160.115.43
The authenticity of host '158.160.115.43 (158.160.115.43)' can't be established.
ED25519 key fingerprint is SHA256:YcQM4TGRGbGXWHfRoOyWWxjGo0dT0i8ovtimtWdmzFQ.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '158.160.115.43' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-156-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@develop-web-1:~$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
 ```

 ### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.vpc_dev.
6. Сгенерируйте документацию к модулю с помощью terraform-docs.    
 
Пример вызова

```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```

###  Ответ 2

1.
```
resource "yandex_vpc_network" "develop_net" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop_subnet" {
  name           = var.vpc_subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.develop_net.id
  v4_cidr_blocks = var.cidr
}
```
2.
```
module "vpc_dev" {
  source       = "./vpc"
  vpc_name        = "net"
  vpc_subnet_name     = "subnet"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}
```
3.
```
> module.vpc_dev
{
  "develop_net" = (known after apply)
  "develop_subnet" = (known after apply)
  "develop_subnet_zone" = (known after apply)
}
```
4.
```
ydoolb@ydoolb-laptop:~/devops-netology$ terraform state list
data.template_file.cloudinit
yandex_vpc_network.develop
yandex_vpc_subnet.develop
module.test-vm.data.yandex_compute_image.my_image
module.test-vm.yandex_compute_instance.vm[0]
module.test-vm.yandex_compute_instance.vm[1]
module.vpc_dev.yandex_vpc_network.develop_net
module.vpc_dev.yandex_vpc_subnet.develop_subnet
```
5.
```
> module.vpc_dev
{
  "develop_net" = "enpeq5dh5mtd9iti900m"
  "develop_subnet" = "e9bbhouic3m7ccv4381o"
  "develop_subnet_zone" = "ru-central1-a"
}
```
6.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.97.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.develop_net](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.develop_subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | n/a | `list(string)` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `null` | no |
| <a name="input_vpc_subnet_name"></a> [vpc\_subnet\_name](#input\_vpc\_subnet\_name) | n/a | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_develop_net"></a> [develop\_net](#output\_develop\_net) | n/a |
| <a name="output_develop_subnet"></a> [develop\_subnet](#output\_develop\_subnet) | n/a |
| <a name="output_develop_subnet_zone"></a> [develop\_subnet\_zone](#output\_develop\_subnet\_zone) | n/a |

### Задание 3
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.

### Ответ 3

1.
```
ydoolb@ydoolb-laptop:~/devops-netology$ terraform state list
data.template_file.cloudinit
yandex_vpc_network.develop
yandex_vpc_subnet.develop
module.test-vm.data.yandex_compute_image.my_image
module.test-vm.yandex_compute_instance.vm[0]
module.test-vm.yandex_compute_instance.vm[1]
module.vpc_dev.yandex_vpc_network.develop_net
module.vpc_dev.yandex_vpc_subnet.develop_subnet
```

2.
```
ydoolb@ydoolb-laptop:~/devops-netology$ terraform state rm module.vpc_dev
Removed module.vpc_dev.yandex_vpc_network.develop_net
Removed module.vpc_dev.yandex_vpc_subnet.develop_subnet
Successfully removed 2 resource instance(s).
```

3.
```
ydoolb@ydoolb-laptop:~/devops-netology$ terraform state rm module.test-vm
Removed module.test-vm.data.yandex_compute_image.my_image
Removed module.test-vm.yandex_compute_instance.vm[0]
Removed module.test-vm.yandex_compute_instance.vm[1]
Successfully removed 3 resource instance(s).
```

4.
```
ydoolb@ydoolb-laptop:~/devops-netology$ terraform import 'module.vpc_dev.yandex_vpc_network.develop_net' enpeq5dh5mtd9iti900m

data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=243b8d9d4e0f64adf4a76631c0f03f041874151ec3941b7b06f38fbd22122378]
module.vpc_dev.yandex_vpc_network.develop_net: Importing from ID "enpeq5dh5mtd9iti900m"...
module.vpc_dev.yandex_vpc_network.develop_net: Import prepared!
  Prepared yandex_vpc_network for import
module.vpc_dev.yandex_vpc_network.develop_net: Refreshing state... [id=enpeq5dh5mtd9iti900m]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.test-vm.data.yandex_compute_image.my_image: Read complete after 0s [id=fd8pqclrbi85ektgehlf]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

```
terraform import 'module.vpc_dev.yandex_vpc_subnet.develop_subnet' e9bbhouic3m7ccv4381o

data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=243b8d9d4e0f64adf4a76631c0f03f041874151ec3941b7b06f38fbd22122378]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc_dev.yandex_vpc_subnet.develop_subnet: Importing from ID "e9bbhouic3m7ccv4381o"...
module.vpc_dev.yandex_vpc_subnet.develop_subnet: Import prepared!
  Prepared yandex_vpc_subnet for import
module.vpc_dev.yandex_vpc_subnet.develop_subnet: Refreshing state... [id=e9bbhouic3m7ccv4381o]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 0s [id=fd8pqclrbi85ektgehlf]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```
```
ydoolb@ydoolb-laptop:~/devops-netology$ terraform import 'module.test-vm.yandex_compute_instance.vm[0]' fhme2nqjaltk0dp0qe2h

data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=243b8d9d4e0f64adf4a76631c0f03f041874151ec3941b7b06f38fbd22122378]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.test-vm.data.yandex_compute_image.my_image: Read complete after 0s [id=fd8pqclrbi85ektgehlf]
module.test-vm.yandex_compute_instance.vm[0]: Importing from ID "fhme2nqjaltk0dp0qe2h"...
module.test-vm.yandex_compute_instance.vm[0]: Import prepared!
  Prepared yandex_compute_instance for import
module.test-vm.yandex_compute_instance.vm[0]: Refreshing state... [id=fhme2nqjaltk0dp0qe2h]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

```
ydoolb@ydoolb-laptop:~/devops-netology$ terraform import 'module.test-vm.yandex_compute_instance.vm[1]' fhmriuc8gbofsrh3k0ik 

module.test-vm.data.yandex_compute_image.my_image: Reading...
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=243b8d9d4e0f64adf4a76631c0f03f041874151ec3941b7b06f38fbd22122378]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 1s [id=fd8pqclrbi85ektgehlf]
module.test-vm.yandex_compute_instance.vm[1]: Importing from ID "fhmriuc8gbofsrh3k0ik"...
module.test-vm.yandex_compute_instance.vm[1]: Import prepared!
  Prepared yandex_compute_instance for import
module.test-vm.yandex_compute_instance.vm[1]: Refreshing state... [id=fhmriuc8gbofsrh3k0ik]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

```
ydoolb@ydoolb-laptop:~/devops-netology$ terraform plan
Acquiring state lock. This may take a few moments...
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=243b8d9d4e0f64adf4a76631c0f03f041874151ec3941b7b06f38fbd22122378]
module.test-vm.data.yandex_compute_image.my_image: Reading...
yandex_vpc_network.develop: Refreshing state... [id=enp2egvc3dtfoe3fv2pc]
module.vpc_dev.yandex_vpc_network.develop_net: Refreshing state... [id=enpeq5dh5mtd9iti900m]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 0s [id=fd8pqclrbi85ektgehlf]
yandex_vpc_subnet.develop: Refreshing state... [id=e9bio8ai4kbhf0t5mvso]
module.vpc_dev.yandex_vpc_subnet.develop_subnet: Refreshing state... [id=e9bbhouic3m7ccv4381o]
module.test-vm.yandex_compute_instance.vm[1]: Refreshing state... [id=fhmriuc8gbofsrh3k0ik]
module.test-vm.yandex_compute_instance.vm[0]: Refreshing state... [id=fhme2nqjaltk0dp0qe2h]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # module.test-vm.yandex_compute_instance.vm[0] will be updated in-place
  ~ resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
        id                        = "fhme2nqjaltk0dp0qe2h"
        name                      = "develop-web-0"
        # (11 unchanged attributes hidden)

      - timeouts {}

        # (6 unchanged blocks hidden)
    }

  # module.test-vm.yandex_compute_instance.vm[1] will be updated in-place
  ~ resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
        id                        = "fhmriuc8gbofsrh3k0ik"
        name                      = "develop-web-1"
        # (11 unchanged attributes hidden)

      - timeouts {}

        # (6 unchanged blocks hidden)
    }

Plan: 0 to add, 2 to change, 0 to destroy.
```