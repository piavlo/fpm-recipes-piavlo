class Whisper < FPM::Cookery::Recipe
  description 'Whisper is one of the components of Graphite, and is responsible for the backend storage of incoming metrics from the network.'

  name     'python-whisper'
  version  '0.9.12'
  revision 0
  license  'Apache 2'
  homepage 'https://github.com/graphite-project/whisper'
  source   'https://github.com/graphite-project/whisper', :with => :git, :tag => version

  arch     'all'

  build_depends 'python2.7', 'python-setuptools'
  depends       'python2.7', 'python-support'

  def build
    safesystem 'python2.7 setup.py build'
  end

  def install
    safesystem 'python2.7 setup.py install --root=../../tmp-dest --install-layout=deb'
  end
end
