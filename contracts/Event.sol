pragma solidity ^0.4.15;

contract Event {
    struct EventStruct{
        bytes32 title;
        bytes32 description;
        bytes32 topic;
        bytes32 option1;
        bytes32 option2;
        bytes32 option3;
        bytes32 option4;
        uint256 date; 
        uint32 votes;
    }
    EventStruct[] events;

    // Event has too much variables for solidity.
    // Since solidity only allows each function to have 16 variables of 32 bits
    // Because of this reason the function will be splited into two
    function getEvent(uint32 index) public view returns(
        bytes32,
        bytes32,
        bytes32,
        uint256,
        uint32){

        return(events[index].title,
               events[index].description,
               events[index].topic,
               events[index].date,
               events[index].votes);
    }
    function getEventOptions(uint32 index) public view returns(
        bytes32,
        bytes32,
        bytes32,
        bytes32
    ){
        return(events[index].option1,
            events[index].option2,
            events[index].option3,
            events[index].option4
        );
    }

    function setEvent(
        bytes32 _title, 
        bytes32 _description, 
        bytes32 _topic,
        bytes32 _option1,
        bytes32 _option2,
        bytes32 _option3,
        bytes32 _option4
    ) public { // Returns the index where the event is store
        EventStruct memory _event = EventStruct({
            title: _title,
            description: _description,
            topic: _topic,
            option1: _option1,
            option2: _option2,
            option3: _option3,
            option4: _option4,
            date: now, // this gets the current timestamp of the block
            votes: 0
        });
        events.push(_event);
    }
    function getEventsLength() public view returns(uint256){
        return events.length;
    }

    // TODO: Get current day events
}
