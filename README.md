

This is a simple Zabbix template to monitor various operating parameters of the concourse-ci tool.

Clone this repository, and use the template import function in zabbix to import the XML.

Copy the conf and sh files to the approriate places on a node which can run the "fly" command. Tweak the .sh with the right team name.

See
* https://concourse-ci.org/
* https://github.com/concourse


![Zabbix Screenshot](https://raw.githubusercontent.com/speculatrix/zabbix-concourse-ci/master/zabbix_template__concourse_ci.png)
