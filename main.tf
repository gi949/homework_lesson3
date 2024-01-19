terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "nginx" {
  name = "nginx"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "web1" {

  name = "web1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "web2" {

  name = "web2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "db" {

  name = "db"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_vpc_network" "network-1" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_nginx" {
  value = yandex_compute_instance.nginx.network_interface.0.ip_address
}

output "external_ip_address_nginx" {
  value = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
}

output "internal_ip_address_web1" {
  value = yandex_compute_instance.web1.network_interface.0.ip_address
}

output "internal_ip_address_web2" {
  value = yandex_compute_instance.web2.network_interface.0.ip_address
}

output "internal_ip_address_db" {
  value = yandex_compute_instance.db.network_interface.0.ip_address
}

output "external_ip_address_web1" {
  value = yandex_compute_instance.web1.network_interface.0.nat_ip_address
}

output "external_ip_address_web2" {
  value = yandex_compute_instance.web2.network_interface.0.nat_ip_address
}

output "external_ip_address_db" {
  value = yandex_compute_instance.db.network_interface.0.nat_ip_address
}
