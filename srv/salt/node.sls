mysql-server:
  pkg.installed

mysql:
  service.running:
    - name: mysql
    - require:
      - pkg: mysql-server

python-mysqldb:
  pkg.installed

dbconfig:
  mysql_user.present:
    - name: testuser
    - password: devman
    - require:
      - service: mysql
      - pkg: python-mysqldb

  mysql_database.present:
    - name: exampledb
    - require:
      - mysql_user.present: dbconfig

  mysql_grants.present:
    - grant: all privileges
    - database: exampledb.*
    - user: testuser
    - require:
      - mysql_database.present : dbconfig 

nodejs:
  pkg.installed

npm:
  pkg.installed

coffeescript:
  pkg.installed

build-essential:
  pkg.installed
    
libexpat1-dev:
  pkg.installed


npminstall:
  cmd.run:
    - name: npm install
    - cwd: /vagrant/
    - require:
      - pkg: npm 
      - pkg: build-essential
      - pkg: libexpat1-dev
      - pkg: mysql-server

#/vagrant/
#  npm.bootstrap:
#    - require:
#      - pkg: npm
#      - pkg: build-essential
#      - pkg: libexpat1-dev

