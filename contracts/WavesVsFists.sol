// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavesVsFists {
    address private _owner;
    mapping(address => bool) private _wallets;

    uint256 totalWaves;
    uint256 totalFists;

    constructor() {
        console.log("Let the wave vs fist game begin!");
        _owner = msg.sender;
    }

    function wave() public {
        assertCanVote();

        _wallets[msg.sender] = true;
        totalWaves++;
        console.log("Thanks for giving me a wave %s.", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Uuuuuh, already %d waves in total.", totalWaves);
        return totalWaves;
    }

    function fist() public {
        assertCanVote();

        _wallets[msg.sender] = true;
        totalFists++;
        console.log("Thanks for giving me a fist bump %s.", msg.sender);
    }

    function getTotalFists() public view returns (uint256) {
        console.log("Strooong, already %d fists in total.", totalFists);
        return totalFists;
    }

    function assertCanVote() private view {
        if (_owner == msg.sender) {
            revert("Owner is not allowed to wave or fist bump.");
        }

        if (_wallets[msg.sender]) {
            revert("Each wallet can only wave or fist bump once.");
        }
    }
}
