set -euo pipefail
. "`cd $(dirname ${BASH_SOURCE[0]}) && pwd`/../../helper/helper.bash"

env_file="${1}/env"
env=`cat "${env_file}"`

payload_name=`must_env_val "${env}" 'bench.loadgen.payload'`
table_size=`must_env_val "${env}" 'bench.loadgen.table-size'`

tag="${payload_name}-s${table_size}"
echo "workload.tag.data=${tag}" >> "${env_file}"
