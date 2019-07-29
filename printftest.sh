#!/bin/bash

var1="Value1"
var2="Value2"

template="This is a %s template"

printf -v result "$template" $var1

echo $result

printf -v result "$template" $var2

echo $result


