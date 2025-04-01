FROM alpine:latest
RUN apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers upx && \
    git clone https://github.com/xmrig/xmrig.git && cd xmrig && \
    sed -i 's/DonateLevel\ =\ 1/DonateLevel\ =\ 0/g' src/donate.h && \
    sed -i 's/"donate-level":\ 1/"donate-level":\ 0/g' src/core/config/Config_default.h && \
    sed -i 's/"donate-over-proxy":\ 1/"donate-over-proxy":\ 0/g' src/core/config/Config_default.h && \
    sed -i 's/"coin":\ null/"coin":\ "monero"/g' src/core/config/Config_default.h && \
    sed -i 's/donate.v2.xmrig.com:3333/pool.supportxmr.com:443/g' src/core/config/Config_default.h && \
    sed -i 's/YOUR_WALLET_ADDRESS/87NPmUCea3vBj8FE4CMGNFUHACvVvrHxfTpYT3kQGXhnCxmF7eqMmivge9t8QAye7f6nDXMEZzzZeZMtqtrorMkGVffrHBz/g' src/core/config/Config_default.h && \
    sed -i 's/"nicehash":\ false/"nicehash":\ true/g' src/core/config/Config_default.h && \
    sed -i 's/"tls":\ false/"tls":\ true/g' src/core/config/Config_default.h && \
    mkdir build && cd scripts && \
    ./build_deps.sh && cd ../build && \
    cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON -DWITH_EMBEDDED_CONFIG=ON && \
    make -j$(nproc) && \
    strip xmrig && \
    upx xmrig
