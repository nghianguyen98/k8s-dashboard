#!/bin/bash
#Create token
var=`kubectl -n kubernetes-dashboard create token admin-user`
echo "Use this token login to dash board at https://nodeIP:31000"
echo "------------------------Token--------------------------"
echo  $var
echo "-------------------------------------------------------"