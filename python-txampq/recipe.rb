class PythonTxAMQP < FPM::Cookery::Recipe
  description 'Python library for communicating with AMQP peers and brokers using Twisted'

  name     'python-txamqp'
  version  '0.6.2'
  revision 0
  license  'Apache 2'
  homepage 'https://launchpad.net/txamqp'
  source   'https://launchpad.net/txamqp/trunk/0.3/+download/python-txamqp_0.3.orig.tar.gz'

  arch     'all'

  build_depends 'python2.7', 'python-setuptools'
  depends       'python2.7', 'python-support', 'python-twisted'

  def build
    safesystem 'python2.7 setup.py build'
  end

  def install
    safesystem 'python2.7 setup.py install --root=../../tmp-dest --install-layout=deb --install-lib=usr/lib/python2.7/dist-packages --install-scripts=bin'
  end
end
