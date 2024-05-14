// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9; 
contract Legal{

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

    struct Transaction {
        string transactionType;
        address userAddress;
        uint256 timestamp;
        string status;
    }

    User[] public userArray;
    Evidence[] public evidenceArray;
    Case[] public  caseArray;
    Transaction[] public  transactionsArray;

    mapping (address => User) userMapping;
    mapping (address => Case[]) user_CaseMapping;
    mapping (string => Evidence[]) caseMapping;



    constructor() {
        i_owner = msg.sender;
        userMapping[i_owner].position = "admin";

    }

     // Event to log new transactions
    event NewTransaction(
        string transactionType,
        address userAddress,
        uint256 timestamp,
        string status
    );

    //Event to log new Case
    event CaseAdded(
        string caseNo,
        string casedescription,
        uint256 no_participants,
        address[] participants
    );

    // Event to log evidence addition
    event EvidenceAdded(
        uint256 itemNo,
        string caseNo,
        string description,
        string evidence_cid,
        address uploader,
        uint256 timestamp
    );

    // Event to log evidence download
    event EvidenceDownloaded(
        string ipfs_hash,
        address downloader,
        uint256 timestamp
    );

    // Function to add a new transaction
    function addTransaction(
        string memory _transactionType,
        address _userAddress,
        string memory _status
    ) internal {
        Transaction memory newTransaction = Transaction({
            transactionType: _transactionType,
            userAddress: _userAddress,
            timestamp: block.timestamp,
            status: _status
        });
        transactionsArray.push(newTransaction);
        emit NewTransaction(_transactionType, _userAddress, block.timestamp, _status);
    }

    function addUser(
        string memory _name,
        address _useraddress,
        string memory _position
    ) public {
        User memory newuser = User ({
            name: _name,
            userAddress : _useraddress,
            position : _position
        });
        
         userArray.push(newuser);
         // Update userMapping for each user
         userMapping[newuser.userAddress] = newuser;
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

      // Emit event for evidence addition
     emit CaseAdded(_caseNo, _caseDescription, _noParticipants, _participants);

     // Add transaction for evidence addition
     addTransaction("Add New Case", msg.sender, "Success");
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
          // Emit event for evidence addition
        emit EvidenceAdded(_itemNo, _caseNumber, _description, _evidenceCID, msg.sender, block.timestamp);

        // Add transaction for evidence addition
        addTransaction("Add Evidence", msg.sender, "Success");
    }

    function getUsers() public view returns (User[] memory){
        return userArray;
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

    function getAllEvidence() public view returns (Evidence[] memory ) {
        return evidenceArray;
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