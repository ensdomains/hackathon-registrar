pragma solidity ^0.5.0;

interface RegistrarInterface {

    event Registration(bytes32 indexed name, address owner, address addr);

    function register(string calldata name, address owner, bytes calldata signature) external;
    function hash(string memory name, address owner) public returns (bytes32);
}
