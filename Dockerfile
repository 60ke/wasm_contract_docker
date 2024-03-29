
FROM rustlang/rust:nightly

LABEL author "boya"
LABEL maintainer=lsk

ADD config /usr/local/cargo
RUN /usr/local/cargo/bin/rustup target add wasm32-unknown-unknown
RUN git clone https://gitee.com/worileqing/wasm_contract_tools.git /root/wasm_contract_tools
RUN cd /root/wasm_contract_tools/compile-tool && rustc readhex.rs && cargo +nightly -Z unstable-options build  --release --out-dir .
RUN cd /root/wasm_contract_tools/contract/workspace && bash build.sh

ENTRYPOINT [ "/root/wasm_contract_tools/compile-tool/wasm-compile" ]
