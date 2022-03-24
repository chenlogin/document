#!/bin/sh

var="123"
echo "asv$var"
nodeVersion=$(node -v)
npmVersion=$(npm -v)

sh 'printenv'

echo "node $nodeVersion\nnpm $npmVersion"

echo "$HOME/jenkins"
