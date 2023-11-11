// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
contract Lottery {
    address  manager;
    address payable [] public players;
    address payable public winner;

  constructor(){
        manager=msg.sender;
    
    }
    receive() external payable
    {   require(msg.value==1 ether,"Please pay 1 ether only");
        players.push(payable(msg.sender));
    }
    function getBalance() public view returns(uint){
        require(msg.sender==manager,"You are not the manager");
        return address(this).balance;
    }
    
 function random() internal view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

function pickWinner() public{

    require(msg.sender==manager,"You are not the manager");
    require(players.length>=3,"Players are less than 3");
    uint r=random();
    uint index=r%players.length;
    winner=players[index];
    winner.transfer(getBalance());
    players=new address payable [](0);
}
function allPlayers()public view returns(address payable[]memory){
    return players;
}
}
// 0xA969A3F56B8f8e67A4b94A1C9788E6a239d4CE0A
// ganache-0xA33BBf1Db1be93721a4F18c6785BD241d8d376dB