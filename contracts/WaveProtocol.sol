// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    address private _owner;
    uint256 totalWaves;

    constructor() {
        console.log("Let the waves hit me!");
        _owner = msg.sender;
    }

    function wave() public {
        if (_owner == msg.sender) {
            console.log(
                "Ups, I can't wave to myself. Wave count stays the same."
            );
            return;
        }

        totalWaves += 1;
        console.log("Thanks for hitting me with a wave %s.", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Uuuuuh, already %d waves in total.", totalWaves);
        return totalWaves;
    }
}
