pragma solidity ^0.4.15;

contract Guess {
    string title;

    function getTitle() public view returns(string){
        return title;
    }
    function setTitle(string _title) public returns (string){
        title = _title;
        return title;
    }

}
