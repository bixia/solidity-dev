//SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "ds-test/test.sol";
import "forge-std/Vm.sol";

import "../SolidityDev.sol";
contract DevTest is DSTest {
    Dev public dev;
    Vm public vm = Vm(HEVM_ADDRESS);

    function setUp() public {
        dev = new Dev{value: 10 ether}();
        vm.label(address(dev), "dev");
    }
    function testFail_setKey() public {
        vm.expectRevert();
        dev.setKey(10);
    }
    function test_setKeyPrankOwner(uint256 _key) public {
        address owner = dev.owner();
        vm.startPrank(owner);
        dev.setKey(_key);
        vm.stopPrank();
    }
    function test_setKeyPrankOwner() public {
        address owner = dev.owner();
        vm.startPrank(owner);
        dev.setKey(10);
        vm.stopPrank();
    }
    
    function test_getOwner() public {
        assertEq(dev.owner(),address(0xdeadbeef));
    }
    function test_hack() public payable {
        uint256 balanceBefore = address(this).balance;
        dev.hack(32);
        assertEq(address(this).balance - balanceBefore, 10 ether);
    }
    receive() external payable{}
}