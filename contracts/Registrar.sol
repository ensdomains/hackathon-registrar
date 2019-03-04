pragma solidity ^0.5.0;

import "./RegistrarInterface.sol";
import "./Libraries/SignatureValidator.sol";
import "@ensdomains/ens/contracts/ENS.sol";

contract Registrar is RegistrarInterface {

    ENS public ens;
    bytes32 public node;

    constructor(ENS _ens, bytes32 _node) public {
        ens = _ens;
        node = _node;
    }

    function register(string calldata name, address owner, bytes calldata signature) external {
        address token = SignatureValidator.recover(hash(name, owner), signature);
        ens.setSubnodeOwner(node, keccak256(name));
        emit Registration(keccak256(name), owner, token);
    }

    function hash(string memory name, address owner) public returns (bytes32) {
        return keccak256(abi.encodePacked(name, owner));
    }
}
