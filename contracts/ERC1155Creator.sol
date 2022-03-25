//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC1155Creator is ERC1155, Ownable {
    address public Usage;
    uint256 private id;
    mapping (uint256 => uint256) idToTimestamp;
    mapping (uint256 => uint256) idToNFTminted;
    mapping (uint256 => uint256) idToCap;
    mapping (uint256 => string) idToUri;
    
    event IDCreated (uint256 _id);

    constructor() ERC1155("") {}

    function mint(uint256 _id) external {
        require(block.timestamp <= idToTimestamp[_id], "minting expired");
        require(balanceOf(msg.sender, _id) == 0, "already minted");
        require(idToNFTminted[_id] < idToCap[_id], "all supply have been minted");
        _mint(msg.sender, _id, 1, "");
        idToNFTminted[_id]++;
    }

    function uri(uint256 _id) public view override returns (string memory) {
        return idToUri[_id];
    }

    function burnFrom(address _account, uint256 _id) external {
        require(msg.sender == Usage, "Usage only");
        _burn(_account, _id, 1);
    }

    function setAddresses(address _Usage) external onlyOwner {
        Usage = _Usage;
    }

    function generateNFT(uint256 _expiringTimeInDays, uint256 _cap, string calldata _uri) external {
        uint256 _idGenerated = id;
        require(bytes(idToUri[_idGenerated]).length == 0, "cannot set URI twice");
        id++;
        idToTimestamp[_idGenerated] = block.timestamp + _expiringTimeInDays;
        idToCap[_idGenerated] = _cap;
        idToUri[_idGenerated] = _uri;
        emit IDCreated(_idGenerated);
    }

    function getCountForId (uint256 _id) external view returns(uint256 _count) {
        _count = idToNFTminted[_id];
        return _count;
    }

    function getCapForId (uint256 _id) external view returns(uint256 _cap) {
        _cap = idToCap[_id];
        return _cap;
    }
}
