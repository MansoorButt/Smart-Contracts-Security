// SPDX-License-Identifier: MIT

/// @title Honeypot
/// @author Mansoor Butt
/// @notice In this program we will create a trap for the hacker and try to catch it .
/// @dev We will Intentionally make our contract vulnerable to a Reentrance attack in the function withdraw() of Bank contract

pragma solidity ^0.8.13;

contract Bank{
    mapping(address => uint) public balances;
    Logger logger;

    constructor(Logger _logger){
        logger=Logger(_logger); /// @notice the _logger variable will contain the address of the Honeypot contract not of the "Logger"
    }

    function deposit() public payable{
        balances[msg.sender]+=msg.value;
        logger.log(msg.sender,msg.value,"Deposit");
    }

    function withdraw(uint _amount) public{
        require(_amount <= balances[msg.sender],"Insuffiecient Funds");

        (bool sent,)=msg.sender.call{value:_amount}(""); // This where the attacker will try to exploit the reentrance vulneribilty
        require(sent,"failed to send Ethers");
        
        balances[msg.sender] -= _amount; 
        logger.log(msg.sender,_amount,"Withdraw");
    }
}


contract Logger{ // The attacker assumes this contracts event will be emitted
    event Log(address caller , uint amount,string action);

    function log(address _caller,uint amount,string memory action) public{
        emit Log(_caller, amount, action);       
    }
}

contract Honeypot{ // This will be stored in a seprate file
    function log(address _caller,uint _amount, string memory _action) public {
        if(equal(_action, "Withdraw")){ // as soon as withdraw function is called this function will be called
            revert("It's a trap"); // at the end all the transaction of the attacker will be reverted
        }
    }

    function equal(string memory _a, string memory _b) public pure returns(bool){
        return keccak256(abi.encode(_a)) == keccak256(abi.encode(_b));
    }
}

contract Attack{
    Bank bank;

    constructor(Bank _bank){
        bank=Bank(_bank);
    }

    fallback() external payable{ // By using the fallback function attacker will exploit Reentrance
        if(address(bank).balance >= 1 ether){
            bank.withdraw(1 ether);
        }
    }


    function attack() public payable{
        bank.deposit{value:1 ether}();
        bank.withdraw(1 ether);
    }
}