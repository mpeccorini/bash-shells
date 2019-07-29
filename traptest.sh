#!/bin/bash

echo "setting errexit"
set -o errexit

function trapfunc(){
  echo "trapped"
}

function traptest(){
  echo "unsetting errexit"
  set +o errexit
  echo "setting up trap"
  trap 'trapfunc' ERR

  echo "failing"
  ls ./nofile.txt

  echo "clearing the trap"
  trap - ERR
  echo "resetting errexit"
  set -o errexit

  echo "failing again"
  ls ./nofile.txt

  echo "this should not happen"
}

traptest
