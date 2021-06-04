pragma solidity >=0.4.21 <0.6.0;

import "./verifier.sol";
import "./ERC721Mintable.sol";



// TODO define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is CustomERC721Token{

    // TODO define a solutions struct that can hold an index & an address
    struct Solution{
        address to;
        uint tokenId;
    }

    // TODO define an array of the above struct
    Solution[] solutions; 

    // TODO define a mapping to store unique solutions submitted
    mapping (bytes32 => Solution) private _uniqueSolutions;

    Verifier public squareVerifier;

    // TODO Create an event to emit when a solution is added
    event SolutionAdded(address to, uint tokenId);

    constructor(address verifierAddr) public{
        squareVerifier = Verifier(verifierAddr);
    }

    // TODO Create a function to add the solutions to the array and emit the event
    function addSolution (address to, uint tokenId, bytes32 key) public {

        Solution memory solution = Solution({
            to:to,
            tokenId:tokenId
        });

        solutions.push(solution);
        _uniqueSolutions[key] = solution;

        emit SolutionAdded(to,tokenId);
    }

    // TODO Create a function to mint new NFT only after the solution has been verified
    //  - make sure the solution is unique (has not been used before)
    //  - make sure you handle metadata as well as tokenSuplly

    function mintNFT(
        address to, 
        uint tokenId, 
        uint[2] memory a, 
        uint[2][2] memory b, 
        uint[2] memory c,
        uint[2] memory input)
        public returns (bool){

            bytes32 key = keccak256(abi.encodePacked(a,b, c, input));

            require(_uniqueSolutions[key].to == address(0), "Solution already added");
            require(squareVerifier.verifyTx(a,b,c,input), "Solution not verified");

            addSolution(to, tokenId, key);

            return super.mint(to,tokenId);
        }

}









  


























