// Copyright 2019 OpenST Ltd.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ----------------------------------------------------------------------------
//
// http://www.simpletoken.org/
//
// ----------------------------------------------------------------------------

const Anchor = artifacts.require('./Anchor.sol');
const BN = require('bn.js');
const web3 = require('../../test_lib/web3.js');

contract('Anchor.getRemoteChainId()', (accounts) => {
  let remoteChainId;
  let blockHeight;
  let stateRoot;
  let maxNumberOfStateRoots;
  let organization;
  let anchor;

  beforeEach(async () => {
    remoteChainId = new BN(1410);
    blockHeight = new BN(5);
    stateRoot = web3.utils.sha3('dummy_state_root');
    maxNumberOfStateRoots = new BN(10);
    organization = accounts[1];

    anchor = await Anchor.new(
      remoteChainId,
      blockHeight,
      stateRoot,
      maxNumberOfStateRoots,
      organization,
    );
  });

  it('should return correct remote chain id', async () => {
    const chainId = await anchor.getRemoteChainId.call();
    assert.strictEqual(
      remoteChainId.eq(chainId),
      true,
      `Remote chain id from the contract must be ${remoteChainId}.`,
    );
  });
});
