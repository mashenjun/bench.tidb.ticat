set -euo pipefail
here=`cd $(dirname ${BASH_SOURCE[0]}) && pwd`
. "${here}/../helper/helper.bash"

loadgen_bin=`build_loadgen "${here}/../repos/loadgen"`
echo "[:)] loadgen bin: ${mole_bin}"
