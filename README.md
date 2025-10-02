
See all my nix templates:

```bash
$ nix flake show github:osbm/flake-templates
```

Apply a template to the current folder. I recomment you to be in an empty folder

```bash
$ nix flake init -t github:osbm/flake-templates#pytorch
```

Repo is MIT licensed