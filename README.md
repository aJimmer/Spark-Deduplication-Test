# Run cluster

### Please clone an existing EMR cluster, So that all configuration are intact.
### You may need putty to ssh the EMR cluster. 
### After ssh you can need to run following commands in sequence

## Install git

`sudo yum install git`
`git --version`

## Install Maven

`sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo`
`sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo`
`sudo yum install -y apache-maven`
`mvn --version`


## Make project directory

`mkdir project`
`cd project`



## Clone repo

`git clone https://github.com/aJimmer/Spark-Deduplication.git`

## Go to

`cd /home/hadoop/project/Spark-Deduplication`



## Make shell script executetable

`chmod a+x run.sh`

## Run Application

`./run.sh`

## After successfull execution of script run following command to move data from hdfs to local system

`hdfs dfs -get /ded_output /home/hadoop/project/Spark-Deduplication`

## Check output data
cd ded_output
cat part-00000