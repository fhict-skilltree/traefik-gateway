if mkcert > /dev/null 2>&1 ; then
    echo "==] mkcert is installed"
    mkcert -install
else
    echo "==] mkcert is not installed! Installing..."
    echo -n "Should we install mkcert using sudo apt-get install mkcert? (Y/n)";
    should_install="Y"
    read should_install
    should_install=${should_install:-"Y"}
    if [[ "$should_install" = "y" ]] || [[ "$should_install" = "Y" ]]; then
        sudo apt install libnss3-tools
        sudo apt install mkcert
        mkcert -install
    else
        echo "Please install mkcert!"
        exit;
    fi
fi

if [ -f "certs/local-cert.pem" ] && [ -f "certs/local-key.pem" ]; then
  echo "Local certificate exists. You can run ./start.sh instead unless you want to regenerate the certificates!"
fi

mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem \
    "traefik.localhost" \
    "docker.localhost" \
    "*.docker.localhost" \
    "domain.local" \
    "*.domain.local" \
    "talentpulse.localhost" \
    "*.talentpulse.localhost"

./start.sh