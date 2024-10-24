function hx_enable_deno_lsp
    mkdir -p ./.helix
    echo "*" >./.helix/.gitignore

    string trim "
[language-server.deno-lsp]
required-root-patterns = []
    " >./.helix/languages.toml
end
