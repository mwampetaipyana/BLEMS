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
        uint256 dateCollected;
        address collector;
        string evidence_description;
        string collection_location;
        string evidenceCID;
    }

    struct Case {
        string case_no;
        string case_description;
        address addedBy;
        uint256 dateAdded;
        uint256 no_participants;
        address[] participants;
    }

    struct Transaction {
        string transactionType;
        string caseNumber;
        address userAddress;
        uint256 timestamp;
        string status;
    }

    struct Report {
        string title;
        string caseNumber;
        string description;
        string file_hash;
        
    }

    User[] public userArray;
    Evidence[] public evidenceArray;
    Case[] public  caseArray;
    Transaction[] public  transactionsArray;
    Report[] public reportsArray;
    
    mapping (address => User) public userMapping;
    mapping (address => Case[]) public user_CaseMapping;
    mapping (string => Evidence[]) public caseMapping;
    mapping (string => Report[]) public caseReportMapping;
    mapping (string => Transaction[]) caseTransactionMapping;

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

    // //Event to log new Case
    // event CaseAdded(
    //     string caseNo,
    //     string casedescription,
    //     uint256 no_participants,
    //     address[] participants
    // );

    // // Event to log evidence addition
    // event EvidenceAdded(
    //     uint256 itemNo,
    //     string caseNo,
    //     string description,
    //     string evidence_cid,
    //     address uploader,
    //     uint256 timestamp
    // );
    
    // event ReportAdded(
    //     string title,
    //     string caseNumber,
    //     string description,
    //     string file_hash
    // );
 
    function addUser(
        string memory _name,
        address _useraddress,
        string memory _position
    ) public ownerOnly {
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
    ) public onlyProsecutor {

        // Check if the case number already exists
        require(caseTransactionMapping[_caseNo].length == 0, "Case already exists");

        Case  memory newcase = Case({
            case_no: _caseNo,
            case_description: _caseDescription,
            addedBy: msg.sender,
            dateAdded: block.timestamp,
            no_participants: _noParticipants,
            participants:_participants
            
        });
        
        Transaction memory txnobj = Transaction ({
            transactionType: "Add new Case",
            caseNumber : _caseNo,
            userAddress: msg.sender,
            timestamp: block.timestamp,
            status: "Success"

        });

        caseTransactionMapping[_caseNo].push(txnobj);
        caseArray.push(newcase);
        user_CaseMapping[msg.sender].push(newcase);
         // Update user_CaseMapping for each participant
    for (uint256 i = 0; i < _participants.length; i++) {
        user_CaseMapping[_participants[i]].push(newcase);
    }

      // Emit event for evidence addition
    //  emit CaseAdded(_caseNo, _caseDescription, _noParticipants, _participants);

     // Add transaction for evidence addition
     addTransaction("Add New Case",  _caseNo, msg.sender, "Success");
    }

    function addEvidence (
        uint256 _itemNo,
        string memory _caseNumber,
        string memory _description,
        string memory _location_Collection,
        string memory _evidenceCID
    ) public onlyPolice  {

        // Check if the case number exists
        require(caseTransactionMapping[_caseNumber].length > 0, "Case does not exist");

        Evidence memory newEvidence = Evidence({
             item_Number : _itemNo,
             case_number : _caseNumber,
             dateCollected: block.timestamp,
             collector : msg.sender,
             evidence_description : _description,
             collection_location : _location_Collection,
             evidenceCID : _evidenceCID
         });


        Transaction memory txnobj = Transaction ({
            transactionType: "Add  Case Evidence",
            caseNumber : _caseNumber,
            userAddress: msg.sender,
            timestamp: block.timestamp,
            status: "Success"

        });

        caseTransactionMapping[_caseNumber].push(txnobj);
        evidenceArray.push(newEvidence);
         caseMapping[_caseNumber].push(newEvidence);
          // Emit event for evidence addition
        // emit EvidenceAdded(_itemNo, _caseNumber, _description, _evidenceCID, msg.sender, block.timestamp);

        // Add transaction for evidence addition
        addTransaction("Add Evidence",  _caseNumber, msg.sender, "Success");
    }

    function uploadReport (
        string memory _title,
        string memory _description,
        string memory _caseNumber,
        string memory _fileHash
    ) public onlyForensic{

        // Check if the case number exists
        require(caseTransactionMapping[_caseNumber].length > 0, "Case does not exist");

        Report memory newReport = Report ({
            title: _title,
            caseNumber: _caseNumber,
            description : _description,
            file_hash: _fileHash
        });

        Transaction memory txnobj = Transaction ({
            transactionType: "Add  Case Report",
            caseNumber : _caseNumber,
            userAddress: msg.sender, 
            timestamp: block.timestamp,
            status: "Success"

        });

        caseTransactionMapping[_caseNumber].push(txnobj);
        reportsArray.push(newReport);
        caseReportMapping[_caseNumber].push(newReport);

        // emit ReportAdded(_title, _caseNumber, _description, _fileHash);
        addTransaction("Upload Report", _caseNumber, msg.sender, "Success");
    } 

    function getReport(
        string memory _caseNumber)
        public view returns (
            Report[] memory) {
        return caseReportMapping[_caseNumber];

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

    function getAllEvidence() 
    public view returns
     (Evidence[] memory ) {
        return evidenceArray;
    }

    function getCaseTxns( 
        string memory _caseNumber
        ) public view returns
    (Transaction[] memory) {
        return caseTransactionMapping[_caseNumber];
    }

    function getSystemTxns() public view returns (Transaction[] memory){
        return transactionsArray;
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
        } else if (keccak256(abi.encodePacked(userArray[i].position)) == keccak256(abi.encodePacked("police"))) {
            lawEnforcementCount++;
        } else if (keccak256(abi.encodePacked(userArray[i].position)) == keccak256(abi.encodePacked("prosecutor"))) {
            prosecutorCount++;
        }
    } 
    }


       // Function to add a new transaction
    function addTransaction(
        string memory _transactionType,
        string memory _caseNumber,
        address _userAddress,
        string memory _status
    ) internal {
        Transaction memory newTransaction = Transaction({
            transactionType: _transactionType,
            caseNumber: _caseNumber,
            userAddress: _userAddress,
            timestamp: block.timestamp,
            status: _status
        });
        transactionsArray.push(newTransaction);
        emit NewTransaction(_transactionType, _userAddress, block.timestamp, _status);
    }

   
    function login(address add) public view returns (string memory, string memory) {
        User memory user = userMapping[add];
        return (user.name, user.position);
    }

    modifier ownerOnly() {
        require(msg.sender == i_owner, "BLEMS Admin account is required");
        _;
    }

    modifier onlyPolice() {
    require(
        keccak256(abi.encodePacked(userMapping[msg.sender].position)) == keccak256(abi.encodePacked("police")),
        "Only users with the police role can call this function"
    );
    _;
    }

    modifier onlyForensic() {
    require(
        keccak256(abi.encodePacked(userMapping[msg.sender].position)) == keccak256(abi.encodePacked("forensic")),
        "Only users with the forensic role can call this function"
    );
    _;
    }

    modifier onlyProsecutor() {
    require(
        keccak256(abi.encodePacked(userMapping[msg.sender].position)) == keccak256(abi.encodePacked("prosecutor")),
        "Only users with the prosecutor role can call this function"
    );
    _;
    }

}