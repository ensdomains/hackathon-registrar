pragma solidity ^0.5.0;

import "./RegistrarInterface.sol";
import "./Libraries/SignatureValidator.sol";
import "@ensdomains/ens/contracts/ENS.sol";
import "@ensdomains/resolver/contracts/PublicResolver.sol";

contract Registrar is RegistrarInterface {

    ENS public ens;
    bytes32 public node;
    PublicResolver public resolver;

    constructor(ENS _ens, bytes32 _node, PublicResolver _resolver) public {
        ens = _ens;
        node = _node;
        resolver = _resolver;
    }

    function register(string calldata name, address owner, bytes calldata signature) external {
        address token = SignatureValidator.recover(_hash(name, owner), signature);

        bytes32 label = keccak256(bytes(name));
        bytes32 subnode = keccak256(abi.encodePacked(node, label));

        // Create the subdomain and assign it to us.
        ens.setSubnodeOwner(node, label, this);

        // Set a resolver
        ens.setResolver(subnode, resolver);

        // Set the resolver's addr record to the new owner
        resolver.setAddr(subnode, owner);

        // Transfer ownership of the subdomain to the new owner.
        ens.setOwner(subnode, owner);

        emit Registration(keccak256(abi.encodePacked(name)), owner, token);
    }

    function hash(string calldata name, address owner) external pure returns (bytes32) {
        return _hash(name, owner);
    }

    function _hash(string memory name, address owner) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(name, owner));
    }
}
