# To run this script, call `source link_qt.shs`
if [ "${BASH_SOURCE[0]}" -ef "$0" ]
then
    echo "usage: \`. $0\`!"
    exit 1
fi

export PATH="/usr/local/opt/qt/bin:$PATH"

# If you need to have this software first in your PATH run:
#   echo 'export PATH="/usr/local/opt/qt/bin:$PATH"' >> ~/.bash_profile

# For compilers to find this software you may need to set:
#     LDFLAGS:  -L/usr/local/opt/qt/lib
#     CPPFLAGS: -I/usr/local/opt/qt/include
# For pkg-config to find this software you may need to set:
#     PKG_CONFIG_PATH: /usr/local/opt/qt/lib/pkgconfig