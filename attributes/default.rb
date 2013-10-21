#
# Cookbook Name:: tomcat
# Attributes:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default["tomcat"]["base_version"] = 6
default["tomcat"]["port"] = 8080
default["tomcat"]["proxy_port"] = nil
default["tomcat"]["ssl_port"] = 8443
default["tomcat"]["ssl_proxy_port"] = nil
default["tomcat"]["ajp_port"] = 8009
default["tomcat"]["catalina_options"] = ""
default["tomcat"]["java_options"] = "-Xmx128M -Djava.awt.headless=true"
default["tomcat"]["use_security_manager"] = false
default["tomcat"]["redis"] = false
default["tomcat"]["authbind"] = "no"
default["tomcat"]["deploy_manager_apps"] = true
default["tomcat"]["ssl_cert_file"] = nil
default["tomcat"]["ssl_key_file"] = nil
default["tomcat"]["ssl_chain_files"] = [ ]
default["tomcat"]["keystore_file"] = "keystore.jks"
default["tomcat"]["keystore_type"] = "jks"
# The keystore and truststore passwords will be generated by the
# openssl cookbook's secure_password method in the recipe if they are
# not otherwise set. Do not hardcode passwords in the cookbook.
#default["tomcat"]["keystore_password"] = nil
#default["tomcat"]["truststore_password"] = nil
default["tomcat"]["truststore_file"] = nil
default["tomcat"]["truststore_type"] = "jks"
default["tomcat"]["certificate_dn"] = "cn=localhost"
default["tomcat"]["loglevel"] = "INFO"
default["tomcat"]["tomcat_auth"] = "true"

if node["tomcat"]["base_version"] == "6"
  default["tomcat"]["redis_session_manager"]["filename"] = "tomcat-redis-session-manager-1.0.jar"
  default["tomcat"]["redis_session_manager"]["checksum"] = "2d1eba99f18a9e5c930837fe4826ef8ea29237601ef54a0494c74989f507398b"
  default["tomcat"]["redis_session_manager"]["url"] = "https://github.com/downloads/jcoleman/tomcat-redis-session-manager"
else
  default["tomcat"]["redis_session_manager"]["filename"] = "tomcat-redis-session-manager-1.2.jar"
  default["tomcat"]["redis_session_manager"]["checksum"] = "a0b6d02cd7e5af624f0fd3c4e35d8a3f13b3c581"
  default["tomcat"]["redis_session_manager"]["url"] = "https://s3.amazonaws.com/sptcbu-software-images/builds/misc"
end 

case node['platform']
when "centos","redhat","fedora"
  default["tomcat"]["user"] = "tomcat"
  default["tomcat"]["group"] = "tomcat"
  default["tomcat"]["home"] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["base"] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["config_dir"] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["log_dir"] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["tmp_dir"] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}/temp"
  default["tomcat"]["work_dir"] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}/work"
  default["tomcat"]["context_dir"] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default["tomcat"]["webapp_dir"] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default["tomcat"]["keytool"] = "/usr/lib/jvm/java/bin/keytool"
  default["tomcat"]["endorsed_dir"] = "#{node["tomcat"]["home"]}/lib/endorsed"
when "debian","ubuntu"
  default["tomcat"]["user"] = "tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["group"] = "tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["home"] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["base"] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["config_dir"] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["log_dir"] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["tmp_dir"] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  default["tomcat"]["work_dir"] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["context_dir"] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default["tomcat"]["webapp_dir"] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default["tomcat"]["keytool"] = "/usr/lib/jvm/default-java/bin/keytool"
  default["tomcat"]["endorsed_dir"] = "#{node["tomcat"]["home"]}/lib/endorsed"
else
  default["tomcat"]["user"] = "tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["group"] = "tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["home"] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["base"] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["config_dir"] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["log_dir"] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["tmp_dir"] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  default["tomcat"]["work_dir"] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  default["tomcat"]["context_dir"] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default["tomcat"]["webapp_dir"] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default["tomcat"]["keytool"] = "keytool"
  default["tomcat"]["endorsed_dir"] = "#{node["tomcat"]["home"]}/lib/endorsed"
end
