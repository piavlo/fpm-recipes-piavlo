class Kafka < FPM::Cookery::Recipe
  description 'A high-throughput distributed messaging system'

  v = '0.8.0'
  name     'kafka'
  version  "2.8.0-#{v}"
  revision 0
  homepage 'http://kafka.apache.org/'
  source   "http://ftp.fau.de/apache/kafka/#{v}/kafka_#{version}.tar.gz"
  md5      '593e0cf966e6b8cd1bbff5bff713c4b3'
  arch     'all'
  section  'databases'

  depends 'oracle-java7-installer'

  post_install   'post-install'
  post_uninstall 'post-uninstall'

  config_files %w(
    /etc/default/kafka
    /etc/kafka/consumer.properties
    /etc/kafka/producer.properties
    /etc/kafka/server.properties
    /etc/kafka/zookeeper.properties
  )

  def build
    rm_rf 'bin/windows'

    File.open('kafka.sh', 'w', 0755) do |f|
      f.write <<-__EOF
#!/bin/sh

exec /bin/sh /usr/share/kafka-#{version}/bin/kafka-run-class.sh kafka.Kafka /etc/kafka/server.properties
      __EOF
    end
  end

  def install
    share("kafka-#{version}").install Dir['*']

    etc('default').install workdir('kafka.default'), 'kafka'
    etc('init.d').install workdir('kafka.init'), 'kafka'
    etc('kafka').install Dir['config/*']
    etc('kafka').install workdir('log4j.properties')
    etc('security/limits.d').install workdir('kafka.limits'), 'kafka.conf'

    bin.install 'kafka.sh', 'kafka'
  end
end
