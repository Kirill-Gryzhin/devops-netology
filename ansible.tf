resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
    webservers = yandex_compute_instance.platform   
    dbservers = yandex_compute_instance.platform1
    storageserver = yandex_compute_instance.platform2
    } 
    )
  filename = "${abspath(path.module)}/hosts.cfg"
}