#!/bin/sh
# Start/stop the nrpe daemon.
#
# Contributed by Andrew Ryder 06-22-02
# Slight mods by Ethan Galstad 07-09-02

NrpeBin=/usr/sbin/nrpe
NrpeCfg=/etc/nagios/nrpe.cfg

test -f $NrpeBin || exit 0

if ! [ -x "/lib/lsb/init-functions" ]; then
        . /lib/lsb/init-functions
else
        echo "E: /lib/lsb/init-functions not found, lsb-base (>= 3.0-6) needed"
        exit 1
fi

case "$1" in
start)
        log_daemon_msg "Starting nagios remote plugin daemon: nrpe"
        start-stop-daemon --start --quiet --exec $NrpeBin -- -c $NrpeCfg -d
        log_end_msg $?
        ;;
stop)
        log_daemon_msg "Stopping nagios remote plugin daemon: nrpe"
        start-stop-daemon --stop --quiet --exec $NrpeBin
        log_end_msg $?
        ;;
restart)
        log_daemon_msg "Restarting nagios remote plugin daemon: nrpe"
        start-stop-daemon --stop --quiet --exec $NrpeBin
        start-stop-daemon --start --quiet --exec $NrpeBin -- -c $NrpeCfg -d
        log_end_msg $?
        ;;
reload|force-reload)
        log_daemon_msg "Reloading nagios remote plugin daemon: nrpe"
        start-stop-daemon --stop --signal HUP --quiet --exec $NrpeBin
        log_end_msg $?
        ;;
*)      log_failure_msg  "Usage: /etc/init.d/nrpe start|stop|restart|reload|force-reload"
        exit 1
        ;;
esac
exit 0
