# Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте. 
2. Изучите файл **.gitignore**. В каком terraform файле согласно этому .gitignore допустимо сохранить личную, секретную информацию?
3. Выполните код проекта. Найдите  в State-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
4. Раскомментируйте блок кода, примерно расположенный на строчках 29-42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.
5. Выполните код. В качестве ответа приложите вывод команды ```docker ps```
6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы все еще продолжаем использовать name = "nginx:latest"! Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чем может быть опасность применения ключа  ```-auto-approve``` ? В качестве ответа дополнительно приложите вывод команды ```docker ps```
8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
9. Объясните, почему при этом не был удален docker образ **nginx:latest** ? Ответ подкрепите выдержкой из документации **провайдера docker**.

#  Ответ 1

![image](https://github.com/Kirill-Gryzhin/devops-netology/assets/137723281/067d8f31-3641-4103-993b-563a9f1d2d16)


1. ![image](https://github.com/Kirill-Gryzhin/devops-netology/assets/137723281/432ea2d7-c230-4cf9-a347-20c4ca936a53)

2. Секретная личная информация должна хранится в файле personal.auto.tfvars

3. "result": "8KVD07LFwoGI10lw",

4. Ошибка в синтаксисе названия Docker  контейнера, написано lnginx  вместо nginx.

![image](https://github.com/Kirill-Gryzhin/devops-netology/assets/137723281/ca28691a-808a-43dc-92fe-9c487f4e2b07)
 
- Осталась по прежнему закомментирована часть кода с указанием названия  Docker image nginx:latest

 
- random_string_FAKE не прописан в корневом модуле, у нас прописан random_string, а также ошибка синтаксиса resulT, а должно быть result

![image](https://github.com/Kirill-Gryzhin/devops-netology/assets/137723281/4f7455e1-2ee0-457d-a5d1-50dbaa40299a)

- не прописано имя для Docker_image

- после исправления результат:

![image](https://github.com/Kirill-Gryzhin/devops-netology/assets/137723281/647022d0-1b33-48d6-8b47-e5d987e17f55)

# Задание 2*

1. Изучите в документации provider [**Virtualbox**](https://docs.comcloud.xyz/providers/shekeriev/virtualbox/latest/docs) от 
shekeriev.
2. Создайте с его помощью любую виртуальную машину. Чтобы не использовать VPN советуем выбрать любой образ с расположением в github из [**списка**](https://www.vagrantbox.es/)

В качестве ответа приложите plan для создаваемого ресурса и скриншот созданного в VB ресурса. 

#  Ответ 2

``` 
ydoolb@ydoolb-Vostro-5490:~/Shekeriev$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # virtualbox_vm.vm1 will be created
  + resource "virtualbox_vm" "vm1" {
      + cpus   = 1
      + id     = (known after apply)
      + image  = "https://github.com/tommy-muehle/puppet-vagrant-boxes/releases/download/1.1.0/centos-7.0-x86_64.box"
      + memory = "512 mib"
      + name   = "Centos-7"
      + status = "running"

      + network_adapter {
          + device                 = "IntelPro1000MTDesktop"
          + host_interface         = "vboxnet1"
          + ipv4_address           = (known after apply)
          + ipv4_address_available = (known after apply)
          + mac_address            = (known after apply)
          + status                 = (known after apply)
          + type                   = "hostonly"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + IPAddress = (known after apply)

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

![image](https://github.com/Kirill-Gryzhin/devops-netology/assets/137723281/c8bf458b-3784-4174-b302-e5b5e8009771)
