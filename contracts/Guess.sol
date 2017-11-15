pragma solidity ^0.4.15;

contract Guess {
    string[] titles;

    function getTitles(uint256 index) public view returns(string){
        return titles[index];
    }
    function setTitle(string _title) public returns (string){
        titles.push(_title);
        return titles[titles.length-1];
    }
    function getTitlesLength() public view returns (uint256){
        return titles.length;
    }
}
