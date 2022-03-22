//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IERC1155 {
    function burnFrom(address _account, uint256 _id) external;

    function transferFrom(
        address _from,
        address _to,
        uint256 _id,
        uint256 _amount,
        bytes memory _data
    ) external;
}