# Common submission process
# requires the following variables to be set before running:
# OUTDIR: Location of the output file in scratch
# TARBALL: TARBALL to submit. The Tarball should be made inside MRB_SOURCE of a dunesw build
# FCL_FILE: fhicl file to run
# input to `lar -n`

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

mkdir -pv $SCRATCH/$OUTDIR

justin simple-workflow \
--mql \
"files from ${DSET} limit 1000 ordered " \
--jobscript-git JamesJieranShen/dunetrigger-production-justin/submit_local_code.jobscript:refs/heads/main \
--env FCL_FILE=${FCL_FILE} \
--env NUM_EVENTS=${NUM_EVENTS} \
--env DUNE_VERSION="${DUNE_VERSION}" \
--env INPUT_TAR_DIR_LOCAL="$INPUT_TAR_DIR_LOCAL" \
--rss-mb 4000 \
--output-pattern "triggerAna_*.ntuple.root:$FNALURL/$USERF/$OUTDIR" \
