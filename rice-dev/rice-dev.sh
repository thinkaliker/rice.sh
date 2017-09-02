
echo "=================================";
echo " Ricing out: dev";
echo " > installing build-essential";
sudo apt-get update -y
sudo apt-get install build-essential -y
echo " > installing vim";
sudo apt-get install vim -y
echo " > installing git"
sudo apt-get install git -y
echo " > cleaning up"
sudo apt-get autoremove -y
echo "=================================";