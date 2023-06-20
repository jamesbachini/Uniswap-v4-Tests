// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Hooks} from "@uniswap/v4-core/contracts/libraries/Hooks.sol";
import {BaseHook} from "v4-periphery/BaseHook.sol";

import {IPoolManager} from "@uniswap/v4-core/contracts/interfaces/IPoolManager.sol";
import {BalanceDelta} from "@uniswap/v4-core/contracts/types/BalanceDelta.sol";
import {PoolId} from "@uniswap/v4-core/contracts/libraries/PoolId.sol";

contract TestHook is BaseHook {
    using PoolId for IPoolManager.PoolKey;
    uint256 public swapCount;

    constructor(IPoolManager _poolManager) BaseHook(_poolManager) {}

    function getHooksCalls() public pure override returns (Hooks.Calls memory) {
        return Hooks.Calls({
            beforeInitialize: false,
            afterInitialize: false,
            beforeModifyPosition: false,
            afterModifyPosition: false,
            beforeSwap: false,
            afterSwap: true,
            beforeDonate: false,
            afterDonate: false
        });
    }

    function afterSwap(
        address,
        IPoolManager.PoolKey memory key,
        IPoolManager.SwapParams calldata params,
        BalanceDelta
    )
        external
        override
        returns (bytes4)
    {
        swapCount++;
        bytes32 poolId = key.toId();
        (uint160 sqrtPriceX96, int24 tick, , , ,
            // uint8 protocolSwapFee,
            // uint8 protocolWithdrawFee,
            // uint8 hookSwapFee,
            // uint8 hookWithdrawFee
        ) = poolManager.getSlot0(poolId);
        uint160 oneToOne = 79228162514264337593543950336; // ~ 1:1
        if (sqrtPriceX96 < oneToOne) {
            // Price has diverged from baseAsset value
            int24 compressed = tick / key.tickSpacing;
            if (tick < 0 && tick % key.tickSpacing != 0) compressed--;
            int24 tickLower = compressed * key.tickSpacing;
            // rebalance pool
        }
        return BaseHook.afterSwap.selector;
    }
}
