set -euo pipefail
here=`cd $(dirname ${BASH_SOURCE[0]}) && pwd`
. "`cd $(dirname ${BASH_SOURCE[0]}) && pwd`/../helper/helper.bash"

session="${1}"
env=`cat "${session}/env"`

## read value from env
threads=`must_env_val "${env}" 'bench.loadgen.threads'`
duration=`must_env_val "${env}" 'bench.loadgen.duration'`
payload_name=`must_env_val "${env}" 'bench.loadgen.payload'`

## may not set
table_size=`env_val "${env}" 'bench.loadgen.table-size'`
is_agg=`env_val "${env}" 'bench.loadgen.aggreation'`
is_back=`env_val "${env}" 'bench.loadgen.back'`

host=`must_env_val "${env}" 'mysql.host'`
port=`must_env_val "${env}" 'mysql.port'`
user=`must_env_val "${env}" 'mysql.user'`
db='test'

log="${session}/loadgen.`date +%s`.log"
echo "bench.run.log=${log}" >> "${session}/env"

bin=`build_loadgen "${here}/../repos/loadgen"`

run_loadgen="${bin} payload ${payload_name} \
	--host=${host} \
	--port=${port} \
	--user=${user} \
	--db=${db} \
	--time=${duration} \
	--thread=${threads}"

if [ -z "${is_agg}" ]; then
	run_loadgen+=" --agg=${is_agg}"
fi

if [ -z "${is_back}" ]; then
	run_loadgen+=" --back=${is_back}"
fi

if [ -z "${table_size}" ]; then
	run_loadgen+=" --rows=${table_size}"
fi

echo "${run_loadgen}"
begin=`timestamp`
${run_loadgen}
end=`timestamp`
score="TODO"
detail="TODO"

echo "bench.workload=loadgen" >> "${session}/env"
pervious_begin=`env_val "bench.run.begin"`
if [ -z "${pervious_begin}" ]; then
	echo "bench.run.begin=${begin}" >> "${session}/env"
fi
echo "bench.run.end=${end}" >> "${session}/env"
echo "bench.run.score=${score}" >> "${session}/env"
echo "bench.loadgen.detail=${detail}" >> "${session}/env"
