# /usr/bin/env bash
echo "Initial system update"
apt-get update
apt-get upgrade -y

echo "Configure shell"
echo "set -o vi" >> ~/.inputrc
echo "set -o vi" >> ~/.bashrc
echo 'alias workon-svchost="cd /opt"' >> ~/.bashrc

echo "Installing openresty"
apt-get -y install --no-install-recommends wget gnupg ca-certificates lsb-release
wget -O - https://openresty.org/package/pubkey.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/openresty.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
  | sudo tee /etc/apt/sources.list.d/openresty.list > /dev/null
apt-get update
apt-get install openresty -y
systemctl stop openresty.service

echo "Installing lua packages"
apt-get install libssl-dev luarocks -y
luarocks install luaossl CRYPTO_DIR=/usr/include CRYPTO_INCDIR=/usr/include CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu
luarocks install LuaFileSystem
luarocks install lua-resty-session
luarocks install etlua

echo "Configure log directories"
mkdir -p ../logs/
