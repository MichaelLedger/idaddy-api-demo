# 定义公共请求参数
APP_ID=my-app-id-test00001
APP_SECRET=my-app-secret-test00001
TIMESTAMP=$(date +%s)
SIGN_TYPE=sha1
SIGNATURE=$(echo -n "${APP_ID}${APP_SECRET}${TIMESTAMP}" | openssl dgst -$SIGN_TYPE -hex | cut -d' ' -f2)
NONCE=$(openssl rand -base64 12)

# 或者用下面更推荐的命令格式
curl --request POST \
--data-urlencode "app_id=${APP_ID}" \
--data-urlencode "device_id=x1000" \
--data-urlencode "timestamp=${TIMESTAMP}" \
--data-urlencode "nonce=${NONCE}" \
--data-urlencode "sign_type=${SIGN_TYPE}" \
--data-urlencode "signature=${SIGNATURE}" \
--data-urlencode "offset=0" \
--data-urlencode "limit=5" \
--data-urlencode 'cat_ids=[]' \
http://open.idaddy.cn/api/v3/cat/list
