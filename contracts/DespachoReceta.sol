pragma solidity 0.4.21;

contract DespachoReceta {
    
    //Version del contrato
    uint256 public version = 1;
    
    //Direccion del registro de farmacos 
    address public registroControlados;
    
    //Direccion del registro de despachadores 
    address public registroDespachadores;

    //Cantidad de farmaco recetado. CodigoFarmaco => Cantidad recetada
    mapping (bytes32 => uint256) public recetado;
    
    //Cantidad de farmaco despachado. CodigoFarmaco => Cantidad despachada
    mapping (bytes32 => uint256) public despachado;
    
    
    //Constructor.
    function DespachoReceta(
        bytes32[] _codigoFarmaco, 
        uint256[] _cantidadRecetada,
        address _registroControlados,
        address _registroDespachadores
        ) public {
            
        for(uint256 i;i<_codigoFarmaco.length;i++) {
            recetado[_codigoFarmaco[i]] = _cantidadRecetada[i];
        }
        
        registroControlados = _registroControlados;
        registroDespachadores = _registroDespachadores;
    }
    
    //["0x1","0x2"],[1,1],"0xca35b7d915458ef540ade6068dfe2f44e8fa733c","0xca35b7d915458ef540ade6068dfe2f44e8fa733c"

    //Despachar 
    function despachar(
        bytes32 _codigoFarmaco, 
        uint256 _cantidadDespachada, 
        uint256 _precioLista, 
        uint256 _precioFinal
        ) public {
        
        //Se requiere que el despachador este registrado 
        //require(registroDespachadores.isAllowed(msg.sender));
        
        //Se require que la cantidad despachada no sea mayor a la cantidad recetada.
        //Ojo. Solo si el farmaco es controlado.
        require(recetado[_codigoFarmaco] > despachado[_codigoFarmaco]);
        
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
