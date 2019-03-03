pragma solidity ^0.5.0;

interface RegistrarInterface {

    event Registration(bytes32 indexed name, address owner, address addr);

    function register(string name, address owner, bytes signature) external;
    function hash(string name, address owner) public returns (bytes32);
}
