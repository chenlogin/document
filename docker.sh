# --rm 关闭时自动删除容器
docker run \
--rm -t \ 
-v /root:/root \
-v /data:/data \
electronuserland/builder:wine \
bash -c 'cd /data/jenkins/workspace/17zuoyeClient; yarn install; npm run package:win'


# 启动nginx容器
# 挂载配置文件,宿主机上面的nginx.conf配置文件映射到启动的nginx容器里面
# 组件容器，默认容器对这个目录有可读写权限。可以通过ro将权限改为只读
docker run \
  --name nginx-elemmentui \
  -d \
  -p 7001:80 \
  -v /data/workspace/www/element.17zuoye.net:/usr/share/nginx/html:ro \
  -v /opt/nginx/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v /opt/nginx/conf.d:/etc/nginx/conf.d \
  -v /opt/nginx/logs:/var/log/nginx \
  nginx

# nginx展示文件目录
# vi /etc/nginx/conf.d/default.conf
# location / { 
#   charset utf-8;             //处理中文显示乱码
#   root /usr/share/nginx/html;//指定实际目录绝对路径；   
#   autoindex on;              //开启目录浏览功能；   
#   autoindex_exact_size off;  //关闭详细文件大小统计，让文件大小显示MB，GB单位，默认为b；   
#   autoindex_localtime on;    //开启以服务器本地时区显示文件修改日期！   
# }
# 只在download目录添加浏览功能
# location /download {  
#  ... 
# } 
docker run \
  --name nginx-pcclient \
  -d \
  -p 8081:80 \
  -v /data/workspace/pcClient:/usr/share/nginx/html:ro \
  -v /opt/nginx-pcclient/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v /opt/nginx-pcclient/conf.d:/etc/nginx/conf.d \
  -v /opt/nginx-pcclient/logs:/var/log/nginx \
  nginx



# elementci容器
# 在镜像文档里，Jenkins访问的端口号是8080，另外还需要暴露一个tcp的端口号50000
# 宿主机docker映射到容器内
# jenkins_home 指定Jenkins的宿主机存储路径,防止jenkins中重要文件因为容器损毁或删除导致文件丢失，因此创建文件对外挂载
docker run \
-d \
--name jenkins-elementci \
-p 8088:8080 \
-p 50000:50000 \
--privileged \
-u root \
-v /usr/bin/docker:/usr/bin/docker \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /data/jenkins:/var/jenkins_home \
-v /usr/jenkinsci/:/usr/jenkinsci/ \
jenkins/jenkins




//本机目录复制到远程
scp -prq /Users/chen/Documents/workspace/alkaid/docs/.vuepress/dist/. root@10.198.xx.xx:/data/workspace/www/element.17zuoye.net












