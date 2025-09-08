# Submit a job via JustIN
DUNE_VERSION="v10_10_02d00"
USERF=$USER
FNALURL='https://fndcadoor.fnal.gov:2880/dune/scratch/users'
justin get-token
INPUT_TAR_DIR_LOCAL=`justin-cvmfs-upload ${TARBALL}`
echo INPUT_TAR_DIR: $INPUT_TAR_DIR_LOCAL
until ls -l $INPUT_TAR_DIR_LOCAL; do
	echo "Waiting for input tarball to become available via cvmfs..."
	sleep 1
done

#justin simple-workflow \
justin-test-jobscript \
--mql \
"files from ${DSET} limit 1000 ordered " \
--jobscript ../submit_local_code.jobscript \
--env FCL_FILE=${FCL_FILE} \
--env NUM_EVENTS=1 \
--env DUNE_VERSION="${DUNE_VERSION}" \
--env INPUT_TAR_DIR_LOCAL="$INPUT_TAR_DIR_LOCAL"
# --output-pattern '*_triggerAna_*.root:$FNALURL/$USERF'
# --rss-mb 4000 \
