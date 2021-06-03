pragma solidity >=0.4.21 <0.6.0;

import "./verifier.sol";
import "./ERC721Mintable.sol";



// TODO define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is CustomERC721Token{

    // TODO define a solutions struct that can hold an index & an address
    struct Solution{
        address solutionAddr;
        uint tokenID;
    }

    // TODO define an array of the above struct
    mapping(address => Solution) solutions; 

    // TODO define a mapping to store unique solutions submitted
    mapping (bytes32 => bool) solutionsAdded;

    Verifier public squareVerifier;

    // TODO Create an event to emit when a solution is added
    event SolutionAdded(address solutionAddr, uint tokenID);

    constructor(address verifierAddr) public{
        squareVerifier = Verifier(verifierAddr);
    }

    // TODO Create a function to add the solutions to the array and emit the event
    function _addSolution (address addr, uint id) internal {

        solutions[addr] = Solution({
            solutionAddr:addr,
            tokenID:id
        });

        emit SolutionAdded(addr,id);
    }

    // TODO Create a function to mint new NFT only after the solution has been verified
    //  - make sure the solution is unique (has not been used before)
    //  - make sure you handle metadata as well as tokenSuplly

    function mintToken(
        address to, 
        uint tokenId, 
        uint[2] memory a, 
        uint[2][2] memory b, 
        uint[2] memory c,
        uint[2] memory input)
        public returns (bool){

            require(squareVerifier.verifyTx(a,b,c,input), "Solution not verified");

            bytes32 hash = keccak256(abi.encodePacked(a,b, c, input));

            require(!solutionsAdded[hash], "Solution already added");

            _addSolution(to, tokenId);

            return super.mint(to,tokenId);
        }

}









  


























