class PhpMemcached < FPM::Cookery::Recipe
  homepage    'http://pecl.php.net/package/memcached'
  name        'php-memcached'
  version     '2.1.0'
  source      "http://pecl.php.net/get/memcached-#{version}.tgz"
  md5         'daf070aad13bebffdff50acf6e93043c'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'PHP Memcached Module'
  section     'php'
  depends       'libmemcached', 'php5-common'
  build_depends 'libmemcached', 'php5-dev', 'gcc', 'make'

  def build
    system 'phpize'
    system './configure --enable-memcached-igbinary'
    make
  end

  def install
    prefix('lib/php5/20100525/').install 'modules/memcached.so'
    etc('php5/mods-available/').install workdir('memcached.ini')
  end
end
