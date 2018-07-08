---
- hosts: localhost


  tasks:

  - name: Set time
    set_fact: temp="{{lookup('pipe','date \"+%Y-%m-%d\"')}}"

  - name: export development database
    mysql_db:
      state: dump
      name: wordpress
      login_unix_socket: /var/run/mysqld/mysqld.sock
      login_host: 192.168.0.2
      config_file: /root/.my.cnf
      target: /wordpress_test/wordpress2.sql

  - name: backup development database
    mysql_db:
      state: dump
      name: wordpress
      login_unix_socket: /var/run/mysqld/mysqld.sock
      login_host: 192.168.0.2
      config_file: /root/.my.cnf
      target: "/wordpress2/wordpress2_{{ temp }}.sql"

  - name: backup production database
    mysql_db:
      state: dump
      name: wordpress
      login_host: 192.168.0.2
      config_file: /root/.my.cnf.db
      login_port: 3320
      login_user: root
      target: "/wordpress_test/wordpress_{{ temp }}.sql"

  - name: backup development web content
    archive:
      path: /data/wordpress2/var/www/html
      dest: "/wordpress2/wordpress2_{{ temp }}.tgz"

  - name: backup production web content
    archive:
      path: /data/wordpress_test/var/www/html
      dest: "/wordpress_test/wordpress_test_{{ temp }}.tgz"
