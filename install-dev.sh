git clone https://github.com/BreadGhoti1/DesktopOnCodespaces -b dev
cd DesktopOnCodespaces
pip install textual
sleep 2
python3 installer.py
docker build -t desktoponcodespaces . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir Save
cp -r DesktopOnCodespaces/root/config/* Save

json_file="DesktopOnCodespaces/options.json"
if jq ".enablekvm" "$json_file" | grep -q true; then
    docker run -d --name=DesktopOnCodespaces -e PUID=1000 -e PGID=1000 --device=/dev/kvm --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=GamingOnCodespaces -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped desktoponcodespaces
else
    docker run -d --name=DesktopOnCodespaces -e PUID=1000 -e PGID=1000 --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=GamingOnCodespaces -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped desktoponcodespaces
fi
docker run --rm -d -p 3000:3000/tcp -p 3001:3001/tcp desktoponcodespaces:latest
clear
echo "INSTALL FINISHED! Download Docker Extension and run image then open port 3000 in a new tab!!!"
