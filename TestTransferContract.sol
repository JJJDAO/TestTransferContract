// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;



contract TestTransfer {
    address payable private owner;
    mapping(address => uint) private balances;
    event LogDeposit(address addr, uint value);
    event LogWithdrawal(address addr, uint value);
    constructor() payable {
        owner = payable(address(this));
    }
    
    receive() payable external {}
    
    function deposit() public payable {
        emit LogDeposit(msg.sender, msg.value);
        balances[msg.sender] = msg.value;
        owner.transfer(msg.value);
    }
    
    function getDepositAmount() public view returns (uint) {
        uint myBalance = balances[msg.sender];
        return myBalance;
    }
    
    function getHoldings() public view returns (uint) {
        return address(owner).balance;
    }
    
    function withdraw() public {
        
        uint value = balances[msg.sender];
        require(value > 0, "Balance insufficient")
        emit LogWithdrawal(msg.sender, value);
        payable(msg.sender).transfer(value);
    }
}