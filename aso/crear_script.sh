#!/bin/bash

read -p "Introduce el nombre del fichero --> " nombre 

touch $nombre
chmod 755 $nombre
echo "#!/bin/bash" >> $nombre
