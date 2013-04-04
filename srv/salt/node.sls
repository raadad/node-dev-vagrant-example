nodejs:
  pkg:
    - installed
npm:
  pkg:
    - installed
coffeescript:
  pkg:
    - installed
  require:
    - pkg: nodejs
mysql-server:
  pkg:
    - installed
mysql:
  service:
    - running
  require:
    - pkg: mysql-server

python-mysqldb:
  pkg:
    - installed

database-setup:
  mysql_user.present:
    - name: testuser
    - password: devman
    - require:
      - pkg: python-mysqldb
      - service: mysql

  mysql_database.present:
    - name: exampledb
    - require:
      - mysql_user : database-setup

  mysql_grants.present:
    - grant: all privileges
    - database: exampledb.*
    - user: testuser
    - require:
      - mysql_database : database-setup
