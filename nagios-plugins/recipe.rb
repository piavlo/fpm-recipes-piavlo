class NagiosPlugins < FPM::Cookery::Recipe
  homepage    'http://nagiosplugins.org/'
  name        'nagios-plugins'
  version     '1.4.15'
  source      "http://prdownloads.sourceforge.net/sourceforge/nagiosplug/#{name}-#{version}.tar.gz"
  md5         '56abd6ade8aa860b38c4ca4a6ac5ab0d'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'Nagios Plugins'
  section     'monitoring'

  depends       'libnagios-plugin-perl'
  build_depends 'gcc', 'make' 'libssl-dev', 'libperl-dev'

  pre_install    'preinst'	
  post_uninstall 'postrm'

  def build
    configure \
      :prefix => prefix,

      'enable-extra-opts' => true,
      'with-openssl'      => true,
      'with-trusted-path' => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',

      'with-nagios-user'  => 'nagios',
      'with-nagios-group' => 'nagcmd',

      :sysconfdir    => '/etc',
      :localstatedir => '/var/lib/nagios',
      :libexec       => '/usr/lib/nagios/plugins'
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
