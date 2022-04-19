const main = async () => {
  const factory = await hre.ethers.getContractFactory("WavesVsFists");
  const wavesVsFistsContract = await factory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await wavesVsFistsContract.deployed();
  console.log("Contract addy:", wavesVsFistsContract.address);
  let contractBalance = await hre.ethers.provider.getBalance(
    wavesVsFistsContract.address
  );

  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  const [_, randomPerson, randomPerson2] = await hre.ethers.getSigners();

  let waveCount;
  waveCount = await wavesVsFistsContract.getTotalWaves();
  console.log("Wave count:", waveCount.toNumber());

  // let waveTxn = await wavesVsFistsContract.wave("A message!");
  // await waveTxn.wait();

  waveTxn = await wavesVsFistsContract
    .connect(randomPerson)
    .wave("Another message!");
  await waveTxn.wait();

  waveTxn = await wavesVsFistsContract
    .connect(randomPerson2)
    .wave("Another message 2!");
  await waveTxn.wait();

  let allWaves = await wavesVsFistsContract.getAllWaves();
  console.log(allWaves);

  contractBalance = await hre.ethers.provider.getBalance(
    wavesVsFistsContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let fistCount;
  fistCount = await wavesVsFistsContract.getTotalFists();
  console.log("Fist count:", fistCount.toNumber());

  // let fistTxn = await wavesVsFistsContract.fist("A message!");
  // await fistTxn.wait();

  // fistTxn = await wavesVsFistsContract
  //   .connect(randomPerson)
  //   .fist("Another message!");
  // await waveTxn.wait();

  fistTxn = await wavesVsFistsContract
    .connect(randomPerson2)
    .fist("Another message 2!");
  await waveTxn.wait();

  let allFists = await wavesVsFistsContract.getAllFists();
  console.log(allFists);

  contractBalance = await hre.ethers.provider.getBalance(
    wavesVsFistsContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );
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
