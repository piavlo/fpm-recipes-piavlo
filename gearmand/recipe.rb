class Gearmand < FPM::Cookery::Recipe
  homepage    'http://gearman.org/'
  name        'gearmand'
  version     '1.1.11'
  source      "https://launchpad.net/gearmand/1.2/#{version}/+download/#{name}-#{version}.tar.gz"
  md5         '5048ff0a366f7c37e0abf86d88e7cb9c'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'Germand jobs server'
  section     'messaging'

  depends       'libevent-2.0-5', 'libssl1.0.0', 'libboost-program-options1.46.1', 'libmysqlclient18', 'libstdc++6'
  build_depends 'gcc', 'make', 'libssl-dev', 'libboost-dev', 'libboost-program-options-dev', 'gperf', 'libevent-dev', 'libcloog-ppl0', 'libmysqlclient18-dev'

  conflicts 'libgearman6', 'gearman-job-server', 'gearman-tools'
  replaces  'libgearman6', 'gearman-job-server', 'gearman-tools'

  post_install   'post-install'	
  post_uninstall 'post-uninstall'

  def build
    configure \
      '--disable-libmemcached',

      :prefix => prefix,

      'with-mysql'      => 'yes',
      'with-postgresql' => 'no',
      'with-sqlite3'    => 'no',

      :sysconfdir    => '/etc'
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
    etc('init.d').install workdir('init.d'), 'gearmand'
    etc('default').install workdir('params'), 'gearmand'
  end
end
