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
scp -prq /Users/chen/Documents/workspace/alkaid/docs/.vuepress/dist/. root@10.198.20.35:/data/workspace/www/element.17zuoye.net












