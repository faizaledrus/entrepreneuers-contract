// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";

contract Entrepreneurs is ERC721AUpgradeable, PausableUpgradeable, OwnableUpgradeable {

	uint public price;
	uint public maxSupply;
	uint public maxMinting;
	
    // Take note of the initializer modifiers.
    // - `initializerERC721A` for `ERC721AUpgradeable`.
    // - `initializer` for OpenZeppelin's `OwnableUpgradeable`.
    function initialize() initializerERC721A initializer public {
        __ERC721A_init('Entrepreneurs', 'ENTR');
        __Ownable_init();
    }

    function mint(uint256 quantity) external payable {
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        require(totalSupply()<=maxSupply , "Minting Ends");
		require(quantity <= maxMinting , "Minting need to be less then 3");
		require(_numberMinted(msg.sender) + quantity <= maxMinting, "Each address are only limited to 3 minting");
		_mint(msg.sender, quantity);
    }

    function adminMint(uint256 quantity) external payable onlyOwner {
        _mint(msg.sender, quantity);
    }

	function setPrice(uint _setPrice) public onlyOwner{
		  price=_setPrice;
	  }

	  function setMaxSupply(uint _setMaxSupply)public onlyOwner{
		  maxSupply = _setMaxSupply;
	  }

	  function setMaxMinting(uint _setMaxMinting)public onlyOwner{
		  maxMinting= _setMaxMinting;
	  }

	  function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

	function withdraw() public onlyOwner  {
    	payable(owner()).transfer(address(this).balance);
  }
}