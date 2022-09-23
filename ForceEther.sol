pragma solidity ^0.6.10;
/*
Hacking:In this program the attacker uses the Force Ether Technique and creates a deadlock between all the participants to win the game
as a result the Contract will crash .

Preventive Technique: " To prevent this , " Line 17 " needs to be commented , which means to not use "address(this).balance" explicitly 
Instead we will declare a seperate variable and update it whenever a user sends us Ether

*/
contract EtherGame {
   uint public targetAmount = 7 ether ;
   address public winner;
   uint public balance
    function deposit ( ) public payable {
        require ( msg.value == 1 ether , " You can only send 1 Ether " ) ;
   }
        //uint balance = address(this).balance ; avoid using this
        balance += msg.value;
        require ( balance < = targetAmount , "Game is over" ) ;
        if ( balance == target Amount ) {
            winner = msg.sender ;
       }
    function claimReward() public {
        require (msg.sender == winner , " Not winner ") ;
         (bool sent,) = msg.sender.call { value : address(this).balance }( " " );
        require ( sent , " Failed to send Ether " ) ;
        }
    function getBalance() public view returns ( uint ) {
        return address(this).balance ;}

}



contract Attack {
    function attack ( address payable target ) public payable {
        selfdestruct(target);
        
    }
}

