// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Assignment9, SimpleContract} from "../src/Assignment9.sol";

contract Assignment9Test is Test {
    Assignment9 assignment;

    function setUp() public {
        assignment = new Assignment9();
    }

    function testFactoryPattern() public {
        assignment.createContract(42); // ✅ تمرير قيمة ابتدائية
        address deployed = assignment.deployedContracts(0);

        SimpleContract simple = SimpleContract(deployed);
        simple.setValue(42);

        uint256 value = simple.value();
        assertEq(value, 42, "Value should be 42");
    }

    function testOnlyOwnerCanCreateContract() public {
        vm.prank(address(0x1234));       // انتحال عنوان غير المالك
        vm.expectRevert();               // نتوقع revert بسبب onlyOwner
        assignment.createContract(1);    // ✅ تمرير أي قيمة عددية
    }
}
