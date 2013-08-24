class Libzookeeper < FPM::Cookery::Recipe
  homepage    'http://zookeeper.apache.org/'
  name        'libzookeeper'
  version     '3.4.5'
  source      "http://www.us.apache.org/dist/zookeeper/stable/zookeeper-#{version}.tar.gz"
  md5         'f64fef86c0bf2e5e0484d19425b22dcb'

  revision    '1'
  maintainer  'Piavlo <lolitushka@gmail.com>'
  license     'Apache 2'
  description 'Zookeeper C multithread bindings'
  section     'messaging'

  depends       'libcppunit-1.12-1'
  build_depends 'libcppunit-dev', 'gcc', 'make', 'ant'

  conflicts 'libzookeeper-mt2', 'libzookeeper-mt-dev'
  replaces  'libzookeeper-mt2', 'libzookeeper-mt-dev'

  def build
    system 'ant compile_jute'
    Dir.chdir 'src/c' do
      system 'autoreconf -if'
      configure :prefix => prefix
      make
    end
  end

  def install
    Dir.chdir 'src/c' do
      make :install, 'DESTDIR' => destdir
    end
    File.delete "#{destdir}/usr/bin/cli_st"
    Dir.glob("#{destdir}/usr/lib/libzookeeper_st.*").each do |f|
      File.delete f
    end
  end
end
