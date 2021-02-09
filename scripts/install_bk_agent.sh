#! /usr/bin/env bash

#=============================================
# Script Name: install_bk_agent.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-09
#       Usage: bash install_bk_agent.sh
# Description: install bk agent
#=============================================

# Define variables -- BEGIN #
LC_ALL=C
# Define variables -- END #

# Script Body -- BEGIN #

[ -d /tmp/agents ] || mkdir -p /tmp/agents
curl -o  /tmp/agents/agent_setup_pro.sh http://10.150.45.215:80/download/agent_setup_pro.sh
chmod a+x /tmp/agents/agent_setup_pro.sh
/tmp/agents/agent_setup_pro.sh -m client -g 10.150.45.215:80 -e 10.137.13.32 -I 0
rm /tmp/agents -rf

# Script Body -- END #