class Librdkafka < FPM::Cookery::Recipe
  homepage    'https://github.com/edenhill/kafkacat'
  name        'kafkacat'
  version     '0.8'
  source      'https://github.com/edenhill/kafkacat', :with => :git, :branch => 'master'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'BSD'
  description 'Generic non-JVM Apache Kafka producer and consumer'
  section     'messaging'

  depends       'librdkafka'
  build_depends 'librdkafka'

  def build
    configure :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
