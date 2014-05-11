# RailsBridge VM provision script (cleanup part)

# Tell the shell to print commands before running them
set -v

# Remove downloaded Ruby source
rm -rf /usr/local/src/ruby-*
rm -rf /usr/local/src/chruby-*

# Remove dependencies of Twisted Python
apt-get -y remove --purge libjs-jquery python-apport python-crypto python-dbus python-dbus-dev python-gdbm python-gi python-httplib2 python-keyring python-launchpadlib python-lazr.restfulclient python-lazr.uri python-openssl python-pam python-pkg-resources python-problem-report python-pycurl python-secretstorage python-simplejson python-twisted-bin python-twisted-core python-twisted-names python-twisted-web python-wadllib python-zope.interface
apt-get -y autoremove

# Clean up APT cache and zero out disk to reduce image size
apt-get clean
dd if=/dev/zero of=/EMPTY bs=1M
rm /EMPTY
