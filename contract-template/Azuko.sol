// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
// import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

/// @custom:security-contact info@azuko.idk
contract Azuko is Initializable, ERC721AUpgradeable, PausableUpgradeable, OwnableUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter private _tokenIdCounter;

	uint256 public price;
    uint256 public maxSupply;
    uint256 public maxMintAmountPerTx;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public {
        __ERC721_init("Azuko", "AZK");
        __Pausable_init();
        __Ownable_init();
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://azuko.idk";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

	function setMaxMintAmountPerTx(uint256 _maxMintAmountPerTx) public onlyOwner {
    	maxMintAmountPerTx = _maxMintAmountPerTx;
  	}

	  function setPrice(uint _setPrice) public onlyOwner{
		  price=_setPrice;
	  }

	  function setMax(uint _setMaxSupply)public onlyOwner{
		  maxSupply = _setMaxSupply;
	  }

	  function withdraw() public onlyOwner {
    		(bool os, ) = payable(owner()).call{value: address(this).balance}('');
    		require(os);
  		}

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}