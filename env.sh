# use ups to find programs - this only works on SL7

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

# do some data access setup
export IFDH_CP_MAXRETRIES=0\0\0\0\0  # no retries
export DATA_DISPATCHER_URL=https://metacat.fnal.gov:9443/dune/dd/data
export DATA_DISPATCHER_AUTH_URL=https://metacat.fnal.gov:8143/auth/dune
export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/app
export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune

# access some disks
export DUNEDATA=/exp/dune/data/users/$USER
export DUNEAPP=/exp/dune/app/users/$USER
export PERSISTENT=/pnfs/dune/persistent/users/$USER
export SCRATCH=/pnfs/dune/scratch/users/$USER

# set up the full DUNE SW suite

export DUNELAR_VERSION=v10_10_02d00 # you want to update this
export DUNELAR_QUALIFIER=e26:prof # you want to update this

setup -B dunesw ${DUNELAR_VERSION} -q ${DUNELAR_QUALIFIER}

setup metacat
setup rucio
export RUCIO_ACCOUNT=justinreadonly
setup justin
alias buildsw='ninja -C ${MRB_BUILDDIR} -k 0 install | grep -v "Up-to-date" '

