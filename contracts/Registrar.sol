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

    function register(bytes32 name, address owner, bytes signature) external {
        
    }
}
