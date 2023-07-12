
# Задача 1

Сценарий выполнения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберите любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```

Опубликуйте созданный fork в своём репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

# Ответ 1

https://hub.docker.com/r/gryzhinka/nginx

# Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
«Подходит ли в этом сценарии использование Docker-контейнеров или лучше подойдёт виртуальная машина, физическая машина? Может быть, возможны разные варианты?»

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- высоконагруженное монолитное Java веб-приложение;
- Nodejs веб-приложение;
- мобильное приложение c версиями для Android и iOS;
- шина данных на базе Apache Kafka;
- Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana;
- мониторинг-стек на базе Prometheus и Grafana;
- MongoDB как основное хранилище данных для Java-приложения;
- Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry.

# Ответ 2

- высоконагруженное монолитное Java веб-приложение - Docker  подходит, лучше виртуальная машина (аппаратная виртуализация) или физический сервер, поскольку высокие нагрузки.
- Nodejs веб-приложение - Docker  думаю подойдет не обязательно устанавливать ОС для веб приложения, но возможно использование виртуальной машины.
- мобильное приложение c версиями для Android и iOS - Docker, так как приложения на разных платформах и не будут пересикаться.
- шина данных на базе Apache Kafka - вероятно Docker, не знаком с данным приложением, но предполагаю, так как она есть в репозитории Docker hub.
- Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana -Docker, проще снимать логи со всех машин.
- мониторинг-стек на базе Prometheus и Grafana - Docker не требует много ресурсов и один хост с контейнерами дослжен справится на ура.
- MongoDB как основное хранилище данных для Java-приложения -Виртуальная машина(аппаратная виртуализация) или физический сервер, возможны высокие нагрузки и быстрый отклик.
- Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry Docker - взаимодействие можно напстроить в Docker networks.

# Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
- Добавьте ещё один файл в папку ```/data``` на хостовой машине.
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

# Ответ 3

- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.

```
root@ydoolb-Vostro-5490:/home/ydoolb# docker run -d -t -v data:/data centos 
d07a1c5addbb786b5805506daca4b9b0f21780cfbf7884b2851f9d77640eb5b2
root@ydoolb-Vostro-5490:/home/ydoolb# docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED         STATUS         PORTS     NAMES
d07a1c5addbb   centos    "/bin/bash"   4 seconds ago   Up 3 seconds             serene_newton
root@ydoolb-Vostro-5490:/home/ydoolb# docker exec -ti serene_newton /bin/bash
[root@d07a1c5addbb /]# ls -lh
total 52K
lrwxrwxrwx   1 root root    7 Nov  3  2020 bin -> usr/bin
drwxr-xr-x   2 root root 4.0K Jul 12 08:55 data
drwxr-xr-x   5 root root  360 Jul 12 09:09 dev
drwxr-xr-x   1 root root 4.0K Jul 12 09:09 etc
drwxr-xr-x   2 root root 4.0K Nov  3  2020 home
lrwxrwxrwx   1 root root    7 Nov  3  2020 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Nov  3  2020 lib64 -> usr/lib64
drwx------   2 root root 4.0K Sep 15  2021 lost+found
drwxr-xr-x   2 root root 4.0K Nov  3  2020 media
drwxr-xr-x   2 root root 4.0K Nov  3  2020 mnt
drwxr-xr-x   2 root root 4.0K Nov  3  2020 opt
dr-xr-xr-x 394 root root    0 Jul 12 09:09 proc
dr-xr-x---   2 root root 4.0K Sep 15  2021 root
drwxr-xr-x  11 root root 4.0K Sep 15  2021 run
lrwxrwxrwx   1 root root    8 Nov  3  2020 sbin -> usr/sbin
drwxr-xr-x   2 root root 4.0K Nov  3  2020 srv
dr-xr-xr-x  13 root root    0 Jul 12 09:09 sys
drwxrwxrwt   7 root root 4.0K Sep 15  2021 tmp
drwxr-xr-x  12 root root 4.0K Sep 15  2021 usr
drwxr-xr-x  20 root root 4.0K Sep 15  2021 var
```

- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.


```
root@ydoolb-Vostro-5490:/home/ydoolb# docker run -d -t -v data:/data debian
020a35b2adf71bb4dc5a35ed3a67dd29c424131a6018e0ccde83aa28ed5acad1
root@ydoolb-Vostro-5490:/home/ydoolb# docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
020a35b2adf7   debian    "bash"        4 seconds ago    Up 3 seconds              clever_tu
d07a1c5addbb   centos    "/bin/bash"   19 minutes ago   Up 19 minutes             serene_newton
root@ydoolb-Vostro-5490:/home/ydoolb# docker exec -ti clever_tu bash
root@020a35b2adf7:/# ls -lh
total 52K
lrwxrwxrwx   1 root root    7 Jul  3 00:00 bin -> usr/bin
drwxr-xr-x   2 root root 4.0K Mar  2 13:55 boot
drwxr-xr-x   2 root root 4.0K Jul 12 08:55 data
drwxr-xr-x   5 root root  360 Jul 12 09:28 dev
drwxr-xr-x   1 root root 4.0K Jul 12 09:28 etc
drwxr-xr-x   2 root root 4.0K Mar  2 13:55 home
lrwxrwxrwx   1 root root    7 Jul  3 00:00 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Jul  3 00:00 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Jul  3 00:00 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Jul  3 00:00 libx32 -> usr/libx32
drwxr-xr-x   2 root root 4.0K Jul  3 00:00 media
drwxr-xr-x   2 root root 4.0K Jul  3 00:00 mnt
drwxr-xr-x   2 root root 4.0K Jul  3 00:00 opt
dr-xr-xr-x 398 root root    0 Jul 12 09:28 proc
drwx------   2 root root 4.0K Jul  3 00:00 root
drwxr-xr-x   3 root root 4.0K Jul  3 00:00 run
lrwxrwxrwx   1 root root    8 Jul  3 00:00 sbin -> usr/sbin
drwxr-xr-x   2 root root 4.0K Jul  3 00:00 srv
dr-xr-xr-x  13 root root    0 Jul 12 09:28 sys
drwxrwxrwt   2 root root 4.0K Jul  3 00:00 tmp
drwxr-xr-x  14 root root 4.0K Jul  3 00:00 usr
drwxr-xr-x  11 root root 4.0K Jul  3 00:00 var
```

- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.

```
<pre>[root@d07a1c5addbb data]# echo &quot;test&quot;&gt;test.md
[root@d07a1c5addbb data]# ls -lh
total 4.0K
-rw-r--r-- 1 root root 5 Jul 12 09:33 test.md</pre>
```

- Добавьте ещё один файл в папку ```/data``` на хостовой машине.

```
ydoolb@ydoolb-Vostro-5490:/$ sudo echo "test2">/data/test2.md
ydoolb@ydoolb-Vostro-5490:/$ cd data 
ydoolb@ydoolb-Vostro-5490:/data$ ls
test2.md  test.md
```

- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

```
root@020a35b2adf7:/# cd data
root@020a35b2adf7:/data# ls -lh
total 8.0K
-rw-r--r-- 1 root root 5 Jul 12 10:16 test.md
-rw-rw-r-- 1 1000 1000 6 Jul 12 10:20 test2.md
