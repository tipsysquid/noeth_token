/*
This is just the initial version of the Meetup contract.
At this time I haven't settled on whether or not I want 
this contract to represent an individual Meetup,
or the general case that represents the group as a whole.
For now, I will be implementing it thinking
this represents a particular Meetup on a specific date.
*/
contract Meetup {

//initialize variables
address public organizer;
mapping (address => bool) public memberJoined;
uint public memberCount;

//constructor
function Meetup() {
	organizer = msg.sender;
	memberCount = 0;
}

function attend() public payable returns (bool) {
	memberJoined[msg.sender] = true;
	memberCount++;
	return true;
}

function getMemberCount() public returns (uint) {
	return memberCount;
}

function checkAttendence(address member) public returns (bool) {
	return memberJoined[member];
}

//truffle recommends a kill function
//but this is not complete. TODO: return funds to organizer
function kill() {
	if (msg.sender == organizer)
		suicide(organizer);
}

}
