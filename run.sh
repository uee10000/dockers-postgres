#!/bin/bash

APP_IMG_NAME=uee10000/eg_postgresql

# 起動中のpostgresqlコンテナを取得
CURRENT_CONTAINERS=`docker ps | grep $APP_IMG_NAME | awk '{print $1}'`
echo "[Running containers]"
echo "$CURRENT_CONTAINERS"

# 古いコンテナをシャットダウン
echo "[Shutting down old containers]"
if [ -n "$CURRENT_CONTAINERS" ]; then
    docker kill $CURRENT_CONTAINERS
fi

echo "[Done]"

# 新しいコンテナを起動
if [ -n "$CURRENT_CONTAINERS" ]; then
    docker run -p 5432 -name pg --volumes-from $CURRENT_CONTAINERS -d $APP_IMG_NAME 
else 
    docker run -p 5432 -name pg -d $APP_IMG_NAME 
fi