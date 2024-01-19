# homework_lesson3
Провести настройку аутентификации доступа к yandex cloud-id, введя в консоли:
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

Ввести в консоли команды:
Инициализация terraform
terraform init
Проверка сценария terraform
terraform plan

Будут созданы ВМ: 
- web1, которая будет выполнять роль балансировщика;
- bs1 и bs2 в качестве бекендов, на которых установлены php-fpm и nginx.
В качестве приложения установлен wordpress
- db1 на которой развернута БД mysql

Запустить сценарий создания ВМ
terraform apply
В консоле будут выведены
внешние ip - external_ip_address_...
и внутренние ip - internal_ip_address_vm_...

В файле ya.yaml ввести external_ip_address для ВМ web1, bs1, bs2 и db1
Проверить доступность ВМ с помощью модуля ping
ansible all -m ping

В файле all групповых переменных в group_vars/ ввести internal_ip_address_vm_...
для ВМ bs1, bs2 и db1, а также название базы, пользователя и пароль, а также домен
для настройки wordpress.

Проверить корректность синтаксиса плэйбука main.yaml
ansible-playbook --syntax-check main.yaml

Роль db_ins выполняет установку и рзвертывание mysql
Роль bs_ins выполняет установку и рзвертывание php-fpm, nginx и wordpress
Роль web_ins выполняет настройку балансировщика с nginx

Запускаем playbook на выполнение
ansible-playbook main.yaml
