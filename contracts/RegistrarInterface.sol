pragma solidity ^0.5.0;

interface RegistrarInterface {

    event Registration(string name, address owner, address addr);

    function register(string calldata name, address owner, bytes calldata signature) external;
    function hash(string calldata name, address owner) external pure returns (bytes32);
}
