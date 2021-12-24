set -euo pipefail
. "`cd $(dirname ${BASH_SOURCE[0]}) && pwd`/../helper/helper.bash"

env=`cat "${1}/env"`

payload_name=`must_env_val "${env}" 'bench.loadgen.payload'`

echo "prepare data for payload ${payload_name}"
