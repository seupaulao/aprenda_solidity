// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OlaMundo {
    string public mensagem = "Ola, Mundo Cruel!";

    function olaMundo() public view returns (string memory) {
        return mensagem;
    }
}