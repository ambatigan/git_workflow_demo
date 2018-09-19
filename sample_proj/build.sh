#!/bin/bash
DIR="/home/ganga/workspace1/git_workflow_demo/sample_proj"
if [ ! -z "$1" ]; then
        if [ -d "$DIR/$1" ]; then
                if [ -f "$DIR/$1/env.txt" ]; then
                        ENV_TYPE=`cat $DIR/$1/env.txt`
                else
                        echo "env.txt file not available for given $1 "
                        exit
                fi
        else
                echo "Given $1 is not available"
                exit
        fi
else
        echo "Please provide argument qa or dev or prod"
        exit
fi
if [ ! -d "$DIR/target" ]; then
        mkdir $DIR/target
fi
sed "s/<ENV>/${ENV_TYPE}/g" $DIR/index.html > $DIR/target/index.html

#Deploying Project into Tomcat
cd
if [ ! -d "/opt/tomcat/webapps/sample_proj" ]; then
        mkdir /opt/tomcat/webapps/sample_proj
fi
cp $DIR/target/index.html /opt/tomcat/webapps/sample_proj/
echo "successfully deployed in tomcat "
service tomcat restart
