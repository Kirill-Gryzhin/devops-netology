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

5.
``` 
ydoolb@ydoolb-Vostro-5490:~/ter-homeworks/01/src$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
14bb9beb9954   021283c8eb95   "/docker-entrypoint.…"   12 seconds ago   Up 11 seconds   0.0.0.0:8000->80/tcp   example_8KVD07LFwoGI10lw
```

6. -auto-apply применяет конфигурацию без подтверждения, что может вызвать неожиданные неприятные последствия, вплоть до критических.

```
ydoolb@ydoolb-Vostro-5490:~/ter-homeworks/01/src$ sudo terraform apply -auto-approve
docker_image.nginx: Refreshing state... [id=sha256:021283c8eb95be02b23db0de7f609d603553c6714785e7a673c6594a624ffbdanginx:latest]
random_password.random_string: Refreshing state... [id=none]
docker_container.nginx: Refreshing state... [id=14bb9beb99547cef660eb9ff00e1103a60d33db09060e975ff2de4f1cd45df58]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # docker_container.hello_world will be created
  + resource "docker_container" "hello_world" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = "sha256:021283c8eb95be02b23db0de7f609d603553c6714785e7a673c6594a624ffbda"
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = (sensitive value)
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + ports {
          + external = 8000
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_container.nginx will be destroyed
  # (because docker_container.nginx is not in configuration)
  - resource "docker_container" "nginx" {
      - attach                                      = false -> null
      - command                                     = [
          - "nginx",
          - "-g",
          - "daemon off;",
        ] -> null
      - container_read_refresh_timeout_milliseconds = 15000 -> null
      - cpu_shares                                  = 0 -> null
      - dns                                         = [] -> null
      - dns_opts                                    = [] -> null
      - dns_search                                  = [] -> null
      - entrypoint                                  = [
          - "/docker-entrypoint.sh",
        ] -> null
      - env                                         = [] -> null
      - group_add                                   = [] -> null
      - hostname                                    = "14bb9beb9954" -> null
      - id                                          = "14bb9beb99547cef660eb9ff00e1103a60d33db09060e975ff2de4f1cd45df58" -> null
      - image                                       = "sha256:021283c8eb95be02b23db0de7f609d603553c6714785e7a673c6594a624ffbda" -> null
      - init                                        = false -> null
      - ipc_mode                                    = "private" -> null
      - log_driver                                  = "json-file" -> null
      - log_opts                                    = {} -> null
      - logs                                        = false -> null
      - max_retry_count                             = 0 -> null
      - memory                                      = 0 -> null
      - memory_swap                                 = 0 -> null
      - must_run                                    = true -> null
      - name                                        = (sensitive value) -> null
      - network_data                                = [
          - {
              - gateway                   = "172.17.0.1"
              - global_ipv6_address       = ""
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.17.0.2"
              - ip_prefix_length          = 16
              - ipv6_gateway              = ""
              - mac_address               = "02:42:ac:11:00:02"
              - network_name              = "bridge"
            },
        ] -> null
      - network_mode                                = "default" -> null
      - privileged                                  = false -> null
      - publish_all_ports                           = false -> null
      - read_only                                   = false -> null
      - remove_volumes                              = true -> null
      - restart                                     = "no" -> null
      - rm                                          = false -> null
      - runtime                                     = "runc" -> null
      - security_opts                               = [] -> null
      - shm_size                                    = 64 -> null
      - start                                       = true -> null
      - stdin_open                                  = false -> null
      - stop_signal                                 = "SIGQUIT" -> null
      - stop_timeout                                = 0 -> null
      - storage_opts                                = {} -> null
      - sysctls                                     = {} -> null
      - tmpfs                                       = {} -> null
      - tty                                         = false -> null
      - wait                                        = false -> null
      - wait_timeout                                = 60 -> null

      - ports {
          - external = 8000 -> null
          - internal = 80 -> null
          - ip       = "0.0.0.0" -> null
          - protocol = "tcp" -> null
        }
    }

Plan: 1 to add, 0 to change, 1 to destroy.
docker_container.nginx: Destroying... [id=14bb9beb99547cef660eb9ff00e1103a60d33db09060e975ff2de4f1cd45df58]
docker_container.hello_world: Creating...
docker_container.nginx: Destruction complete after 0s
╷
│ Error: Unable to create container: Error response from daemon: Conflict. The container name "/example_8KVD07LFwoGI10lw" is already in use by container "14bb9beb99547cef660eb9ff00e1103a60d33db09060e975ff2de4f1cd45df58". You have to remove (or rename) that container to be able to reuse that name.
│ 
│   with docker_container.hello_world,
│   on main.tf line 30, in resource "docker_container" "hello_world":
│   30: resource "docker_container" "hello_world" {
```

Вывод команды  docker ps 
```
ydoolb@ydoolb-Vostro-5490:~/ter-homeworks/01/src$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
8.
```
{
  "version": 4,
  "terraform_version": "1.5.3",
  "serial": 10,
  "lineage": "fb191514-d4df-8f30-3363-250a71f6c027",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

9. keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
    
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
