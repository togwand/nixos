{ ... }:
{
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    servers = {
      nixd.enable = true;
      bashls.enable = true;
    };
  };
}
