//SPDX-License-Identifier: MIT

pragma solidity 0.8.12;

contract Dev {
    address public owner;
    uint256 private key;
    constructor() payable {
        owner = address(0xdeadbeef);
        key = 32;
    }
    modifier onlyOwner() {
        require(msg.sender == owner,"!owner");
        _;
    }
    function setKey(uint256 _key) public onlyOwner {
        key = _key;
    }
    function getOwner() public view returns (address) {
        return owner;
    }
    function hack(uint256 _key) public {
        require(key == _key, "Wrong key");
        payable(address(msg.sender)).transfer(address(this).balance);
    }
    receive() external payable{}
}