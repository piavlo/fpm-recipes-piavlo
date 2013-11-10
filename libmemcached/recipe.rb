class Libmemcached < FPM::Cookery::Recipe
  homepage    'http://libmemcached.org/libMemcached.html'
  name        'libmemcached'
  version     '1.0.16'
  source      "https://launchpad.net/#{name}/1.0/#{version}/+download/#{name}-#{version}.tar.gz"
  md5         '1f3a7d559714791ac04ce8bcccc6b67e'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'libMemcached is an open source C/C++ client library and tools for the memcached server'
  section     'messaging'

  depends       'libsasl2-2'
  build_depends 'gcc', 'make', 'libsasl2-dev', 'memcached'

  conflicts 'libmemcached10', 'libmemcachedprotocol0'
  replaces  'libmemcached10', 'libmemcachedprotocol0'

  def build
    configure \
      '--enable-libmemcachedprotocol',
      :prefix     => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
