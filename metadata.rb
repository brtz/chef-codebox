name              "codebox"
maintainer        "Nils Bartels"
maintainer_email  "n.bartels@bigpoint.net"
license           "All rights reserved"
description       "Installs/configures codebox with multiple users"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'
recipe            "codebox::default", "Installs/configures codebox"

supports 'debian'

# nginx as auth
depends 'nginx'
depends 'nodejs'
depends 'git'

# recommendations for further components
