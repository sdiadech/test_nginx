#sudo ln -sf /home/box/web/etc/nginx.conf /etc/nginx/sites-enabled/default
#sudo /etc/init.d/nginx restart

mkdir -p /home/box/web/etc/
mkdir -p /home/box/web/uploads/
mkdir -p /home/box/web/public/css/
mkdir -p /home/box/web/public/img/
mkdir -p /home/box/web/public/js/

# Configure NGINX
sudo rm -rf /etc/nginx/nginx.conf
sudo rm -rf /etc/nginx/sites-enabled/default
cp nginx.conf /home/box/web/etc
sudo ln -s /home/box/web/etc/nginx.conf /etc/nginx/nginx.conf

# Run NGINX
sudo /etc/init.d/nginx restart

# Configure Gunicorn and echo WSGI server
#cp hello.py /home/box/web/
cp ./conf/hello.py /home/box/web/etc/
cp ./conf/ask.conf /home/box/web/etc/

#sudo ln -sf /home/box/web/etc/hello.py /etc/gunicorn.d/hello.py
sudo ln -sf /home/box/web/etc/ask.conf /etc/gunicorn.d/ask

sudo /etc/init.d/gunicorn restart
#sudo gunicorn -c /home/box/web/etc/hello.py hello:application
#sudo gunicorn -c /home/box/web/etc/ask.conf
#sudo gunicorn -b 0.0.0.0:8080 hello:application

sudo /etc/init.d/mysql start
mysql -uroot -e "CREATE DATABASE ask;"
cd ask
./manage.py makemigrations
./manage.py migrate
#./manage.py runserver 0.0.0.0:8000