pragma solidity ^0.4.15;

contract Guess {
    struct GuessStruct{
        bytes32 title;
        bytes32 description;
        bytes32 option1;
        bytes32 option2;
        bytes32 option3;
        bytes32 option4;
    }
    GuessStruct _guessTemp;
    GuessStruct[] guesses;

    function getGuess(uint256 index) public view returns(bytes32, bytes32, bytes32, bytes32, bytes32, bytes32){
        return (guesses[index].title, 
                guesses[index].description, 
                guesses[index].option1,
                guesses[index].option2,
                guesses[index].option3,
                guesses[index].option4
               );
    }
    function setGuess(
        bytes32 _title, 
        bytes32 _description, 
        bytes32 _option1,
        bytes32 _option2,
        bytes32 _option3,
        bytes32 _option4
    ) public returns (uint256){
        GuessStruct memory _guess = GuessStruct({
            title: _title,
            description: _description,
            option1: _option1,
            option2: _option2,
            option3: _option3,
            option4: _option4
        });

        guesses.push(_guess);
        return guesses.length-1;
    }
    function getGuessesLength() public view returns (uint256){
        return guesses.length;
    }
}
