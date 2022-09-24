// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;

///@notice:In this Program we study how Hacker can perform a Denial of Service attack on our Contracts by Blocking our Contracts to
/// recieve ether
/**
 
 */

contract KingOfEther{
    address public king;
    uint public balance;
    mapping(address => uint) balances;

    function claimThrone() external payable{
        require(msg.value > balance,"You need to invest more to become a King");

        balances[king]+=balance;
        // (bool sent,) = king.call{amount : balance} // We exclude this line because it will trigger the fallback function by the Attacker 
        balance = msg.value;
        king=msg.sender;
    }

    function withdraw() public{
        require(msg.sender !=king ,"The King cannot withdraw funds");
        uint amount = balances[msg.sender];
        balances[msg.sender]=0;

        (bool sent,)=msg.sender.call{value:amount}("");
        require(sent,"failed to send Ether");    
    }
}

contract Attack{
    function attack(KingOfEther kingofEther)public payable{
        kingofEther.claimThrone(value:msg.value);       // since there is no fallback funtion so this line will cause DoS
    }
}