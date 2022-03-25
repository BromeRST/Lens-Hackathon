//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {IERC1155} from "./interfaces/IERC1155.sol";

contract Usage is Initializable, Ownable {
    address ERC1155CreatorAddress;

    function useNFT(uint256 _id) external virtual {
        IERC1155 mine = IERC1155(ERC1155CreatorAddress);
        mine.burnFrom(msg.sender, _id);
    }
    
    function setAddress(address _ERC1155CreatorAddress) external onlyOwner {
        ERC1155CreatorAddress = _ERC1155CreatorAddress;
    }
}
