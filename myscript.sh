hosts=(master slave)

for host in "${hosts[@]}"
do
	ssh ubuntu@$host sudo apt-get update
	ssh ubuntu@$host sudo apt-get --assume-yes install openjdk-8-jdk
	ssh ubuntu@$host sudo apt-get --assume-yes install scala
done

for host in "${hosts[@]}"
do
	echo Working on $host
	echo =================
	echo Checking $host for the tarball
	ssh ubuntu@$host test -e spark-2.2.0-bin-hadoop2.7.tgz
	EXIT_CODE=$?
	if [ $EXIT_CODE -eq 0 ]; then
		echo The tarball is there.
	else
		ssh ubuntu@$host wget http://apache.mirror.anlx.net/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz
	fi
	echo Checking $host for the directory
	ssh ubuntu@$host test -e /usr/local/spark
	EXIT_CODE=$?
	if [ $EXIT_CODE -eq 0 ]; then
		echo The tarball has been unpacked.
	else
		ssh ubuntu@$host tar zxvf --overwrite spark-2.2.0-bin-hadoop2.7.tgz
		ssh ubuntu@$host sudo mkdir -p /usr/local/spark
		ssh ubuntu@$host sudo mv -v spark-2.2.0-bin-hadoop2.7/* /usr/local/spark
	fi
	ssh ubuntu@$host sudo chown -R ubuntu /usr/local/spark

done