// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9; 
contract Blems{

    address public i_owner;

    struct User{
        string name;
        address userAddress;
        string  position;
    }

    struct Evidence {
        uint256 item_Number;
        string case_number;
        address collector;
        string evidence_description;
        string collection_location;
        string evidenceCID;
    }

    struct Case {
        string case_no;
        string case_description;
        uint256 no_participants;
        address[] participants;
    }

    User[] public userArray;
    Evidence[] public evidenceArray;
    Case[] public  caseArray;

    mapping (address => User) userMapping;
    mapping (address => Case[]) user_CaseMapping;
    mapping (string => Evidence[]) caseMapping;


    constructor() {
        i_owner = msg.sender;
        userMapping[i_owner].position = "admin";

    }

    function addNewCase (
        string memory _caseNo,
        string memory _caseDescription,
        uint256 _noParticipants,
        address[] memory _participants
    ) public {
        Case  memory newcase = Case({
            case_no: _caseNo,
            case_description: _caseDescription,
            no_participants: _noParticipants,
            participants:_participants
            
        });
        caseArray.push(newcase);
         // Update user_CaseMapping for each participant
    for (uint256 i = 0; i < _participants.length; i++) {
        user_CaseMapping[_participants[i]].push(newcase);
    }
    }

    function addEvidence (
        uint256 _itemNo,
        string memory _caseNumber,
        string memory _description,
        string memory _location_Collection,
        string memory _evidenceCID
    ) public  {
        Evidence memory newEvidence = Evidence({
             item_Number : _itemNo,
             case_number : _caseNumber,
             collector : msg.sender,
             evidence_description : _description,
             collection_location : _location_Collection,
             evidenceCID : _evidenceCID
         });
         evidenceArray.push(newEvidence);
         caseMapping[_caseNumber].push(newEvidence);
    }

    function getmyCase(
        address _useraddress 
        )external view returns (Case[] memory) {
            return user_CaseMapping[_useraddress];
         }
    function getEvidence(
        string memory _casenumber
        ) external view returns (Evidence[] memory) {
            return caseMapping[_casenumber];
         }

    function countUsersByPosition() public view returns (
        uint256 judgeCount, 
        uint256 forensicCount, 
        uint256 lawEnforcementCount, 
        uint256 prosecutorCount) {
    for (uint256 i = 0; i < userArray.length; i++) {
        if (keccak256(abi.encodePacked(userArray[i].position)) == keccak256(abi.encodePacked("judge"))) {
            judgeCount++;
        } else if (keccak256(abi.encodePacked(userArray[i].position)) == keccak256(abi.encodePacked("forensic"))) {
            forensicCount++;
        } else if (keccak256(abi.encodePacked(userArray[i].position)) == keccak256(abi.encodePacked("law enforcement"))) {
            lawEnforcementCount++;
        } else if (keccak256(abi.encodePacked(userArray[i].position)) == keccak256(abi.encodePacked("prosecutor"))) {
            prosecutorCount++;
        }
    }
    }

     function Login(
        address add
        ) public view returns (string memory) {
        return userMapping[add].position;
        }

    // function logout() external  {
    //     loggedInUser = address(0);
    // }

}