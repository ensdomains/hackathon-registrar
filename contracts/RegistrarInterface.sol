pragma solidity ^0.4.0;

interface RegistrarInterface {

    event Registration(bytes32 indexed name, address owner, address addr);

    function register(bytes32 name, address owner, bytes signature);
}
