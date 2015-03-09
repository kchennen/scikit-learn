#!/bin/bash
# Credits: http://stackoverflow.com/a/26082445/756986
set -e

export PING_SLEEP=60s
export WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export BUILD_OUTPUT=$WORKDIR/build.out

touch $BUILD_OUTPUT

dump_output() {
   echo "############# Dependency build log(last 3Mb) start #############"
   tail --bytes=3072 $BUILD_OUTPUT
   echo "############# Dependency build log end #############"
}
error_handler() {
  echo ERROR: An error was encountered with the build.
  dump_output
  exit 1
}
# If an error occurs, run our error handler to output a tail of the build
trap 'error_handler' ERR

# Set up a repeating loop to send some output to Travis.

bash -c "while true; do echo \$(date) - building ...; sleep $PING_SLEEP; done" &
PING_LOOP_PID=$!

pip install scipy >> $BUILD_OUTPUT 2>&1

dump_output

# nicely terminate the ping output loop
kill $PING_LOOP_PID
