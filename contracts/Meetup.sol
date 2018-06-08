/*
This is just the initial version of the Meetup contract.
At this time I haven't settled on whether or not I want 
this contract to represent an individual Meetup,
or the general case that represents the group as a whole.
For now, I will be implementing it thinking
this represents a particular Meetup on a specific date.
*/
//pragma solidity ^0.4.18
contract Meetup is ERC20Token {

  //initialize variables
  address public organizer;
  mapping (address => bool) public memberJoined;
  uint public memberCount;

  //constructor
  function Meetup() public {
    organizer = msg.sender;
    memberCount = 0;
  }

  function attend() public payable returns (bool) {
    memberJoined[msg.sender] = true;
    memberCount++;
    return true;
  }

  function getMemberCount() public view returns (uint) {
    return memberCount;
  }

  function checkAttendence(address member) public view returns (bool) {
    return memberJoined[member];
}

//truffle recommends a kill function
//but this is not complete. TODO: return funds to organizer
  function kill() {
    if (msg.sender == organizer)
      selfdestruct(organizer);
  }

}

contract ERC20Token
{
  // token name and symbol
  string symbol;
  string name;

  //decimal places suggested by ethereum.org/token
  uint8 public decimals = 18;
  
  //creates arrays of balances
  mapping (address => uint256) public balancesOf;
  mapping (address => mapping (address => uint256)) public allowance;

  uint256 totalSupply; 

  //generates event on blockchain notifying clients
  event Transfer(address indexed from, address indext to, uint256 value);

  //notifies clients about amount burned 
  event Burn(address indexed from, uint256 value);

  /*Constructor
    initialize contract with initial token supply
  */
  function ERC20Token(uint256 initialSupply, string tokenName, string tokenSymbol) public {
    
  //update total supply with decimal amount
    totalSupply = initialSupply * 10 ** uinit256(decimals);
  //give creator all initial tokens
    balanceOf[msg.sender] = totalSupply;
    name = tokenName;
    symbol = tokenSymbol;

  }
}
