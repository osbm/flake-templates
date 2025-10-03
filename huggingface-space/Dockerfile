FROM nixos/nix:2.31.2
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
COPY . /workspace
WORKDIR /workspace
RUN nix build .#default --out-link /workspace/result
CMD ["/workspace/result/bin/run-gradio"]
