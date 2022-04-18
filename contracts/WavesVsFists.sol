// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavesVsFists {
    address private _owner;
    mapping(address => bool) private _wallets;

    uint256 totalWaves;
    uint256 totalFists;
    uint256 prizeAmount = 0.0001 ether;

    event NewWave(address indexed from, uint256 timestamp, string message);
    event NewFist(address indexed from, uint256 timestamp, string message);

    struct Greeting {
        address from;
        string message;
        uint256 timestamp;
    }

    Greeting[] waves;
    Greeting[] fists;

    constructor() payable {
        console.log("Let the wave vs fist game begin!");
        _owner = msg.sender;
    }

    function wave(string memory _message) public {
        assertCanGreet();

        _wallets[msg.sender] = true;

        totalWaves++;
        waves.push(Greeting(msg.sender, _message, block.timestamp));

        sendPrize();

        emit NewWave(msg.sender, block.timestamp, _message);
        console.log("Thanks for giving me a wave %s.", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Uuuuuh, already %d waves in total.", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns (Greeting[] memory) {
        return waves;
    }

    function fist(string memory _message) public {
        assertCanGreet();

        _wallets[msg.sender] = true;

        totalFists++;
        fists.push(Greeting(msg.sender, _message, block.timestamp));

        sendPrize();

        emit NewFist(msg.sender, block.timestamp, _message);
        console.log("Thanks for giving me a fist bump %s.", msg.sender);
    }

    function getTotalFists() public view returns (uint256) {
        console.log("Strooong, already %d fists in total.", totalFists);
        return totalFists;
    }

    function getAllFists() public view returns (Greeting[] memory) {
        return fists;
    }

    function sendPrize() private {
        assertBalance();

        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function assertCanGreet() private view {
        require(
            _owner != msg.sender,
            "Owner is not allowed to wave or fist bump."
        );
        require(
            !_wallets[msg.sender],
            "Each wallet can only wave or fist bump once."
        );
    }

    function assertBalance() private view {
        require(
            prizeAmount <= address(this).balance,
            "Ooops, contract has no ETH to send. More funds please!"
        );
    }
}
