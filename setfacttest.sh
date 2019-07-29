#!/bin/bash

function setFactValue(){
  fact_key=$1
  fact_value=$2

  exists=$(grep $fact_key storeserver_automation.fact | wc -l)
  if [[ $exists -eq 0 ]]
  then
    # the fact does not exist
    echo "$fact_key=$fact_value" >> storeserver_automation.fact
  else
    # the fact already exists
    sed -i -e "s/$fact_key.*/$fact_key=$fact_value/" storeserver_automation.fact
  fi
}

# getFactValue
# Get the current value of an Ansible fact related to the storeserver
# automation tools
# Arguments:
#   fact_key: Name of the fact to be retrieved. The key is relative to the
#             'ansible_local.storeserver_automation.facts' namespace
function getFactValue(){
  fact_key=$1

  fact_value=$(grep "$fact_key" storeserver_automation.fact | cut -d'=' -f2)
  echo ${fact_value}
}


#setFactValue 'deploy_status' 'Never' # new value
#setFactValue 'sync_status' 'None' # same value
#setFactValue 'test_status' 'Failed' # new fact

getFactValue 'deploy_scheduled_version' # existing fact
getFactValue 'non-existing-fact' # non existing fact

if [[ `getFactValue 'sync_status'` == 'None' ]]
then
  echo 'test passed'
fi
