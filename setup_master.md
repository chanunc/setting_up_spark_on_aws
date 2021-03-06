1. Add `xxx.xxx.xxx.xxx master` in Macbook `/etc/hosts`.
1. `ssh ubuntu@master`.
1. Refresh `apt-get`:

        sudo apt-get --assume-yes update
1. Install Java:

        sudo apt-get --assume-yes install openjdk-8-jdk

    Check with `java -version`.
1. Install Scala:

        sudo apt-get --assume-yes install scala

    Check with `scala -version`.
1. Download Spark and unpack:

        wget http://apache.mirror.anlx.net/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz
        tar zxvf spark-2.2.0-bin-hadoop2.7.tgz
        sudo mkdir /usr/local/spark
        sudo mv spark-2.2.0-bin-hadoop2.7/* /usr/local/spark
1. Add these to the `.profile`:

        export JAVA_HOME=$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')
        export SPARK_HOME=/usr/local/spark
        export PATH=$PATH:${SPARK_HOME}/bin

    Then source it with `. .profile`.

1. Create the conf file `/usr/local/spark/conf/spark-env.sh`.

        export JAVA_HOME=$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')
        export SPARK_PUBLIC_DNS="`curl -s http://169.254.169.254/latest/meta-data/public-hostname`"
        export SPARK_WORKER_CORES=2

1. Chown the dir:

        sudo chown -R ubuntu $SPARK_HOME

1. Start the `master` node:

        /usr/local/spark/sbin/start-master.sh

1. Go see its UI at `<public_dns>:8080`.
