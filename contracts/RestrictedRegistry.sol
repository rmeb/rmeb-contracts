pragma solidity 0.4.21;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";

import "./RestrictedRegistryInterface.sol";


contract RestrictedRegistry is RestrictedRegistryInterface, Ownable {
    
    mapping (bytes32 => bool) public restricted;
    
    function RestrictedRegistry() public 
    {}

    function setRestricted(bytes32 _codigoFarmaco, bool _restricted) public onlyOwner {
        restricted[_codigoFarmaco] = _restricted;
    }

    function isRestricted(bytes32 _codigoFarmaco) public view returns(bool _isRestricted) {
        return restricted[_codigoFarmaco];
    }


}
