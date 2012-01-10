ASINSTALLDIR=/opt/glassfish
export ANT_OPTS="-Djava.library.path=${ASINSTALLDIR}/lib"
#export CLASSPATH="${ASINSTALLDIR}/lib/sun-appserv-ant.jar;${ASINSTALLDIR}/lib/admin-cli.jar"
export CLASSPATH="{ASINSTALLDIR}/lib/*.jar"
