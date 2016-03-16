#! /bin/sh
### BEGIN INIT INFO
# Provides:          vpnserver
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: SoftEther VPN Server
# Description:       This file start SoftEther VPN Server as daemon.
### END INIT INFO
 
# Author: Junichi MORI
# 2013/11/25
 
# Do NOT "set -e"
 
# PATH should only include /usr/* if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="SoftEther VPN Server"
NAME=vpnserver
DAEMON=/usr/local/vpnserver/$NAME
DAEMON_START_ARGS="start"
DAEMON_STOP_ARGS="stop"
SCRIPTNAME=/etc/init.d/$NAME
 
# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0
 
# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME
 
# Define LSB log_* functions.
# Depend on lsb-base (>= 3.2-14) to ensure that this file is present
# and status_of_proc is working.
. /lib/lsb/init-functions
 
#
# Function that starts the daemon/service
#
do_start()
{
        # Return
        #   0 if daemon has been started
        #   other if daemon could not be started
    $DAEMON $DAEMON_START_ARGS
    return "$?"
}
 
#
# Function that stops the daemon/service
#
do_stop()
{
        # Return
        #   0 if daemon has been stopped
        #   other if daemon could not be stopped
    $DAEMON $DAEMON_STOP_ARGS
    return "$?"
}
 
case "$1" in
  start)
        log_daemon_msg "Starting $DESC" "$NAME"
        do_start
        case "$?" in
                0) log_end_msg 0 ;;
                *) log_end_msg 1 ;;
        esac
        ;;
  stop)
        log_daemon_msg "Stopping $DESC" "$NAME"
        do_stop
        case "$?" in
                0) log_end_msg 0 ;;
                *) log_end_msg 1 ;;
        esac
        ;;
  restart|force-reload)
        #
        # If the "reload" option is implemented then remove the
        # 'force-reload' alias
        #
        log_daemon_msg "Restarting $DESC" "$NAME"
        do_stop
        case "$?" in
          0)
        sleep 3
                do_start
                case "$?" in
                        0) log_end_msg 0 ;;
                        *) log_end_msg 1 ;; # Failed to start
                esac
                ;;
          *)
                # Failed to stop
                log_end_msg 1
                ;;
        esac
        ;;
  *)
        #echo "Usage: $SCRIPTNAME {start|stop|restart|reload|force-reload}" >&2
        echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload}" >&2
        exit 3
        ;;
esac
 
: