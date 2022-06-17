
// SPDX-License-Identifier: MIT
// An example of a consumer contract that relies on a subscription for funding.
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Giveaway is VRFConsumerBaseV2 {
    address [] public addresses = [
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,
        0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,
        0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,
        0x617F2E2fD72FD9D5503197092aC168c91465E7f2,
        0x17F6AD8Ef982297579C203069C1DbfFE4348c372,
        0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678,
        0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7,
        0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C,
        0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC,
        0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c,
        0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C,
        0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB,
        0x583031D1113aD414F02576BD6afaBfb302140225,
        0xdD870fA1b7C4700F2BD7f44238821C26f7392148,
        0xEc0359Dc2DF0a3deec0e19DA22fa1071C748BA8F,
        0xcD8fBD45e94c25a81ade464f106DEA578ca5fEf6,
        0x06b0A2C6beeA3fd215D47324DD49E1ee3a4a9F25,
        0x5ceAc6B3d26E0957C8A809E31d596C16e5780d96,
        0xC9D0669819a69A57DA6eD63190C83EC7508Df92a,
        0xd51b0f0D0B337F901c5cd1aD532f9E8239Dfc4E5,
        0x03514AA2d3972fb6C761Ad6Bc29427fD1Dc04b08,
        0x9FF19261eCB6b64A41530E2eFdaA8F0C40d5D270,
        0x2501bfBfa36Bb7BaD84562474Ea759d016648043,
        0x367F997201787fd6cF2Db7BA4F2DFF0d367a4BcD,
        0x6361EA2630f48f26485Ff57b894E60706DC8bBE1,
        0x1608fB23B4567186E9D78B1312F3b56d491ED009,
        0x2fceD0D1A196D137E1d25e6858B20719760E0454,
        0x220091e96a7541c06DFeaef45a5a511C15eC20D0,
        0xba6BF01AB8b0FB64D44a2254ff73b4F2E841ceAa,
        0x31F2dEf6950469084E50b14bC1ec909C7b04634B,
        0x56899E31704584Ad7AD211215F67555967532e21,
        0x723d4e9A912213037829e0228EF816Fd9599836D,
        0x7f9dAab7bEFC019203E59df67D47989005fE6142,
        0x6b91528D2120610D34fD1F603829B1815fdfF90C,
        0x060c8C3e672f85c9cA86d7c3d15c27730b7A6E87,
        0x9f78dbeB30cFfB8F35FA8C064BE5D80ED0ff3C6E,
        0x315563c3fD77FC9228Dfa01fc2537510B945bBd9,
        0x34fFe76147AA78FaC04361E66F81dc0Fc5A4076D,
        0x0853978554E8871520368F205CB05C7CeC0F6199,
        0x863A2eca2D0f1b716f126B8bDD4255b3d7250B9e,
        0xF883aAf6B75B705e2773805C658f8abEdB17F25d,
        0xFc94a1F0E89E67faF21892A1d19F4A6b5001ADE1,
        0x4e8A511f117C80B97db153Fd0AdF77986078e175,
        0x40E120f7Fc8E6759bF9D84aFc0c553ad4E2165DA,
        0xE66eb3fA5E0e9df2AB72b53B121Dd11927e6C86f,
        0xDa0402Ae38ec0A808134CC990B6bD28C1f64aAa8,
        0xE651afD30BE9e6A0Bcf8Aa12B7C0c8254f5fa9ED,
        0x08f036f7B5f590CE4C0A2c8e56ae5F7EE9159FA9,
        0xAdeFDf2EF8B91d6b634F2B46fAc31B337841b234,
        0xc933537C0c3c289b57A2f7735e73EF719c7f29Cf,
        0x9e1D61Adbb5CB40ba93a320A18d2BD99606cf64e,
        0x23E58B69e51Bb5efbA00F62675c7e3E8bb6C604A,
        0x90D9F88B901Cf0b282bafAACbCCa9BE09D3cee69,
        0x6632ceE3d1dcF86185C2737Bf5C301A628623A14,
        0xB6869b9353CD2e32CE7e43b844A7e067c1C5a395,
        0xc12D5DB2343CFE6926DAdFAd46B1Fbd1810cF0c3,
        0xa0996Ef53891B4e960030885f13794C7F4707CbF,
        0x47f15107774f6184B941fCe8D8a7Edb437a48C34,
        0xAf98A64f10cdbFec843951B701Da01aA15c7c29E,
        0xF231AFDf1A94960A3217f29e09d17fd80D5e875E,
        0xe2Fd1d2678Dce9f3786BCB5ad12851813353d8fb,
        0x29BA5576134f5CF66aF0eDC3b85f614987DE4aA9,
        0x749E7337B8bDDf1E6166F4EAdC7Cd35efF451E6d,
        0x3201C9588fFa881d1C2837aaAD0943935C87177D,
        0x35ceaC4A99077cE20f28152C241378e8a189EA51,
        0x6EfFAeB886EAe3B9287a240C6E461bd3d4A7CF4a,
        0x77A31129A2e4DDc35D94f617AfDCf13d471DF31b,
        0x59e33542b047b625d9fD65D8A04cA12129288cBd,
        0xD5DEB1a2d6EF28fd32c0d302F2F4F529c117fe1C,
        0xaae4aF8D508D82b1E41c7296544097BFD5B27e6f,
        0xDb88916e9AB795dDEF89A8d275Ad1a01185a216A,
        0x0d5636Bc420C364F50bec2518f06E204898C64db,
        0xBF18278Fa7080c9c692B76c64A2fB1cc93Eb1384,
        0xE6DC280499Ca52917E39c0d3C9528dEa0DD9902b,
        0x1eFF652cea78eF077d802B0660b15452796Fe289,
        0x53353cfF084c132DA63598630D26B4dBA4FEE901,
        0x997559133d6382c0C376fC295C52e5ee6A213d65,
        0xC1F35594353609c6532e7754Bb5b5Beb3437fDAc,
        0x732ee1c577d1F106E7BA4D0e910097d22f2ba3ce,
        0x8B65795B6ca02bB1425C7C340120b6b742DF279a,
        0xF5A2E949831f09fd4152892B2a36A4345508d56e,
        0x707CCB8E5b1436eDe47f012Bd864bC2a21aCf71B,
        0xbf73a502c031f5E6d159cd4c6bc9142739f193d8,
        0x998C12F65F9C2df92876102B6f964a2A9AD942b7,
        0xF993D5474Cd607e26B57E1dE1556bee36De2D0e9,
        0x28dd3d836D21a54Bb0fc558724F04f702dEef718,
        0x03eA724d9A321081B2a7442b31Efb3A86dB9006D,
        0xD2387c99229dA12b90C1a12F89094F1622fab3c3,
        0xfA282a965DA97F9aE1805e28C6d0574cB2A8C231,
        0x9CFDEA28bBB3ED105a0ebBfD05275C67c145116e,
        0x279d65DFd9f4765076Cc0525A78B6178BC15c5C2,
        0x1DAeca3fe82888a02B3d4193d1F0787D4ee091A2,
        0x192C213987aB508A59E003EAa2Cb6D0D6d79d32b,
        0xd597FcAAEFE287F5eD2CA90C95bF545fE56A56c6,
        0x278207B1Ce7741F1C316e16FA7F8e16687Ff1254,
        0x3865c63b989FfD50F8a6775B70e3Ca83c42A2BE3,
        0x3131e8D3846613F9071a72123c581153dB3F1B99,
        0x58E15eB3083fa7B28149Fb455DB0a476bcfD7752
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
    address vrfCoordinator = 0x6168499c0cFfCaCD319c818142124B7A15E857ab;

    // The gas lane to use, which specifies the maximum gas price to bump to.
    // For a list of available gas lanes on each network,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    bytes32 keyHash = 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;

    // Depends on the number of requested values that you want sent to the
    // fulfillRandomWords() function. Storing each word costs about 20,000 gas,
    // so 100,000 is a safe default for this example contract. Test and adjust
    // this limit based on the network that you select, the size of the request,
    // and the processing of the callback request in the fulfillRandomWords()
    // function.
    uint32 callbackGasLimit = 100000;

    // The default is 3, but you can set this higher.
    uint16 requestConfirmations = 3;

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
