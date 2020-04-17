pragma solidity ^0.5.10;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Metadata.sol";

contract MyNFT is ERC721, ERC721Metadata {

    uint tokenIdEnumerator;

    uint public threshold; //currently not used...
    uint public signals;

    address public owner;
    address[] public recipients;

    bool public batchMinted;

    mapping (address => bool) public didSignal;

    constructor(uint _threshold) ERC721Metadata("DevRelToken", "DRT") public {
        owner = msg.sender;
        threshold = _threshold;
    }

    function signal() public {
        if (!didSignal[msg.sender]) {
            didSignal[msg.sender] = true;
            recipients.push(msg.sender);
            signals++;
            emit SignalSent(msg.sender);
        }
    }

    function batchMint() public {
        require(!batchMinted, "batchMint already called");
        require(owner==msg.sender, "only owner"); //comment out and uncomment line below to toggle gate on function
        //  require(signals >= threshold, "threshold not reached");
        for (uint i = 0; i < recipients.length; i++) {
            //mint token for recipients[i]
            _safeMint(recipients[i], tokenIdEnumerator);
            tokenIdEnumerator++;
        }
        batchMinted = true;
    }

    event SignalSent(address sender);
}