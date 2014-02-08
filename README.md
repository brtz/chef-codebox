Description
===========
This chef cookbook installs a box to be a developer system serving a web based cloud ide.
In this case codebox will be delivered. As this cookbook is also focused on multi user support
multiple codebox instances are possible. To simplify access the instances are served through
an nginx reverse proxy.

Requirements
============
The cookbook requires you to create a databag call codebox including an item called users. In there you have
to store at least one user with his details. See the test/integration/default/data_bags/codebox/users.json.

PLEASE BE AWARE! This cookbook will not create the user you specify there. The user has to exist on the
targeted machine! In the author's humble opinion everyone uses his own user provisioning implementation.
This will always result conflicts if it is implemented here as well.

Please also note that the cookbook is tested with debian wheezy only. If you would like to see support for other
platforms open up an issue/pull request providing the author with details.

Further Components
=============
You could also call this plugins or extensions. The basic idea of this is to add further recipes that are loadable
through a node attribute. The author added a test-kitchen fc to show an example (and as he needed that :D).
The kitchen-env fc adds virtualbox, vagrant and test-kitchen including dependencies to the node. This way multiple
developers can use the codebox ide and run kitchen on that machine always keeping at the same version
(aka no more "DID YOU GUYS UPDATE VBOX AS WELL? IT BROKE..."
You could also do other stuff like setting up a redis server or deploy a filebase to each workspace.
In the author's humble opinion: DON'T! No matter how simple it seems, do not try to create shared services
between different developers. Reduce usage to a minimum and deploy applications every developer on your box can
use seperately.
If you would like to see some other fcs included, fork this repo, write them, test them and open up a pull
request please.

Software Links
==============

This cookbooks uses various pieces of software, either prepackaged or from source code. Please check their sites for
further documentation.

* codebox: http://www.codebox.io
* nginx: http://nginx.org/
* git: http://git-scm.com/

Optional through fc:
* virtualbox: http://www.virtualbox.org
* vagrant: http://www.vagrantup.com
* test-kitchen: http://kitchen.ci/
* rubocop: http://batsov.com/rubocop/

Poem
=======

License and Author
==================

Author:: Nils Bartels <n.bartels@bigpoint.net>

Copyright (c) 2014, Nils Bartels
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
