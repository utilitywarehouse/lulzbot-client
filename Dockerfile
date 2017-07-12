FROM ubuntu:16.04

RUN apt-get update && \
 apt-get install -y wget sudo && \
 wget -qO - http://download.alephobjects.com/ao/aodeb/aokey.pub | apt-key add - && \
 sed -i '$a deb http://download.alephobjects.com/ao/aodeb wheezy main' /etc/apt/sources.list && \
 apt-get update && \
 apt-get install -y cura && \
 export uid=1000 gid=1000 && \
 mkdir -p /home/ptl && \
 echo "ptl:x:${uid}:${gid}:Post Tenebras Lab,,,:/home/ptl:/bin/bash" >> /etc/passwd && \
 echo "ptl:x:${uid}:" >> /etc/group && \
 echo "ptl ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ptl && \
 chmod 0440 /etc/sudoers.d/ptl && \
 mkdir /home/ptl/Documents && \
 mkdir /home/ptl/.cura && \
 chown ${uid}:${gid} -R /home/ptl &&\
 # Create uucp2 group with id 14 (same as on Arch Linux)
 groupadd -g 14 uucp2 && \
 usermod -a -G uucp2 ptl && \
 usermod -a -G tty ptl && \
 usermod -a -G dialout ptl

USER ptl
ENV HOME /home/ptl
CMD /usr/bin/cura
