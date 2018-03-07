# test-warp-tls

Requests does not complete when using warp-tls with wai-cors on Edge, Internet explorer and Safari.

To test:
> git pull ~
> cd ~
> stack build
> stack exec test-warp-client

Open your browser in localhost and check devtools.