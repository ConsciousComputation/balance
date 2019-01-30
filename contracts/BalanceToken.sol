pragma solidity >=0.4.21 <0.6.0;
  
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";  
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";  
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";  
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
  
/**  
* @title BalanceToken is a basic ERC20 Token  
*/  
contract BalanceToken is ERC20, ERC20Detailed, Ownable{  

  using SafeMath for uint256;
  using SafeMath for uint32;
  using SafeMath for uint;
  
  uint8 public constant DECIMALS = 5;
  uint256 public constant INITIAL_SUPPLY = 1000 * (10**uint256(DECIMALS));
  uint256 private _totalSupply;  

  mapping(address => uint) balances;
  mapping(address => mapping(address => uint)) allowed;
  
  constructor() public ERC20Detailed("Balance Token","BLNC",DECIMALS) Ownable() {  
    _totalSupply = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    _mint(msg.sender,INITIAL_SUPPLY);
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
     function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
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
        require(balances[msg.sender] >= tokens,"OOPS");
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
