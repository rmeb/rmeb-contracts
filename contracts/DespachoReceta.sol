pragma solidity 0.4.21;

import "./AllowanceRegistryInterface.sol";
import "./RestrictedRegistryInterface.sol";

contract DespachoReceta {
    
    //Version del contrato
    uint256 public version = 1;
    
    //Registro de farmacos restringidos
    RestrictedRegistryInterface public registroControlados;
    
    //Registro de despachadores 
    AllowanceRegistryInterface public registroDespachadores;

    //Cantidad de farmaco recetado. CodigoFarmaco => Cantidad recetada
    mapping (bytes32 => uint256) public recetado;
    
    //Cantidad de farmaco despachado. CodigoFarmaco => Cantidad despachada
    mapping (bytes32 => uint256) public despachado;
    
    
    //Constructor.
    function DespachoReceta(
        bytes32[] _codigoFarmaco, 
        uint256[] _cantidadRecetada,
        RestrictedRegistryInterface _registroControlados,
        AllowanceRegistryInterface _registroDespachadores
        ) public {
            
        for(uint256 i;i<_codigoFarmaco.length;i++) {
            recetado[_codigoFarmaco[i]] = _cantidadRecetada[i];
        }
        
        registroControlados = _registroControlados;
        registroDespachadores = _registroDespachadores;
    }
    
    //["0x1","0x2"],[1,1],"0x789142640746970fe5569e754bc0fdb5e43b7c4f","0xb0d99cee37caac92d8aa15df69fa687f730cd04d"

    //Despachar 
    function despachar(
        bytes32 _codigoFarmaco, 
        uint256 _cantidadDespachada, 
        uint256 _precioLista, 
        uint256 _precioFinal
        ) public {
        
        //Se requiere que el despachador este registrado 
        require(registroDespachadores.isAllowed(msg.sender));
        
        //Se require que la cantidad despachada no sea mayor a la cantidad recetada.
        //Solo si el farmaco es controlado.
        if(registroControlados.isRestricted(_codigoFarmaco)){
            require(recetado[_codigoFarmaco] > despachado[_codigoFarmaco]);
        }
        
        //Guardar cantidad despachada
        despachado[_codigoFarmaco] += _cantidadDespachada;
        
        //Emitir evento Despachado
        emit Despachado (
            msg.sender, 
            _codigoFarmaco, 
            _cantidadDespachada,
            _precioLista,
            _precioFinal
            );
        
    }
    
    event Despachado (
        address _despachador, 
        bytes32 _codigoFarmaco, 
        uint256 _cantidadDespachada, 
        uint256 _precioLista, 
        uint256 _precioFinal
    );
     
    
}
