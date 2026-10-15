// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {OlaMundo} from "../src/OlaMundo.sol";
import {LivroDatabase} from "../src/LivroDatabase.sol";

contract DeployTudo is Script {
    OlaMundo public olaMundo;
    LivroDatabase public livroDatabase;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        olaMundo = new OlaMundo();
        livroDatabase = new LivroDatabase();

        vm.stopBroadcast();
    }
}
