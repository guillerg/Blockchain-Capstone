var ERC721MintableComplete = artifacts.require('CustomERC721Token');

contract('TestERC721Mintable', accounts => {

    const account_owner = accounts[0];
    const account_one = accounts[1];
    const account_two = accounts[2];
    const account_three = accounts[3];
    const account_four = accounts[4];

    describe('match erc721 spec', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new({from: account_owner});

            // TODO: mint multiple tokens
            await this.contract.mint(account_one,10,{from: account_owner});
            await this.contract.mint(account_two,20,{from: account_owner});
            await this.contract.mint(account_three,30,{from: account_owner});
            await this.contract.mint(account_four,40,{from: account_owner});
        })

        it('should return total supply', async function () { 
            let totalSupply = await this.contract.totalSupply.call();
            assert.equal(totalSupply.toNumber(),4,'Total supply does not match');
        })

        it('should get token balance', async function () { 
            let tokenBalance = await this.contract.balanceOf.call(account_four, {from:account_owner});
            assert.equal(tokenBalance.toNumber(),1,"Balance of account four should be 1 token");
        })

        // token uri should be complete i.e: https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1
        it('should return token uri', async function () { 
            let tokenURI = await this.contract.tokenURI.call(10, {from:account_one});
            assert.equal(tokenURI,"https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1","URI does not match");
        })

        it('should transfer token from one owner to another', async function () { 
            
        })
    });

    describe('have ownership properties', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new({from: account_one});
        })

        it('should fail when minting when address is not contract owner', async function () { 
            
        })

        it('should return contract owner', async function () { 
            
        })

    });
})