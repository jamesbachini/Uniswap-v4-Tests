// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {TestHook} from "../TestHook.sol";

import {BaseHook} from "v4-periphery/BaseHook.sol";
import {IPoolManager} from "@uniswap/v4-core/contracts/interfaces/IPoolManager.sol";
import {Hooks} from "@uniswap/v4-core/contracts/libraries/Hooks.sol";

contract TestImplementation is TestHook {
    constructor(IPoolManager poolManager, TestHook addressToEtch) TestHook(poolManager) {
        Hooks.validateHookAddress(addressToEtch, getHooksCalls());
    }

    // make this a no-op in testing
    function validateHookAddress(BaseHook _this) internal pure override {}
}
