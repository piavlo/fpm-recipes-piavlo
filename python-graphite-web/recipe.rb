class GraphiteWeb < FPM::Cookery::Recipe
  description 'Graphite frontend Django webapp'

  name     'python-graphite-web'
  version  '0.9.12'
  revision 0
  license  'Apache 2'
  homepage 'https://github.com/graphite-project/graphite-web'
  source   'https://github.com/graphite-project/graphite-web', :with => :git, :tag => version

  arch     'all'

  build_depends 'python2.7', 'python-setuptools'
  depends       'python2.7', 'python-support', 'python-whisper', 'python-carbon', 'python-twisted', 'python-cairo'
  depends	'python-django', 'python-django-tagging', 'python-memcache', 'python-pysqlite2', 'python-sqlite', 'python-txamqp'

  def build
    safesystem 'python2.7 setup.py build'
  end

  def install
    safesystem 'python2.7 setup.py install --root=../../tmp-dest --install-layout=deb --install-lib=usr/lib/python2.7/dist-packages --install-scripts=bin'
  end
end
