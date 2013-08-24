class NagiosCheckMulti < FPM::Cookery::Recipe
  homepage    'http://my-plugin.de/wiki/projects/check_multi/start'
  name        'nagios-check-multi'
  version     '0.26'
  source      "http://my-plugin.de/check_multi/check_multi-stable-#{version}.tar.gz"

  md5         '38f822c3911c0cd5e625e859237ff902'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'check_multi is a multi purpose wrapper plugin which takes benefit of the Nagios 3.x capability to display multiple lines of plugin output.'
  section     'monitoring'

  depends       'nagios-plugins'
  build_depends 'gcc', 'make'

  def build
    configure \
      :prefix => prefix,
      :libexec => '/usr/lib/nagios/plugins'
    make :all
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
