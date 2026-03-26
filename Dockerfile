FROM golang:1.24
MAINTAINER "Jacky123"

WORKDIR /usr/wic-go
RUN go env -w GO111MODULE=on

COPY . /usr/wic-go
# 关键：修改 Redis 配置
# sed -i 's/redislink = 127.0.0.1:6379/redislink = redis:6379/' /usr/wic-go/conf/app.conf
RUN :\
  && ln -sf /usr/wic-go/lib/libv08.so /usr/lib/libv08.so \
  && ln -sf /usr/wic-go/lib/libz.so /usr/lib/libz.so \
  && ldconfig \
  && go mod download \
  && go build -v -o main main.go

#RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#RUN ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime

EXPOSE 8058
# 启动时执行go
ENTRYPOINT ["./main"]
