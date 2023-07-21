# Задача 1

Дайте письменые ответы на вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm-кластере: replication и global?
- Какой алгоритм выбора лидера используется в Docker Swarm-кластере?
- Что такое Overlay Network?

# Ответ 1

- в режиме global планировщик размещает по одной задаче в каждом узле swarm, в режиме replication можно выбрать количество одинаковых запускаемых задач.
- Используется алгоритм Raft — это протокол для реализации распределенного консенсуса. У нод есть 3 состояния leader, vanditate и follower. Когда follower не получают отклика от лидера, то одна из нод может перейти в режим candidate на основе timeout, оставшиеся ноды получив сигнал от candidate проголосуют за нее и она перейдет в режим leader.
- Overlay Network - это логическая сеть созданная по верх другой сети. Узлы оверлейной сети могут быть связаны либо физическим соединением, либо логическим, для которого в основной сети существуют один или несколько соответствующих маршрутов из физических соединений.

# Задача 2

Создайте ваш первый Docker Swarm-кластер в Яндекс Облаке.

Чтобы получить зачёт, предоставьте скриншот из терминала (консоли) с выводом команды:
```
docker node ls
```

# Ответ 2

```
sudo docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
698kh2l5be9hlxq2vetqyhz32 *   node01.netology.yc   Ready     Active         Leader           24.0.4
yc1ck2i0zozy6qsqkpnbxi827     node02.netology.yc   Ready     Active         Reachable        24.0.4
w5ozpsxebcvvf2xs5bnz37zwt     node03.netology.yc   Ready     Active         Reachable        24.0.4
z9cwqbiio8n0ejnp2uu84g51n     node04.netology.yc   Ready     Active                          24.0.4
5gyp586s41kq3l3goxrlzvweh     node05.netology.yc   Ready     Active                          24.0.4
uznxmty7fmbuq1loil9bm5bso     node06.netology.yc   Ready     Active                          24.0.4
```

# Задача 3

Создайте ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Чтобы получить зачёт, предоставьте скриншот из терминала (консоли), с выводом команды:
```
docker service ls
```

# Ответ 3

```
[centos@node01 ~]$ sudo docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
25j5h1n3hzja   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0    
vstfafoxeml9   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
za76sttyje9l   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest                         
b5m1fo1jko1b   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest                      
wd8cb4etfwjj   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4           
fs00j898nlef   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0   
n0zuhe0ysnxo   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0       
5evah2loxvh3   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0         
```

# Задача 4 (*)

Выполните на лидере Docker Swarm-кластера команду, указанную ниже, и дайте письменное описание её функционала — что она делает и зачем нужна:
```
# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
```

# Ответ 4

Данная команда выводит ключ роя на экран. Auto lock защищает рой от злоумышленников, в случае перезагрузки роя он не запустится до тех пор, пока не указать данный ключ. Ключ неолбходимо хранить в зашифрованом хранилище, что бы избежать возможных проблем.
