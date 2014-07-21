class Librdkafka < FPM::Cookery::Recipe
  homepage    'https://github.com/edenhill/librdkafka'
  name        'librdkafka'
  version     '0.8'
  source      'https://github.com/edenhill/librdkafka', :with => :git, :branch => 'master'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'BSD'
  description 'Apache Kafka C/C++ client library'
  section     'messaging'

  depends       'zlib1g'
  build_depends 'gcc', 'g++', 'make', 'zlib1g-dev'

  def build
    configure :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
