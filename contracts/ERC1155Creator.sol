//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC1155Creator is ERC1155, Ownable {
    address public Usage;
    string private _uri;
    uint256 private id;

    /*     mapping (address => UserIds) private userToId;

    struct UserIds {
        uint256[] Ids;
    } */

    constructor() ERC1155("") {}

    function generateNFTs(uint256 _amount)
        external
        returns (uint256 _idGenerated)
    {
        _mint(msg.sender, id, _amount, "");
        _idGenerated = id;
        id++;
        return _idGenerated;
    }

    function uri(uint256) public view override returns (string memory) {
        return _uri;
    }

    function setUri(string calldata __uri) external onlyOwner {
        _uri = __uri;
    }

    function burnFrom(address _account, uint256 _id) external {
        require(msg.sender == Usage, "Usage only");
        _burn(_account, _id, 1);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _id,
        uint256 _amount,
        bytes memory _data
    ) external {
        _safeTransferFrom(_from, _to, _id, _amount, _data);
    }

    function setAddresses(address _Usage) external onlyOwner {
        Usage = _Usage;
    }
}
