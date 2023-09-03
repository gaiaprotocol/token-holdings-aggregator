// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenHoldingsAggregator {
    function getERC20BalanceList_OneHolder(
        address holder,
        address[] calldata
    ) external view returns (uint256[] memory balances) {
        return _balanceList_OneHolder(holder);
    }

    function _balanceList_OneHolder(address holder) internal view returns (uint256[] memory balances) {
        bytes4 selector = 0x70a08231;
        /// @solidity memory-safe-assembly
        assembly {
            let len := calldataload(68)
            balances := mload(0x40)
            mstore(balances, len)
            let totalbytes := mul(len, 0x20)
            mstore(0x40, add(add(balances, 0x20), totalbytes))
            let end := add(totalbytes, 0x20)

            // prettier-ignore
            for { let i := 0x20 } lt(i, end) { i := add(i, 0x20) } {
                mstore(0, selector)
                mstore(4, holder)

                if staticcall(gas(), calldataload(add(0x44, i)), 0, 0x24, 0, 0x20) {
                    mstore(add(balances, i), mload(0))
                }
            }
        }
    }
}
