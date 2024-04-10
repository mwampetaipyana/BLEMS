// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Blems{

    struct Police_Officer {
        string fname;
        string lname;
        address officer_address;
        string badge_no;
    }

    struct Forensic_expert{
        string fname;
        string lname;
        address forensic_address;
        string badge_no;
    }

    struct Prosecutor{
        string fname;
        string lname;
        address prosecutor_address;
    }

    struct Judge{
        string fname;
        string lname;
        address judge_address;
    }

    struct Evidence{
        string item_no;
        string case_no;
        address collector;
        uint256 timestamp;
        string description;
        string location_of_collection;
        string data; //IPFS hash
    }

    Police_Officer[] public policeOfficers;
    Forensic_expert[] public forensicExperts;
    Prosecutor[] public prosecutors;
    Judge[] public judges;
    Evidence[] public evidenceList;



    function add_Evidence(
        string memory _item_no,
        string memory _case_no,
        string memory _description,
        string memory _location_of_collection,
        string memory _data
    ) public {
         Evidence memory newEvidence = Evidence({
            item_no: _item_no,
            case_no: _case_no,
            timestamp: block.timestamp,
            collector: msg.sender,
            description: _description,
            location_of_collection: _location_of_collection,
            data: _data
        });
        evidenceList.push(newEvidence);
    }

     function viewAllEvidence() public view returns (Evidence[] memory) {
        return evidenceList;
    }

    function addPoliceOfficer(
        string memory _fname,
        string memory _lname,
        address _officer_address,
        string memory _badge_no
    ) public {
        policeOfficers.push(Police_Officer(_fname, _lname, _officer_address, _badge_no));
    }

    function addForensicExpert(
        string memory _fname,
        string memory _lname,
        address _forensic_address,
        string memory _badge_no
    ) public {
        forensicExperts.push(Forensic_expert(_fname, _lname, _forensic_address, _badge_no));
    }

    function addProsecutor(
        string memory _fname,
        string memory _lname,
        address _prosecutor_address
    ) public {
        prosecutors.push(Prosecutor(_fname, _lname, _prosecutor_address));
    }

    function addJudge(
        string memory _fname,
        string memory _lname,
        address _judge_address
    ) public {
        judges.push(Judge(_fname, _lname, _judge_address));
    }

        // Functions to view personnel
    function getPoliceOfficersCount() public view returns (uint) {
        return policeOfficers.length;
    }

    function getForensicExpertsCount() public view returns (uint) {
        return forensicExperts.length;
    }

    function getProsecutorsCount() public view returns (uint) {
        return prosecutors.length;
    }

    function getJudgesCount() public view returns (uint) {
        return judges.length;
    }

}