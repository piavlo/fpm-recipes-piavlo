class Carbon < FPM::Cookery::Recipe
  description 'Carbon is one of the components of Graphite, and is responsible for receiving metrics over the network and writing them down to disk using a storage backend.'

  name     'python-carbon'
  version  '0.9.12'
  revision 0
  license  'Apache 2'
  homepage 'https://github.com/graphite-project/carbon'
  source   'https://github.com/graphite-project/carbon', :with => :git, :tag => version

  arch     'all'

  build_depends 'python2.7', 'python-setuptools'
  depends       'python2.7', 'python-support', 'python-whisper', 'python-twisted'

  post_install   'post-install'
  post_uninstall 'post-uninstall'

  def build
    safesystem 'python2.7 setup.py build'
  end

  def install
    safesystem 'python2.7 setup.py install --root=../../tmp-dest --install-layout=deb --install-lib=usr/lib/python2.7/dist-packages --install-scripts=bin'
    var('log/graphite').mkdir
    var('lib/graphite/whisper').mkdir
    etc('graphite').mkdir
  end
end
