**gunicorn_config.py**     (a linker which links a python web app and a webserver(eg:ngnix))
<pre>
sudo apt install ngnix
python3 -m venv python3_env
python3 -m venv djano_env
source django_env/bin/activate
	pip install django
	pip install gunicorn
add ur ip in allowed host of settings.py
create folder conf
gunicorn_config.py

<b>add the following in gunicorn_config.py:</b>
command='/home/username/django_env/bin/gunicorn'
pythonpath='/home/username/project'
bind='ipaddrs:8000'
workers = 3

gunicorn -c conf/gunicorn_config.py project.wsgi
bg
</pre>

**nginx**    (for serving images)
<pre>
sudo service nginx start
mkdir static           (parallel to project dir)
in settings change static_url as '/home/user/static'
sudo nano /etc/nginx/sites-available/projectname and add the following

 server { 
      listen 80; 
      server_name 167.99.192.225; 
 location /static/ {
      root /home/ubuntu/static/; 
 }location / { 
      proxy_pass http://167.99.192.225:8000; 
}

cd /etc/nginx/sites-enabled/
ls
sudo ln -s /etc/nginx/sites-available/projectname         (linking)
sudo systemctl restart ngnix

</pre>
