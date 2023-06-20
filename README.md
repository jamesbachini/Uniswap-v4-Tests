# Uniswap v4 Tests

A Uniswap v4 hook which creates an afterSwap hook to check if price is above or below 1:1 for a stable pair. After a swap takes place if price is below 1:1 it will rebalance the pool either by adding liquidity or making a swap.

Test in foundry (recommend using WSL or a unix based OS)
```
curl -L https://foundry.paradigm.xyz | bash
source /home/james/.bashrc
foundryup
forge install https://github.com/Uniswap/v4-core --no-commit
forge install openzeppelin/openzeppelin-contracts --no-commit
forge install marktoda/forge-gas-snapshot --no-commit
forge test
```

More info on Uniswap v4 hooks at https://jamesbachini.com/uniswap-v4-hooks/
