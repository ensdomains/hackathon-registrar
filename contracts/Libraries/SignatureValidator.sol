pragma solidity ^0.5.0;

library SignatureValidator {

    /// @dev Validates that a hash was signed by a specified signer.
    /// @param hash Hash which was signed.
    /// @param signature ECDSA signature {v}{r}{s}.
    /// @return Returns whether signature is from a specified user.
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        require(signature.length == 65);

        uint8 v = uint8(signature[0]);
        bytes32 r;
        bytes32 s;
        assembly {
            r := mload(add(signature, 33))
            s := mload(add(signature, 65))
        }

        return ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash)), v, r, s);
    }
}
