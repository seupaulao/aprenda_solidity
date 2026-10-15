// SPDX-License-Identifier: MIT
pragma solidity ^0.8.37;

contract LivroDatabase {

    struct Livro {
        string titulo;
        string autor;
        uint16 ano;
    }

    mapping(uint256 => Livro) public livros;
    
    uint32 private nextId = 0;
    
    uint32 public contador;
    
    address private immutable owner;

    constructor() {
        owner = msg.sender;
    }


    function getNextId() private returns (uint32) {
        return nextId++;
    }

    function addLivro(Livro memory livro) public {
        uint32 id = getNextId();
        livros[id] = livro;
        contador++;
    }

    function getLivro(uint32 id) public view returns (Livro memory) {
        return livros[id];
    }

    function editLivro(uint32 id, Livro memory livroNovo) public {
        Livro memory livroExistente = livros[id];
        if (bytes(livroNovo.titulo).length != 0 && !compareStrings(livroExistente.titulo, livroNovo.titulo)) {
            livroExistente.titulo = livroNovo.titulo;
        }
        if (bytes(livroNovo.autor).length != 0 && !compareStrings(livroExistente.autor, livroNovo.autor)) {
            livroExistente.autor = livroNovo.autor;
        }
        if (livroNovo.ano != 0 && livroExistente.ano != livroNovo.ano) {
            livroExistente.ano = livroNovo.ano;
        }
        livros[id] = livroExistente;
    }

    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }

    function removeLivro(uint32 id) public {
        require (msg.sender == owner, "This guy is not the owner");
        Livro memory livroExistente = livros[id];
        if (bytes(livroExistente.titulo).length > 0) {
            delete livros[id];
            contador--;
        }
    }
}