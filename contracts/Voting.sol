// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {

    struct Voter {
        uint8 weight; // 'weight' is accumulated by delegation.
        bool voted; // 'voted' if true, means that person has already voted.
        address delegate; // 'delegate' means the person delegated to
        uint256 vote; // 'index' of the voted proposal
    }

    struct Proposal {
        bytes32 name; // short name (up to 32 bytes)
        uint256 voteCount; // number of accumulated votes
    }

    address immutable chairperson;

    mapping(address => Voter) public voters;
    mapping(address => bool) public voterStatus;

    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function giveRightVote(address voter) external {
        require(msg.sender == chairperson, "Only chairperson can give right to vote.");
        require(!voters[voter].voted, "The voter already voted.");
        require(voters[voter].weight == 0, "The voter's weight must be 0");
        require(!voterStatus[voter], "The voter status must not be true.");

        voters[voter].weight = 1;
        voterStatus[voter] = true;
    }

    


}