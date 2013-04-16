build-essential:
  pkg:
    - installed
libexpat1-dev:
  pkg:
    - installed

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
  require:
    - pkg: mysql-server


database-setup:
  mysql_user.present:
    - name: testuser
    - password: devman
    - require:
      - pkg: python-mysqldb
      - service: mysql

  mysql_database.present:
    - name: exampledb

  mysql_grants.present:
    - grant: all privileges
    - database: exampledb.*
    - user: testuser
    - require:
      - mysql_database.present : database-setup
      


npminstall:
  cmd.run:
    - name: npm install
    - cwd: /vagrant/
  require:
    - pkg: npm
    - pkg: build-essential
    - pkg: libexpat1-dev


#/vagrant/
#  npm.bootstrap:
#    - require:
#      - pkg: npm
#      - pkg: build-essential
#      - pkg: libexpat1-dev
