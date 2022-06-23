// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";

contract EntrepreneursV3 is ERC721AUpgradeable, PausableUpgradeable, OwnableUpgradeable {

	uint public price;
	uint public maxSupply;
	uint public maxMinting;
	uint256 public mintPrice; //0.08 ETH

    function initialize() initializerERC721A initializer public {
        __ERC721A_init('Entrepreneurs', 'ENTR');
        __Ownable_init();
    }

    function mint(uint256 quantity) external payable {
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        require(totalSupply()<=maxSupply , "Minting Ends");
		require(quantity <= maxMinting , "Minting need to be less then 3");
		// require(_numberMinted(msg.sender) + quantity <= maxMinting, "Each address are only limited to 3 minting");
		uint userMinted = _numberMinted(msg.sender);

		if(userMinted>=3){
		//pay if user has 3 free mints
		require(mintPrice * quantity >= msg.value, "Ether value sent is not correct");
		_mint(msg.sender, quantity);
		} 
		else{
		//free if user has not minted yet
		_mint(msg.sender, quantity);
		}
    }

    function adminMint(uint256 quantity) external payable onlyOwner {
        _mint(msg.sender, quantity);
    }

	function setMintPrice(uint256 _price) public onlyOwner{
		mintPrice = _price; //1000000000000000
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