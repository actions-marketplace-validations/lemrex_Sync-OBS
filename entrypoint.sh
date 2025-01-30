#!/bin/sh -l

if [ -z "$INPUT_ACCESS_KEY" ]; then
  echo "ak is not set. Quitting."
  exit 1
fi
if [ -z "$INPUT_SECRET_KEY" ]; then
  echo "sk is not set. Quitting."
  exit 1
fi
if [ -z "$INPUT_BUCKET_NAME" ]; then
  echo "bucket name is not set. Quitting."
  exit 1
fi
if [ -z "$INPUT_LOCAL_FILE_PATH" ]; then
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
./$decompressingDirectory/obsutil config -i=${INPUT_ACCESS_KEY} -k=${INPUT_SECRET_KEY} -e=obs.${INPUT_REGION}.myhuaweicloud.com 

# Usync file or diretory

./$decompressingDirectory/obsutil sync ${INPUT_LOCAL_FILE_PATH} obs://${INPUT_BUCKET_NAME}/${INPUT_OBS_FILE_PATH}   