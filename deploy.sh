# Serve static files
serve -s build -l 3000

server_path="/home/git/DavidJNy2_1/server/"
file_path="/home/git/DavidJNy2_1/server/server.js"
file_path_websocket="/home/git/DavidJNy2_1/server/websocket.js"

echo "Switching to branch master"
echo "Pulling from main"
sudo git pull

npm install
cd "$server_path"
npm install

echo "Building app..."
npm run build

echo "Deploying files to server..."
sudo scp -r build/ "$server_path"

# Stop existing pm2 processes
echo "Stopping existing pm2 processes..."
pm2 stop all

# Start new pm2 processes
echo "Starting pm2 processes..."
pm2 start "$file_path" --name "expressapp"
pm2 start "$file_path_websocket" --name "websocket"

echo "Rebooting server/services"
sudo systemctl restart myexpressapp

echo "Done!"
