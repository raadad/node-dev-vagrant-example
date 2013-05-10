mysql-server:
  pkg.installed

mysql:
  service.running:
    - name: mysql
    - require:
      - pkg: mysql-server

python-mysqldb:
  pkg.installed

coffeescript:
  pkg.installed

dbconfig:
  mysql_user.present:
    - name: vagruser
    - password: devman
    - require:
      - service: mysql
      - pkg: python-mysqldb

  mysql_database.present:
    - name: workoutbot
    - require:
      - mysql_user.present: dbconfig

  mysql_grants.present:
    - grant: all privileges
    - database: workoutbot.*
    - user: vagruser
    - require:
      - mysql_database.present : dbconfig 

nodejs:
  pkg.installed

npm:
  pkg.installed

build-essential:
  pkg.installed

screen:
  pkg.installed
    
npminstall:
  cmd.run:
    - name: npm install
    - cwd: /vagrant/
    - require:
      - pkg: nodejs
      - pkg: npm       
      - pkg: build-essential
      - pkg: mysql-server

initapp:
  cmd.run:
    - name: node entry.js init
    - cwd: /vagrant/
    - require:
      - cmd.run: npminstall
      - mysql_grants : dbconfig

startapp:
  cmd.run:
    - name: screen -dmS newscreen nohup node entry.js start >> logfile.log
    - cwd: /vagrant/
    - require:
      - cmd.run: initapp
      - pkg: screen


