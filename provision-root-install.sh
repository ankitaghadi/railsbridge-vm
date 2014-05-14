# RailsBridge VM provision script

# Set versions here
RAILSBRIDGE_RUBY_VERSION='2.0'
RAILSBRIDGE_CHRUBY_VERSION='0.3.8.rbb201405.4'

# Tell the shell to print commands before running them
set -v

# Remove configuration-management systems preinstalled in official Ubuntu images
apt-get -y remove --purge chef chef-zero puppet puppet-common landscape-client landscape-common
# And any dependencies
apt-get -y autoremove
# Get any security updates not in the base image
sudo apt-get update
sudo apt-get -y upgrade
# Other packages we need
sudo apt-get install -q -y git vim nodejs sqlite3 libsqlite3-dev

# Copy our files into place
rsync -rtv /vagrant/etcfiles/ /etc
rsync -rtv /vagrant/binfiles/ /usr/local/bin
# Force MOTD generation (will only work on 14.04)
rm -f /etc/update-motd.d/51-cloudguest
run-parts --lsbsysinit /etc/update-motd.d > /run/motd.dynamic

# Build/install Ruby (our fork of chruby will not automatically build all rubies)
cd /usr/local/src
curl -s -L "https://github.com/railsbridge-boston/chruby/archive/v$RAILSBRIDGE_CHRUBY_VERSION.tar.gz" | tar xzv
(cd "chruby-$RAILSBRIDGE_CHRUBY_VERSION" && ./scripts/setup.sh)
ruby-install ruby "$RAILSBRIDGE_RUBY_VERSION" -- --disable-install-rdoc
