// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {OlaMundo} from "../src/OlaMundo.sol";

contract OlaMundoTest is Test {
    OlaMundo public olaMundo;

    function setUp() public {
        olaMundo = new OlaMundo();
    }

    function test_OlaMundo() public view{
        string memory esperado = "Ola, Mundo Cruel!";
        string memory atual = olaMundo.olaMundo();
        assertEq(atual, esperado);
    }

    // function testFuzz_SetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }
}
