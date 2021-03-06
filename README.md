# `trombik.netbox`

[![kitchen](https://github.com/trombik/ansible-role-netbox/actions/workflows/kitchen.yml/badge.svg)](https://github.com/trombik/ansible-role-netbox/actions/workflows/kitchen.yml)

`ansible` role to manage `netbox`.

# Requirements

See [requirements.yml](requirements.yml).

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `netbox_user` | User name of `netbox` | `{{ __netbox_user }}` |
| `netbox_group` | Group name of `netbox` | `{{ __netbox_group }}` |
| `netbox_service` | Service name of `netbox` | `{{ __netbox_service }}` |
| `netbox_service_rq` | Service name of `netbox_rq` | `{{ __netbox_service_rq }}` |
| `netbox_extra_packages` | List of extra packages to install | `[]` |
| `netbox_required_packages` | List of required packages to install | `{{ __netbox_required_packages }}` |
| `netbox_git_repo` | Path to the `netbox` git repository | `https://github.com/netbox-community/netbox.git` |
| `netbox_git_version` | git ref to checkout | `master` |
| `netbox_git_update` | Boolean to update the checked out repository | `false` |
| `netbox_local_requirements` | Content of `local_requirements.txt` | `""` |
| `netbox_home_dir` | Path to home directory of `netbox` user | `{{ __netbox_home_dir }}` |
| `netbox_root_dir` | Path to root directory of the repository | `{{ netbox_home_dir }}/netbox` |
| `netbox_venv_dir` | path to `venv` directory | `{{ netbox_root_dir }}/venv` |
| `netbox_venv_python` | Path to `python` binary in the `venv` | `{{ netbox_venv_dir }}/bin/python3` |
| `netbox_app_dir` | Path to application directory | `{{ netbox_root_dir }}/netbox` |
| `netbox_conf_dir` | Path to directory of the `configuration.py` | `{{ netbox_app_dir }}/netbox` |
| `netbox_conf_file` | Path to the `configuration.py` | `{{ netbox_conf_dir }}/configuration.py` |
| `netbox_gunicorn_conf_file` | Path to `gunicorn.py` | `{{ netbox_conf_dir }}/gunicorn.py` |
| `netbox_gunicorn_config` | Content of `gunicorn.py` | `""` |
| `netbox_static_dir` | Path to `static` directory | `{{ netbox_app_dir }}/static` |
| `netbox_log_dir` | Path to log directory | `{{ __netbox_log_dir }}` |
| `netbox_log_file` | Path to log file | `{{ netbox_log_dir }}/netbox.log` |
| `netbox_bind_scheme` | Scheme to bind | `http` |
| `netbox_bind_address` | Address to bind | `127.0.0.1` |
| `netbox_bind_port` | | `8001` |
| `netbox_redis_tasks_host` | Address of `redis` tasks | `127.0.0.1` |
| `netbox_redis_tasks_port` | Port number of `redis` tasks | `6379` |
| `netbox_redis_tasks_password` | Password of `redis` tasks | `""` |
| `netbox_redis_tasks_tls` | Boolean to use TLS for `redis` tasks | `false` |
| `netbox_redis_tasks_database` | Number of tasks database | `0` |
| `netbox_redis_caching_host` | Address of `redis` caching | `127.0.0.1` |
| `netbox_redis_caching_port` | Port of `redis` caching | `6379` |
| `netbox_redis_caching_password` | Password of `redis` caching | `""` |
| `netbox_redis_caching_tls` | Boolean to use TLS for `redis` caching | `false` |
| `netbox_redis_caching_database` | Number of caching database | `1` |
| `netbox_redis_wait_for_delay` | Second to delay in `wait_for` `redis` | `0` |
| `netbox_redis_wait_for_sleep` | Second to sleep in `wait_for` `redis` | `1` |
| `netbox_db_host` | Host of database | `127.0.0.1` |
| `netbox_db_port` | Port number of database | `5432` |
| `netbox_db_user` | Database user name | `netbox` |
| `netbox_db_password` | Password of database user | `""` |
| `netbox_db_name` | Name of database | `netbox` |
| `netbox_db_wait_for_delay` | Second to delay in `wait_for` database | `0` |
| `netbox_db_wait_for_sleep` | Second to sleep in `wait_for` database | `1` |
| `netbox_wait_for_delay` | Second to delay in `wait_for` `netbox` | `0` |
| `netbox_wait_for_sleep` | Second to delay in `wait_for` `netbox` | `1` |
| `netbox_superuser_name` | Name of super user in `netbox` | `""` |
| `netbox_superuser_password` | Password of super user in `netbox` | `""` |
| `netbox_superuser_email` | Email address of super user in `netbox` | `""` |
| `netbox_flags` | Flags to pass `netbox` service | `""` |
| `netbox_rq_flags` | Flags to pass `netbox_rq` service | `""` |
| `netbox_using_supervisor` | Boolean to use `supervisor` | `false` |
| `netbox_supervisor_conf_file` | Path to `supervisor` configuration file | `""` |
| `netbox_supervisor_config` | Content of `supervisor` configuration file | `""` |

## Debian

| Variable | Default |
|----------|---------|
| `__netbox_user` | `netbox` |
| `__netbox_group` | `netbox` |
| `__netbox_service` | `netbox` |
| `__netbox_service_rq` | `netbox-rq` |
| `__netbox_home_dir` | `/opt/netbox` |
| `__netbox_log_dir` | `/var/log/netbox` |
| `__netbox_required_packages` | `["git", "python3", "python3-pip", "python3-venv", "python3-dev", "build-essential", "libxml2-dev", "libxslt1-dev", "libffi-dev", "libpq-dev", "libssl-dev", "zlib1g-dev"]` |

## Devuan

| Variable | Default |
|----------|---------|
| `__netbox_user` | `netbox` |
| `__netbox_group` | `netbox` |
| `__netbox_service` | `netbox` |
| `__netbox_service_rq` | `netbox-rq` |
| `__netbox_home_dir` | `/opt/netbox` |
| `__netbox_log_dir` | `/var/log/netbox` |
| `__netbox_required_packages` | `["git", "python3", "python3-pip", "python3-venv", "python3-dev", "build-essential", "libxml2-dev", "libxslt1-dev", "libffi-dev", "libpq-dev", "libssl-dev", "zlib1g-dev", "rustc"]` |
| `__netbox_supervisor_conf_dir` | `/etc/supervisor` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__netbox_user` | `netbox` |
| `__netbox_group` | `netbox` |
| `__netbox_service` | `netbox` |
| `__netbox_service_rq` | `netbox_rq` |
| `__netbox_home_dir` | `/usr/local/netbox` |
| `__netbox_log_dir` | `/var/log/netbox` |
| `__netbox_required_packages` | `["databases/py-psycopg2", "devel/git", "devel/libffi", "devel/py-pip", "graphics/py-pillow", "lang/rust", "textproc/libxml2", "textproc/libxslt"]` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__netbox_user` | `_netbox` |
| `__netbox_group` | `_netbox` |
| `__netbox_service` | `netbox` |
| `__netbox_service_rq` | `netbox_rq` |
| `__netbox_home_dir` | `/var/www/htdocs/netbox` |
| `__netbox_log_dir` | `/var/log/netbox` |
| `__netbox_required_packages` | `["py3-psycopg2", "git", "libffi", "py3-pip", "py3-Pillow", "rust", "libxml", "libxslt"]` |

## RedHat

| Variable | Default |
|----------|---------|
| `__netbox_user` | `netbox` |
| `__netbox_group` | `netbox` |
| `__netbox_service` | `netbox` |
| `__netbox_service_rq` | `netbox-rq` |
| `__netbox_home_dir` | `/opt/netbox` |
| `__netbox_log_dir` | `/var/log/netbox` |
| `__netbox_required_packages` | `["git", "python3-pip", "python3-devel", "libxml2-devel", "libxslt-devel", "libffi-devel", "libpq-devel", "openssl-devel"]` |

# Dependencies

None

# Example Playbook

```yaml
---
- hosts: localhost
  roles:
    - role: trombik.sysctl
    - role: trombik.postgresql
    - role: trombik.redis
    - role: ansible-role-netbox
    - role: trombik.nginx
  vars:
    netbox_superuser_name: root
    netbox_superuser_password: password
    netbox_superuser_email: dave.null@localhost
    netbox_db_password: password
    netbox_redis_tasks_password: "{{ redis_password }}"
    netbox_redis_caching_password: "{{ redis_password }}"
    netbox_using_supervisor: no

    # see available versions at:
    # https://github.com/netbox-community/netbox/releases
    netbox_git_version: v3.1.6

    project_netbox_plugins:
      - netbox-qrcode
    netbox_local_requirements: |
      {% for i in project_netbox_plugins %}
      {{ i }}
      {% endfor %}
    netbox_gunicorn_config: |
      # The IP address (typically localhost) and port that the Netbox WSGI process should listen on
      bind = '127.0.0.1:8001'

      # Number of gunicorn workers to spawn. This should typically be 2n+1, where
      # n is the number of CPU cores present.
      workers = 5

      # Number of threads per worker process
      threads = 3

      # Timeout (in seconds) for a request to complete
      timeout = 120

      # The maximum number of requests a worker can handle before being respawned
      max_requests = 5000
      max_requests_jitter = 500

    netbox_config: |
      ALLOWED_HOSTS = [
        'localhost',
      ]
      DATABASE = {
          'NAME': '{{ netbox_db_name }}',
          'USER': '{{ netbox_db_user }}',
          'PASSWORD': '{{ netbox_db_password }}',
          'HOST': '{{ netbox_db_host }}',
          'PORT': '{{ netbox_db_port }}',
          'CONN_MAX_AGE': 300,
      }
      REDIS = {
          'tasks': {
              'HOST': '{{ netbox_redis_tasks_host }}',
              'PORT': {{ netbox_redis_tasks_port }},
              'PASSWORD': '{{ netbox_redis_tasks_password }}',
              'DATABASE': {{ netbox_redis_tasks_database }},
              'SSL': {% if netbox_redis_tasks_tls %}True{% else %}False{% endif %},
              # 'INSECURE_SKIP_TLS_VERIFY': False,
          },
          'caching': {
              'HOST': '{{ netbox_redis_caching_host }}',
              'PORT': {{ netbox_redis_caching_port }},
              'PASSWORD': '{{ netbox_redis_caching_password }}',
              'DATABASE': {{ netbox_redis_caching_database }},
              'SSL': {% if netbox_redis_caching_tls %}True{% else %}False{% endif %},
              # 'INSECURE_SKIP_TLS_VERIFY': False,
          }
      }
      # python3 /usr/local/netbox/netbox/netbox/generate_secret_key.py
      SECRET_KEY = 'eu806L3V2$^ykz1tKAkZ=^$oGVXS!bcQUrhesk4mknFFxNz!df'
      ADMINS = [
          ('John Doe', 'jdoe@example.com'),
      ]
      BASE_PATH = ''
      CORS_ORIGIN_ALLOW_ALL = True
      CORS_ORIGIN_WHITELIST = [
          # 'https://hostname.example.com',
      ]
      CORS_ORIGIN_REGEX_WHITELIST = [
          # r'^(https?://)?(\w+\.)?example\.com$',
      ]
      DEBUG = False
      EMAIL = {
          'SERVER': 'localhost',
          'PORT': 25,
          'USERNAME': '',
          'PASSWORD': '',
          'USE_SSL': False,
          'USE_TLS': False,
          'TIMEOUT': 10,  # seconds
          'FROM_EMAIL': '',
      }
      EXEMPT_VIEW_PERMISSIONS = [
          # 'dcim.site',
          # 'dcim.region',
          # 'ipam.prefix',
      ]
      INTERNAL_IPS = ('127.0.0.1', '::1')
      LOGGING = {
          'version': 1,
          'disable_existing_loggers': False,
          'handlers': {
              'file': {
                  'level': 'DEBUG',
                  'class': 'logging.FileHandler',
                  'filename': '{{ netbox_log_file }}',
              },
          },
          'loggers': {
              'django': {
                  'handlers': ['file'],
                  'level': 'DEBUG',
              },
          },
      }
      LOGIN_PERSISTENCE = False
      LOGIN_REQUIRED = False
      LOGIN_TIMEOUT = None
      METRICS_ENABLED = False
      PLUGINS = [
      {% for p in project_netbox_plugins %}
        '{{ p | regex_replace("-", "_") }}',
      {% endfor %}
      ]
      REMOTE_AUTH_ENABLED = False
      REMOTE_AUTH_BACKEND = 'netbox.authentication.RemoteUserBackend'
      REMOTE_AUTH_HEADER = 'HTTP_REMOTE_USER'
      REMOTE_AUTH_AUTO_CREATE_USER = True
      REMOTE_AUTH_DEFAULT_GROUPS = []
      REMOTE_AUTH_DEFAULT_PERMISSIONS = {}
      RELEASE_CHECK_URL = None
      RQ_DEFAULT_TIMEOUT = 300
      SESSION_COOKIE_NAME = 'sessionid'
      SESSION_FILE_PATH = None
      TIME_ZONE = 'UTC'
      DATE_FORMAT = 'N j, Y'
      SHORT_DATE_FORMAT = 'Y-m-d'
      TIME_FORMAT = 'g:i a'
      SHORT_TIME_FORMAT = 'H:i:s'
      DATETIME_FORMAT = 'N j, Y g:i a'
      SHORT_DATETIME_FORMAT = 'Y-m-d H:i'

    # _________________________________________postgresql
    postgresql_initial_password: password
    postgresql_debug: yes
    os_sysctl:
      FreeBSD: {}
      OpenBSD:
        kern.seminfo.semmni: 60
        kern.seminfo.semmns: 1024
      Debian: {}
      RedHat: {}
    sysctl: "{{ os_sysctl[ansible_os_family] }}"

    os_postgresql_extra_packages:
      FreeBSD:
        - "databases/postgresql{{ postgresql_major_version }}-contrib"
      OpenBSD:
        - postgresql-contrib
      Debian:
        - postgresql-contrib
      RedHat:
        - "postgresql{{ postgresql_major_version }}-contrib"

    postgresql_extra_packages: "{{ os_postgresql_extra_packages[ansible_os_family] }}"
    postgresql_pg_hba_config: |
      host    all             all             127.0.0.1/32            {{ postgresql_default_auth_method }}
      host    all             all             ::1/128                 {{ postgresql_default_auth_method }}
      local   replication     all                                     trust
      host    replication     all             127.0.0.1/32            trust
      host    replication     all             ::1/128                 trust
    postgresql_config: |
      {% if ansible_os_family == 'Debian' %}
      data_directory = '{{ postgresql_db_dir }}'
      hba_file = '{{ postgresql_conf_dir }}/pg_hba.conf'
      ident_file = '{{ postgresql_conf_dir }}/pg_ident.conf'
      external_pid_file = '/var/run/postgresql/{{ postgresql_major_version }}-main.pid'
      port = 5432
      max_connections = 100
      unix_socket_directories = '/var/run/postgresql'
      ssl = on
      ssl_cert_file = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
      ssl_key_file = '/etc/ssl/private/ssl-cert-snakeoil.key'
      shared_buffers = 128MB
      dynamic_shared_memory_type = posix
      log_line_prefix = '%m [%p] %q%u@%d '
      log_timezone = 'UTC'
      cluster_name = '{{ postgresql_major_version }}/main'
      stats_temp_directory = '/var/run/postgresql/{{ postgresql_major_version }}-main.pg_stat_tmp'
      datestyle = 'iso, mdy'
      timezone = 'UTC'
      lc_messages = 'C'
      lc_monetary = 'C'
      lc_numeric = 'C'
      lc_time = 'C'
      default_text_search_config = 'pg_catalog.english'
      include_dir = 'conf.d'
      password_encryption = {{ postgresql_default_auth_method }}
      {% else %}
      max_connections = 100
      shared_buffers = 128MB
      dynamic_shared_memory_type = posix
      max_wal_size = 1GB
      min_wal_size = 80MB
      log_destination = 'syslog'
      log_timezone = 'UTC'
      update_process_title = off
      datestyle = 'iso, mdy'
      timezone = 'UTC'
      lc_messages = 'C'
      lc_monetary = 'C'
      lc_numeric = 'C'
      lc_time = 'C'
      default_text_search_config = 'pg_catalog.english'
      password_encryption = {{ postgresql_default_auth_method }}
      {% endif %}
    postgresql_users:
      - name: foo
        password: PassWord
      - name: root
        password: AdminPassWord
        role_attr_flags: SUPERUSER
      - name: "{{ netbox_db_user }}"
        password: "{{ netbox_db_password }}"

    postgresql_databases:
      - name: "{{ netbox_db_name }}"
        owner: "{{ netbox_db_user }}"
        state: present
      - name: bar
        owner: foo
        state: present

    project_postgresql_initdb_flags: --encoding=utf-8 --lc-collate=C --locale=en_US.UTF-8
    project_postgresql_initdb_flags_pwfile: "--pwfile={{ postgresql_initial_password_file }}"
    project_postgresql_initdb_flags_auth: "--auth-host={{ postgresql_default_auth_method }} --auth-local={{ postgresql_default_auth_method }}"
    os_postgresql_initdb_flags:
      FreeBSD: "{{ project_postgresql_initdb_flags }} {{ project_postgresql_initdb_flags_pwfile }} {{ project_postgresql_initdb_flags_auth }}"
      OpenBSD: "{{ project_postgresql_initdb_flags }} {{ project_postgresql_initdb_flags_pwfile }} {{ project_postgresql_initdb_flags_auth }}"
      RedHat: "{{ project_postgresql_initdb_flags }} {{ project_postgresql_initdb_flags_pwfile }} {{ project_postgresql_initdb_flags_auth }}"
      # XXX you cannot use --auth-host or --auth-local here because
      # pg_createcluster, which is executed during the installation, overrides
      # them, forcing md5
      Debian: "{{ project_postgresql_initdb_flags }} {{ project_postgresql_initdb_flags_pwfile }}"

    postgresql_initdb_flags: "{{ os_postgresql_initdb_flags[ansible_os_family] }}"
    os_postgresql_flags:
      FreeBSD: |
        postgresql_flags="-w -s -m fast"
      OpenBSD: ""
      Debian: ""
      RedHat: ""
    postgresql_flags: "{{ os_postgresql_flags[ansible_os_family] }}"

    # _________________________________________nginx
    www_root_dir: "{% if ansible_os_family == 'FreeBSD' %}/usr/local/www/nginx{% elif ansible_os_family == 'OpenBSD' %}/var/www/htdocs{% elif ansible_os_family == 'Debian' %}/var/www/html{% elif ansible_os_family == 'RedHat' %}/usr/share/nginx/html{% endif %}"
    nginx_flags: -q
    nginx_config: |
      {% if ansible_os_family == 'Debian' or ansible_os_family == 'RedHat' %}
      user {{ nginx_user }};
      pid /run/nginx.pid;
      {% endif %}
      worker_processes 1;
      error_log {{ nginx_error_log_file }};
      events {
        worker_connections 1024;
      }
      http {
        include {{ nginx_conf_dir }}/mime.types;
        access_log {{ nginx_access_log_file }};
        default_type application/octet-stream;
        sendfile on;
        keepalive_timeout 65;
        server {
          listen 80;
          server_name localhost;
          client_max_body_size 25m;

          location /static/ {
      {% if ansible_os_family == 'OpenBSD' %}
            alias /htdocs/netbox/netbox/netbox/static/;
      {% else %}
            alias {{ netbox_static_dir }}/;
      {% endif %}
          }
          location / {
            proxy_pass {{ netbox_bind_scheme }}://{{ netbox_bind_address }}:{{ netbox_bind_port }};
            proxy_set_header X-Forwarded-Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-Proto $scheme;
          }
        }
      }
    nginx_config_fragments: []
    nginx_extra_packages_by_os:
      FreeBSD:
        - security/py-certbot-nginx
      OpenBSD: []
      Debian:
        - nginx-extras
      RedHat: []
    nginx_extra_packages: "{{ nginx_extra_packages_by_os[ansible_os_family] }}"
    redhat_repo:
      epel:
        mirrorlist: "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-{{ ansible_distribution_major_version }}&arch={{ ansible_architecture }}"
        gpgcheck: yes
        enabled: yes
    # _________________________________________redis
    redis_password: password
    redis_config: |
      databases 17
      save 900 1
      requirepass "{{ redis_password }}"
      bind 127.0.0.1
      protected-mode yes
      port {{ redis_port }}
      timeout 0
      tcp-keepalive 300
      daemonize yes
      pidfile /var/run/redis/{{ redis_service }}.pid
      loglevel notice
      logfile {{ redis_log_file }}
      always-show-logo no
      dbfilename dump.rdb
      dir {{ redis_db_dir }}/
```

# License

```
Copyright (c) 2022 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>

This README was created by [qansible](https://github.com/trombik/qansible)
