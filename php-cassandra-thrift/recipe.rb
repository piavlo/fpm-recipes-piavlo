class PhpCassaThrift < FPM::Cookery::Recipe
  homepage    'http://gearman.org/'
  name        'php-cassandra-thrift'
  version     '1.1.0'
  source      'https://github.com/thobbs/phpcassa', :with => :git, :tag => "v#{version}"

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'PHP Cassandra Thrift Module'
  section     'php'

  depends       'php5-common'
  build_depends 'php5-dev', 'gcc', 'make'

  def build
    Dir.chdir 'ext/thrift_protocol' do
      system 'phpize'
      system 'autoreconf --force --install'
      system './configure'
      make
    end
  end

  def install
    Dir.chdir 'ext/thrift_protocol' do
      prefix('lib/php5/20100525/').install 'modules/thrift_protocol.so'
      etc('php5/mods-available/').install workdir('thrift_protocol.ini')
    end
  end
end
