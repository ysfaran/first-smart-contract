// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavesVsFists {
    address private _owner;
    uint256 private _seed;

    uint256 totalWaves;
    uint256 totalFists;
    uint256 prizeAmount = 0.0001 ether;
    mapping(address => uint256) public lastWavedAt;

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
        _seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        assertCanGreet();

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves++;
        waves.push(Greeting(msg.sender, _message, block.timestamp));

        sendPrize();

        emit NewWave(msg.sender, block.timestamp, _message);
        console.log("Thanks for giving me a wave %s.", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }

    function getAllWaves() public view returns (Greeting[] memory) {
        return waves;
    }

    function fist(string memory _message) public {
        assertCanGreet();

        lastWavedAt[msg.sender] = block.timestamp;

        totalFists++;
        fists.push(Greeting(msg.sender, _message, block.timestamp));

        sendPrize();

        emit NewFist(msg.sender, block.timestamp, _message);
        console.log("Thanks for giving me a fist bump %s.", msg.sender);
    }

    function getTotalFists() public view returns (uint256) {
        return totalFists;
    }

    function getAllFists() public view returns (Greeting[] memory) {
        return fists;
    }

    function sendPrize() private {
        assertBalance();

        _seed = (block.difficulty + block.timestamp + _seed) % 100;
        console.log("Random # generated: %d", _seed);

        if (_seed <= 50) return;

        console.log(
            "The randomness is on your side %s. You got a prize!",
            msg.sender
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function assertCanGreet() private view {
        require(
            _owner != msg.sender,
            "Owner is not allowed to wave or fist bump."
        );
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Each wallet can only wave or fist bump once within 15 minutes."
        );
    }

    function assertBalance() private view {
        require(
            prizeAmount <= address(this).balance,
            "Ooops, contract has no ETH to send. More funds please!"
        );
    }
}
