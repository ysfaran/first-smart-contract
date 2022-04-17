const main = async () => {
  const [owner, randomPerson, randomPerson2] = await hre.ethers.getSigners();
  const wavesVsFistsContractFactory = await hre.ethers.getContractFactory(
    "WavesVsFists"
  );
  const wavesVsFistsContract = await wavesVsFistsContractFactory.deploy();
  await wavesVsFistsContract.deployed();

  console.log("Contract deployed to:", wavesVsFistsContract.address);
  console.log("Contract deployed by:", owner.address);

  let waveCount;
  waveCount = await wavesVsFistsContract.getTotalWaves();

  // let waveTxn = await wavesVsFistsContract.wave().catch();
  // await waveTxn.wait().catch();

  // waveCount = await wavesVsFistsContract.getTotalWaves();

  waveTxn = await wavesVsFistsContract.connect(randomPerson).wave();
  await waveTxn.wait();

  waveCount = await wavesVsFistsContract.getTotalWaves();

  let fistCount;
  fistCount = await wavesVsFistsContract.getTotalFists();

  // let fistTxn = await wavesVsFistsContract.fist();
  // await fistTxn.wait().catch();

  // fistCount = await wavesVsFistsContract.getTotalFists();

  // fistTxn = await wavesVsFistsContract.connect(randomPerson).fist();
  // await fistTxn.wait().catch();

  // fistCount = await wavesVsFistsContract.getTotalFists();

  fistTxn = await wavesVsFistsContract.connect(randomPerson2).fist();
  await fistTxn.wait();

  fistCount = await wavesVsFistsContract.getTotalFists();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
