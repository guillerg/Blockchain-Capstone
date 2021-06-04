let Verifier = artifacts.require('Verifier');
let SolnSquareVerifier = artifacts.require('SolnSquareVerifier');
let correctProof = require('../../zokrates/code/square/proof');


contract("TestSolnSquareVerifier", accounts => {

    beforeEach('Setup environment',async function() {
        this.verifier = await Verifier.new({from:accounts[0]});
        this.contract = await SolnSquareVerifier.new(this.verifier.address,{from:accounts[0]});

    })

    // Test if a new solution can be added for contract - SolnSquareVerifier
    it('Test new solution can be added', async function(){

        let key = web3.utils.keccak256(correctProof.proof.a,correctProof.proof.b,correctProof.proof.c,correctProof.proof.inputs);
        
        var isSolutionAdded = true;

        try{
            await this.contract.addSolution(accounts[1],777,key,{from:accounts[0]});
        }catch(e){
            isSolutionAdded = false;
        }
        assert.equal(isSolutionAdded,true,"Solution could not be added");
    })

    // Test if an ERC721 token can be minted for contract - SolnSquareVerifier
    it('Mint ERC721 token', async function(){
        
        var isTokenMinted = true;

        try{
            await this.contract.mintNFT(
                accounts[1],
                888,
                correctProof.proof.a,
                correctProof.proof.b,
                correctProof.proof.c,
                correctProof.inputs,
                {from:accounts[0]}
                );
        } catch(e){
            isTokenMinted = false;
            console.log(e);
        }

        assert.equal(isTokenMinted,true,"Token could not be minted")

    });

})


