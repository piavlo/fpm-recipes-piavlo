class Kafka < FPM::Cookery::Recipe
  description 'A high-throughput distributed messaging system'

  v = '0.8.1.1'
  name     'kafka'
  version  "2.10-#{v}"
  revision 0
  homepage 'http://kafka.apache.org/'
  source   "http://apache.spd.co.il/kafka/#{v}/kafka_#{version}.tgz"
  md5      'f3f7446788d9a06f6bfaba72912bd8cf'
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

    sbin.install 'kafka.sh', 'kafka'
  end
end
