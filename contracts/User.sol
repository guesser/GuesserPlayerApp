pragma solidity ^0.4.15;

contract User {
    struct UserStruct {
        bytes32 username;
        uint256 balance;
        bytes32 image_url;
    }

    mapping (address => UserStruct) users;

    function setUser(bytes32 _username, bytes32 _image_url) public {
        users[msg.sender].username = _username;
        users[msg.sender].balance = 0;
        users[msg.sender].image_url = _image_url;
    }

    function getUser() public view returns(bytes32, uint256, bytes32){
        return (
            users[msg.sender].username,
            users[msg.sender].balance,
            users[msg.sender].image_url
        );
    }
}
