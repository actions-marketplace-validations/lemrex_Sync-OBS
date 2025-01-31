#!/bin/sh -l

if [ -z "$ACCESS_KEY" ]; then
  echo "AK is not set. Quitting."
  exit 1
fi
if [ -z "$SECRET_KEY" ]; then
  echo "SK is not set. Quitting."
  exit 1
fi
if [ -z "$REGION" ]; then
  echo "region is not set. Quitting."
  exit 1
fi
if [ -z "$BUCKET_NAME" ]; then
  echo "bucket name is not set. Quitting."
  exit 1
fi
if [ -z "$LOCAL_PATH" ]; then
  echo "local file path is not set. Quitting."
  exit 1
fi

# Downloading and Installing obsutil
curl -O https://obs-community.obs.cn-north-1.myhuaweicloud.com/obsutil/current/obsutil_linux_amd64.tar.gz
tar -xzvf obsutil_linux_amd64.tar.gz
decompressingDirectory=`ls -l . |awk '/^d/ {print $NF}'|grep obsutil_linux_amd64`
echo $decompressingDirectory
chmod 755 -R $decompressingDirectory/

# Initializing obsutil
./$decompressingDirectory/obsutil config -i=${ACCESS_KEY} -k=${SECRET_KEY} -e=obs.${REGION}.myhuaweicloud.com 

# Usync file or diretory
./$decompressingDirectory/obsutil sync ${LOCAL_PATH} obs://${BUCKET_NAME}/