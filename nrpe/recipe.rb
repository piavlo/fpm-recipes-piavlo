#module FPM
#  module Cookery
#    class Path < Pathname
#      def patch(src, level = 0)
#        raise "patch level must be integer" unless level.is_a?(Fixnum)
#        raise "#{src} does not exist" unless File.exist? src
#        safesystem "patch -p#{level} < #{src}"
#      end
#    end
#  end
#end

class Nrpe < FPM::Cookery::Recipe
  homepage    'http://nagiosplugins.org/'
  name        'nrpe'
  version     '2.12'
  source      "http://prdownloads.sourceforge.net/sourceforge/nagios/#{name}-#{version}.tar.gz"

  md5         'b2d75e2962f1e3151ef58794d60c9e97'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'Nagios Remote Plugin Executor'
  section     'monitoring'

  depends       'nagios-plugins'
  build_depends 'gcc', 'make' 'libssl-dev'

  def build
    patch workdir('nrpe_multiline.patch'), 1

    configure \
      :prefix => prefix,

      'enable-command-args' => true,
      'enable-ssl'          => true,
      'with-trusted-path'   => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',

      'with-ssl-lib' => "/usr/lib/#{Facter.fact(:hardwaremodel).value}-linux-gnu",

      'with-nagios-user'  => 'nagios',
      'with-nagios-group' => 'nagcmd',
      
      'with-nrpe-user'  => 'nagios',
      'with-nrpe-group' => 'nagcmd',
      
      :sysconfdir    => '/etc',
      :localstatedir => '/var/lib/nagios',
      :libexec       => '/usr/lib/nagios/plugins',
      :bindir        => '/usr/sbin'

    make
  end

  def install
    make :install, 'DESTDIR' => destdir
    etc('init.d').install workdir('init.d'), 'nrpe'
  end
end
