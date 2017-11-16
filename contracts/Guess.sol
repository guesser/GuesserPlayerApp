pragma solidity ^0.4.15;

contract Guess {
    struct GuessStruct{
        bytes32 title;
        bytes32 description;
    }
    GuessStruct[] guesses;

    function getGuess(uint256 index) public view returns(bytes32, bytes32){
        return (guesses[index].title, guesses[index].description);
    }
    function setGuess(bytes32 _title, bytes32 _description) public returns (bytes32, bytes32){
        GuessStruct memory _guess = GuessStruct({
            title: _title,
            description: _description
        });
        guesses.push(_guess);

        return (guesses[guesses.length-1].title, guesses[guesses.length-1].description);
    }
    function getGuessesLength() public view returns (uint256){
        return guesses.length;
    }
}
