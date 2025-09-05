# Submit a job via JustIN
USERF=$USER
FNALURL='https://fndcadoor.fnal.gov:2880/dune/scratch/users'
justin get-token
INPUT_TAR_DIR_LOCAL=`justin-cvmfs-upload grid-input.tar`
echo INPUT_TAR_DIR: $INPUT_TAR_DIR_LOCAL
until ls -l $INPUT_TAR_DIR_LOCAL; do
	echo "Waiting for input tarball to become available via cvmfs..."
	sleep 1
done

#justin simple-workflow \
justin-test-jobscript \
--mql \
"files from fardet-hd:fardet-hd__trg_mc_2025a__detector-simulated__v10_06_00d01__detsim_dune10kt_1x2x2_notpcsigproc__prodmarley_nue_flat_cc_dune10kt_1x2x2__out1__validation ordered " \
--jobscript submit_local_code.jobscript \
--env FCL_FILE="triggerana_tree_1x2x2_tpg_absrs_st.fcl" \
--env NUM_EVENTS=1 \
--env DUNE_VERSION="v10_10_02d00" \
--env INPUT_TAR_DIR_LOCAL="$INPUT_TAR_DIR_LOCAL"
# --output-pattern '*_triggerAna_*.root:$FNALURL/$USERF'

# --rss-mb 4000 \
