!/bin/bash
apt update
apt install openjdk-17-jdk-headless -y
useradd -m -d /opt/tomcat -U -s /bin/false tomcat
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.18/bin/apache-tomcat-10.1.18.tar.gz
tar xzvf apache-tomcat-10*tar.gz -C /opt/tomcat --strip-components=1
chown -R tomcat:tomcat /opt/tomcat/
chmod -R u+x /opt/tomcat/bin

content_to_add=$'\n<role rolename="manager-gui" />\n<user username="manager" password="manager12345" roles="manager-gui" />\n\n<role rolename="admin-gui" />\n<user username="admin" password="admin12345" roles="manager-gui,admin-gui" />\n'
sed -i -e "/<\/tomcat-users>/i $content_to_add" /opt/tomcat/conf/tomcat-users.xml


file_path="/opt/tomcat/webapps/manager/META-INF/context.xml"
search_pattern="<Valve className=\"org.apache.catalina.valves.RemoteAddrValve\" allow=\"127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1\" />"
replace_text="<!--  <Valve className=\"org.apache.catalina.valves.RemoteAddrValve\" allow=\"127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1\>
sed -i "s|$search_pattern|$replace_text|" "$file_path"

file_path_1="nano /opt/tomcat/webapps/host-manager/META-INF/context.xml"
replace_text_1="<!--  <Valve className=\"org.apache.catalina.valves.RemoteAddrValve\" allow=\"127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:>
search_pattern_1="<Valve className=\"org.apache.catalina.valves.RemoteAddrValve\" allow=\"127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1\" />"
sed -i "s|$search_pattern_1|$replace_text_1|" "$file_path_1"

#Paso 3
service_file="/etc/systemd/system/tomcat.service"

service_content="[Unit]
Description=Tomcat
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment=\"JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64\"
Environment=\"JAVA_OPTS=-Djava.security.egd=file:///dev/urandom\"
Environment=\"CATALINA_BASE=/opt/tomcat\"
Environment=\"CATALINA_HOME=/opt/tomcat\"
Environment=\"CATALINA_PID=/opt/tomcat/temp/tomcat.pid\"
Environment=\"CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC\"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
"
echo "$service_content" | sudo tee "$service_file" > /dev/null
systemctl daemon-reload
systemctl start tomcat
systemctl status tomcat
systemctl enable tomcat
ufw allow 8080
