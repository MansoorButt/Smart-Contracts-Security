pragma solidity ^0.6.10 ;
/*Reentrancy
- What is Reentrancy ? // 
* It is a technique where the attacker continuously tries to call a function and
steal ethers by exploiting the fallback function !
-Preventative techniques 
  -Change the state of the variable before allowing the msg.sender to withdraw amount
  - Introduce a Lock System , to prevent Reentrance till a single process is not over
  */
contract EtherStore {
    mapping ( address => uint ) public balances ;
    function deposit() public payable { 
        balances [msg.sender] += msg.value ; // 
   }
   
    bool internal locked; // A boolean lock to enforce locking system
    modifier noReentrant(){
        require (!locked ,"No re-entrancy"); // statement checks if the function is not locked
        locked true; // system gets locked 
        _; // This line ensures execution of the main funtion
        Locked false ; // The system is unlocked after the execution of function
     }

    function withdraw ( uint amount ) public noReentrant{
        require ( balances [ msg.sender ] > _amount ) ;
        balances [ msg.sender ] -= _amount ; // As a preventive measure state of this variable must change before any transaction and always precede before transaction
        ( bool sent , ) msg.sender.call ( value : amount } ( " " ) ;// fallback function
        require (sent, " Failed to send Ether " ) ; 
        
   }
    function getBalance( ) public view returns ( uint ) {
        return address(this).balance ;
   }
  }

contract Attack {
   EtherStore public etherStore ;
              I
    constructor (address _etherStoreAddress) public (
        etherStore = EtherStore(_etherStoreAddress) ;
   }
    fallback() external payable (
        if (address(etherStore).balance >= 1 ether ) {
            etherStore.withdraw ( 1 ether ) ; // This is where the attacker exploits the withdraw function
   }
    function attack() external payable {
        require ( msg.value > = 1 ether ) ;
        etherStore.deposit ( value : 1 ether ) ( ) ;
        etherStore.withdraw ( 1 ether ) ; 
        }

    function getBalance ( ) public view returns ( uint ) {
        return address (this).balance ; 
        }
   }

