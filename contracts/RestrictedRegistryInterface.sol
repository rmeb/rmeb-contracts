pragma solidity 0.4.21;


contract RestrictedRegistryInterface {
    function isRestricted(bytes32 _codigoFarmaco) public view returns(bool _isRestricted);
}
