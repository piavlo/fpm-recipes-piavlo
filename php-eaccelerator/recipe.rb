class Eaccelerator < FPM::Cookery::Recipe
  homepage    'http://eaccelerator.net/'
  name        'php-eaccelerator'
  version     '0.9.6.2'
  source      'https://github.com/eaccelerator/eaccelerator', :with => :git

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'eAccelerator PHP opcode cache'
  section     'php'

  depends       'php5-common'
  build_depends 'php5-dev', 'gcc', 'make'

  def build
    system 'phpize'
    system './configure'
    make
  end

  def install
    prefix('lib/php5/20100525/').install 'modules/eaccelerator.so'
    etc('php5/mods-available/').install workdir('eaccelerator.ini')
  end
end
