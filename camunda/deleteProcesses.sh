#!/bin/bash
set -e

PROCESSES=$(curl http://localhost:8083/engine-rest/process-definition | jq)

FILTERED_PROCESSES=$(echo "${PROCESSES}" | jq -r '.[].id|select(. | startswith("Testproces"))')
echo "$FILTERED_PROCESSES"

for i in $FILTERED_PROCESSES; do
  echo -e "\nhttp://localhost:8083/engine-rest/process-definition/$i?cascade=true\n"
  curl -X DELETE "http://localhost:8083/engine-rest/process-definition/$i?cascade=true"
done

echo ""
