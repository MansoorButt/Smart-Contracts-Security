// SPDX-License-Identifier: MIT

/// @title Hiding Malicious Code in a contract
/// @author Mansoor Butt
/// @notice In this program we simulate , the technique an attacker can use to run malicious code by manipulating users
/// @dev in Line 21 the attacker will make the user pass the address of MaliciousCode contract as a result 
///@dev the log event of the MaliciousCode contract will be triggered

pragma solidity ^0.8.13;

contract Bar{
    event Log(string message);

    function log() public{
        emit Log("Bar was called"); // User assumes this would run ! 
    }
}

contract Foo{
    Bar bar;

    constructor(address _bar) public{ // address of MaliciousCode Contract will be passed
        bar = Bar(_bar);
    }
    function callBar() public{
        bar.log();
    }

}

//This will be running in a seperate file
contract MaliciousCode{
    event Log(string message);

    function log() public {
        emit Log("Malicious Code was called"); // this event will be emmited
    }
}