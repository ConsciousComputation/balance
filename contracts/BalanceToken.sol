pragma solidity >=0.4.21 <0.6.0;
  
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";  
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";  
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
  
/**  
* @title BalanceToken is a basic ERC20 Token  
*/  
contract BalanceToken is ERC20, Ownable{  

  using SafeMath for uint256;
  using SafeMath for uint32;
  using SafeMath for uint;
  
  uint256 private _totalSupply;  
  string public name = "Balance Token";  
  string public symbol ="BLNC";

  mapping(address => uint) balances;
  mapping(address => mapping(address => uint)) allowed;
  
  constructor() BalanceToken() public {  
      uint256 _initialSupply = 100000000000;  
      balances[msg.sender] = _initialSupply;
      _totalSupply = _initialSupply;
     }

    function totalSupply() public view returns (uint) {
        return _totalSupply  - balances[address(0)];
    }

    function increaseSupply(uint256 _amt) public{
        require(msg.sender == owner());
        _totalSupply += _amt; 
        balances[msg.sender] += _amt;
    }

    function decreaseSupply(uint256 _amt) public{
        require(msg.sender == owner());
        _totalSupply -= _amt; 
        balances[msg.sender] -= _amt;  
    }

    
     function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }


    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

   function transfer(address to, uint tokens) public returns (bool success) {
        require(balances[msg.sender] >= tokens);
        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

     function transferFrom(address from, address to, uint tokens) public returns (bool success) {
       require(tokens <= balances[from]);
        require(tokens <= allowed[from][msg.sender]);
        balances[from] = balances[from].sub(tokens);
        allowed[from][msg.sender] = tokens.sub(allowed[from][msg.sender]);
        balances[to] = balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }




}
