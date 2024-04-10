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
        uint256 timestamp;
        string description;
        string location_of_collection;
        string data; //IPFS hash
    }

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
            description: _description,
            location_of_collection: _location_of_collection,
            data: _data
        });
        evidenceList.push(newEvidence);
    }

     function viewAllEvidence() public view returns (Evidence[] memory) {
        return evidenceList;
    }
}