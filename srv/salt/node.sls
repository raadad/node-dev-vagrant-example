build-essential:
  pkg:
    - installed
libexpat1-dev:
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
  require:
    - pkg: python-mysqldb
    - service: mysql



npminstall:
  cmd.run:
    - name: npm install
    - cwd: /vagrant/
  require:
    - pkg: npm


#/vagrant/node-example-estore:
#  npm.bootstrap:
#    - require:
#      - pkg: npm
#      - pkg: build-essential
#      - pkg: libexpat1-dev
