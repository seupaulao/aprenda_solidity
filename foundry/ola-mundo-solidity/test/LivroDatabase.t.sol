// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {LivroDatabase} from "../src/LivroDatabase.sol";

contract LivroDatabaseTest is Test {
    LivroDatabase public livroDatabase;
    address public usuario1 = address(0x123);
    address public usuario2 = address(0x456);
    address public proprietario = address(0x789);

    function setUp() public {
        vm.startPrank(proprietario);
        livroDatabase = new LivroDatabase();
        vm.stopPrank();
    }

    function testAddLivro() public {
        LivroDatabase.Livro memory livro = LivroDatabase.Livro({
            titulo: "O Alquimista",
            autor: "Paulo Coelho",
            ano: 1988
        });
        livroDatabase.addLivro(livro);
        assertEq(livroDatabase.contador(), 1);
    }

    function testGetLivro() public {
        LivroDatabase.Livro memory livro = LivroDatabase.Livro({
            titulo: "O Alquimista",
            autor: "Paulo Coelho",
            ano: 1988
        });
        LivroDatabase.Livro memory livro2 = LivroDatabase.Livro({
            titulo: "Brida",
            autor: "Paulo Coelho",
            ano: 1990
        });
        livroDatabase.addLivro(livro);
        livroDatabase.addLivro(livro2);
        LivroDatabase.Livro memory retrievedLivro = livroDatabase.getLivro(0);
        assertEq(retrievedLivro.titulo, "O Alquimista");
        assertEq(retrievedLivro.autor, "Paulo Coelho");
        assertEq(retrievedLivro.ano, 1988);
        string memory atualTitulo = livroDatabase.getLivro(1).titulo;
        assertEq(atualTitulo, "Brida");
        LivroDatabase.Livro memory retrievedLivro2 = livroDatabase.getLivro(1);
        assertEq(retrievedLivro2.titulo, "Brida");
        assertEq(retrievedLivro2.autor, "Paulo Coelho");
        assertEq(retrievedLivro2.ano, 1990);
    }

    function testEditLivro() public {
        LivroDatabase.Livro memory livro = LivroDatabase.Livro({
            titulo: "O Alquimista",
            autor: "Paulo Coelho",
            ano: 1988
        });
        livroDatabase.addLivro(livro);

        LivroDatabase.Livro memory livroNovo = LivroDatabase.Livro({
            titulo: "O Alquimista Special Edition",
            autor: "Paulo Coelho",
            ano: 1988
        });
        livroDatabase.editLivro(0, livroNovo);

        LivroDatabase.Livro memory retrievedLivro = livroDatabase.getLivro(0);
        assertEq(retrievedLivro.titulo, "O Alquimista Special Edition");
        assertEq(retrievedLivro.autor, "Paulo Coelho");
        assertEq(retrievedLivro.ano, 1988);
    }

    function testRemoveLivro() public {
        vm.startPrank(proprietario);
        LivroDatabase.Livro memory livro = LivroDatabase.Livro({
            titulo: "O Alquimista",
            autor: "Paulo Coelho",
            ano: 1988
        });
        livroDatabase.addLivro(livro);
        assertEq(livroDatabase.contador(), 1);

        livroDatabase.removeLivro(0);
        assertEq(livroDatabase.contador(), 0);
        vm.stopPrank();
    }
}