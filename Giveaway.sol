// SPDX-License-Identifier: MIT
// An example of a consumer contract that relies on a subscription for funding.
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Giveaway is VRFConsumerBaseV2 {
    address [] public addresses = [
        0x069908bfd952b6D7dDB5B00C74cc7343854dE472,
        0x069908bfd952b6D7dDB5B00C74cc7343854dE472,
        0x08f036f7B5f590CE4C0A2c8e56ae5F7EE9159FA9,
        0x122bC8453120944faE679Ed12CD7711e26bd15A6,
        0x1489e86a45174413516fA90979b805e7e8889075,
        0x1E6Ca68C1CB81902ad0159d5eDef2c7DeccEB16d,
        0x2E6ddAa78C3Db7bEf53A65D4921A088D17B15F92,
        0x3eBa6c280F251aCA011C39eD51D68485490ED898,
        0x3EFBF8990c22844280E4314bDdD38314F5544799,
        0x3F598E9c328a98013F31BF1107cC96402f4059dE,
        0x42D254C08e62A9f74975252bC4e9b58390D77896,
        0x465243d5c26652ae1d73D72417430037B75e9BC8,
        0x4B64e0735e7CD2a782E5712CBdbEE1475be98777,
        0x4B64e0735e7CD2a782E5712CBdbEE1475be98777,
        0x64a597E7c13E47f071E2117B4F1E6Eb8eda8E20f,
        0x6811B7EB9D09d2F45DA615E5E4bC69dfA3Ab5Aa7,
        0x6eB8AA4134A6e2015ef7fCf0c9289365B7083352,
        0x8Bf00A3B9A6568030747e96F1c0A4d4D6b1f3837,
        0x96b10cc32674426De6c124A13fa1c317d8F2Bb4A,
        0x9Dc13931B51f974D8d7D85Af272B4c80E4B0E809,
        0xA8a26Ed158E7e2893640B54e2BC025d2a8e9333e,
        0xB9424c5770E37F24346f23aC6b65aDB0138fB92A,
        0xB9424c5770E37F24346f23aC6b65aDB0138fB92A,
        0xdb5A86646eE886b51CC10dA377e14E1F1a90906f,
        0xE7b9Fdd4Beb3BF9D78688582dDAEE30737e49E00,
        0xEc0359Dc2DF0a3deec0e19DA22fa1071C748BA8F,
        0xEc0359Dc2DF0a3deec0e19DA22fa1071C748BA8F,
        0xF20BFaA73bff77f4B911055798A129F10105549b,
        0xf8D3f860C4843394BaE06C11F7F0f0dA16BD688E
    ];
    mapping (uint256 => address) public games;
    address public winner;
    event Winner(
        address indexed winner,
        uint256 gameId
    );

    VRFCoordinatorV2Interface COORDINATOR;

    // Your subscription ID.
    uint64 s_subscriptionId;

    // Rinkeby coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0xc587d9053cd1118f25F645F9E08BB98c9712A4EE;

    // The gas lane to use, which specifies the maximum gas price to bump to.
    // For a list of available gas lanes on each network,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    bytes32 keyHash = 0x114f3da0a805b6a67d6e9cd2ec746f7028f1b7376365af575cfea3550dd1aa04;

    // Depends on the number of requested values that you want sent to the
    // fulfillRandomWords() function. Storing each word costs about 20,000 gas,
    // so 100,000 is a safe default for this example contract. Test and adjust
    // this limit based on the network that you select, the size of the request,
    // and the processing of the callback request in the fulfillRandomWords()
    // function.
    uint32 callbackGasLimit = 100000;

    // The default is 3, but you can set this higher.
    uint16 requestConfirmations = 20;

    // For this example, retrieve 2 random values in one request.
    // Cannot exceed VRFCoordinatorV2.MAX_NUM_WORDS.
    uint32 numRandoms =  1;

    uint256 public s_requestId;
    address s_owner;

    constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_owner = msg.sender;
        s_subscriptionId = subscriptionId;
    }

    // Assumes the subscription is funded sufficiently.
    function giveaway() external onlyOwner {
        // Will revert if subscription is not set and funded.
        s_requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numRandoms
        );
    }
    
    function fulfillRandomWords(
        uint256, /* requestId */
        uint256[] memory randomWords
    ) internal override {
        // a random number that will represent the index
        // of the winning address in the list of addresses.
        // the number is between 0 and the length of the array of addresses
        uint256 randomNumber = (randomWords[0] % addresses.length);
        winner = addresses[randomNumber];
        games[s_requestId] = addresses[randomNumber];
        emit Winner(winner, s_requestId);
    }

    modifier onlyOwner() {
        require(msg.sender == s_owner);
        _;
    }
}
