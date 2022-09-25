// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// @title Transfering Ethers by using technique of Phishing
/// @author Mansoor Butt
/// @notice In this program we observe , that using the tx.origin keyword , Hackers can use Phishing Technique and Bypass the Security Checks 
/// @dev Instead of using tx.origin in Line 17 we will use the msg.sender to verify the owner


contract Wallet {
    address public owner;

    constructor()payable{
        owner=msg.sender;
    }
    function transfer(address payable _to, uint amount) public{
       // require(tx.origin == owner,"Not Owner");  
       
       require(msg.sender==owner,"Not Owner");      

        (bool sent,) = _to.call{value:amount}("");
        require(sent,"Failed to transfer Ether");
    }
}

contract Attack{
    address payable public owner;
    Wallet wallet;

    constructor(Wallet _wallet){
        wallet=_wallet;
    }

    function attack() public{
        wallet.transfer(owner,address(wallet).balance); /// @notice Here is where the Hacker transfer all of the balance from the victim to its Account
        
    }
}