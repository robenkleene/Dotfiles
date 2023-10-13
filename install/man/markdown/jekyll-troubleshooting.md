%

# Jekyll Troubleshooting

`libffi.so.8: cannot open shared object file`:

    wget http://http.us.debian.org/debian/pool/main/libf/libffi/libffi8_3.4.4-1_amd64.deb
    sudo dpkg -i ./libffi8_3.4.4-1_amd64.deb

`cannot load such file -- webrick`:

    bundle add webrick
