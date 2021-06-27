#!/bin/bash

DB="mydb"
TEAM="team01"

# 事前に過去データの合計を取得
SUM=`curl "http://localhost:8086/query?db=mydb" --data-urlencode "q=SELECT sum("sla") FROM "${TEAM}";" | tr -d "]}" | awk -F"," '{print $NF}'`

# 過去データのSUMが0以上ではない場合はSUM=0へ
# (初期データ無しの場合など)
if [ ${SUM} -ge 0 ]; then
  :
else
 SUM=0
fi

# データを投入(SLA=ランダム値)
SLA=`shuf -i 0-5 -n 1`
SUM=$((${SUM}+${SLA}))

curl -i -XPOST "http://localhost:8086/write?db=${DB}" --data-binary "${TEAM} sla=${SLA},sum=${SUM}"
