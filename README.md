## Basic commands
```shell
#run sandbox blockchain instance locally using hardhat
npx hardhat node
```
```shell
#compile contracts (compiled contracts will appear in /artifacts folder
npx hardhat compile
```
```shell
#deploy contracts to local blockchain
npx hardhat run scripts/deploy.js --network localhost
```
```shell
#deploy contracts to other networks defined in hardhat.config.js file
npx hardhat run scripts/deploy.js --network <network name>
```

## Fresh project initialization
```shell
mkdir <project name>
cd <project name>
#install required libraries
npm install ethers hardhat chai @nomiclabs/hardhat-ethers @nomicfoundation/hardhat-toolbox
```
