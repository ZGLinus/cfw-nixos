FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install -y gvfs python3-gi gir1.2-appindicator3-0.1 gir1.2-notify-0.7 fontconfig
COPY ./SourceHanSansCN-Regular.otf /usr/share/fonts
RUN fc-cache -fv
RUN adduser --disabled-password -u 1000 nutstore --home /home/nutstore
ENV TZ=Asia/Shanghai
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1