# Encoding: UTF-8
default['codebox']['kitchen-env']['dependencies'] = [
  'libpython2.7',
  'libgl1-mesa-glx',
  'libqt4-network',
  'libqt4-opengl',
  'libqtcore4',
  'libqtgui4',
  'libsdl1.2debian',
  'libvpx1',
  'libxcursor1',
  'libxinerama1',
  'libxmu6'
]
default['codebox']['kitchen-env']['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.3.6/virtualbox-4.3_4.3.6-91406~Debian~wheezy_amd64.deb'
default['codebox']['kitchen-env']['virtualbox']['version'] = '4.3_4.3.6-91406~Debian~wheezy_amd64'
default['codebox']['kitchen-env']['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.3_x86_64.deb'
default['codebox']['kitchen-env']['vagrant']['version'] = '1.4.3_x86_64'
