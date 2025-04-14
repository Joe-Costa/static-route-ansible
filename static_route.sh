#!/bin/bash
# Copyright (c) 2021 Qumulo, Inc. All rights reserved.
#
# NOTICE: All information and intellectual property contained herein is the
# confidential property of Qumulo, Inc. Reproduction or dissemination of the
# information or intellectual property contained herein is strictly forbidden,
# unless separate prior written permission has been obtained from Qumulo, Inc.

##################################################################
##                                                               #
## Static Route Enabler Script                                   #
## This script is triggered by Cron at Reboot, and by systemd    #
## when the Qumulo Core container restarts. Do not delete or     #
## change the location of this file.                             #
##                                                               #
## Note that the crontab will have a 2 minute wait timer before  #
## running this script to avoid conflicts with Qumulo's          #
## Network Assistant process.                                    #
##                                                               #
## For assistance please contact care@qumulo.com                 #
##                                                               #
##################################################################

# When called by Cron at system boot, the "enable" argument is supplied.
if [[ $1 == "enable" ]]; then
    echo "ENABLING STATIC ROUTE SERVICE"
    systemctl enable qumulo-static-route.service
fi

# 2 minute delay timer to ensure we don't conflict with Network Assistant.
# Making this value shorter could lead to the route(s) failing to be applied.
# The impatient can supply "now" to skip this.
if [[ $1 != "now" ]]; then
    sleep 120;
fi

echo "APPLYING STATIC ROUTE(S)"

###################################################
##  Add new routes by modifying the line below.  ##
###################################################
ip route add default via 10.60.110.1 dev bond0.2007 table 100
ip route add default via 10.60.108.1 dev bond0.2012 table 200

ip rule add from 10.60.110.0/24 lookup 100
ip rule add from 10.60.108.0/24 lookup 200
