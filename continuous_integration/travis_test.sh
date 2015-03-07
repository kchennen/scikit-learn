#!/usr/bin/bash
set -e

python --version
export SKLEARN_SKIP_NETWORK_TESTS=1
nosetests -s sklearn
python -c "import numpy; print('numpy %s' % numpy.__version__)"
python -c "import scipy; print('scipy %s' % scipy.__version__)"

