class ModGearman < FPM::Cookery::Recipe
  homepage    'https://labs.consol.de/nagios/mod-gearman/'
  name        'mod-gearman'
  version     '1.4.10'
  source      "http://www.mod-gearman.org/download/v#{version}/src/mod_gearman-#{version}.tar.gz"
  md5         '712623c9d3c1dc63307dd56a4dc2cf05'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'Mod_Gearman is an easy way of distributing active Nagios checks across your network and increasing Nagios scalability'
  section     'messaging'

  depends       'gearmand'
  build_depends 'gcc', 'make'

  conflicts 'mod-gearman-tools'
  replaces  'mod-gearman-tools'

  def build
    configure \
      :prefix     => prefix,
      :sysconfdir => '/etc'
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
    rm_f etc('init.d/gearmand'), :verbose => true
  end
end
