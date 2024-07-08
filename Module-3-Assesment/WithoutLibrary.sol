// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract LitToken {
    string public hypeName;
    string public swagSymbol;
    uint8 public decimalPoints;
    uint256 public totalStacks;

    mapping(address => uint256) public balanceMap;
    mapping(address => mapping(address => uint256)) public allowanceMap;

    address public bigBoss;

    event SendIt(address indexed from, address indexed to, uint256 amount);
    event Approved(address indexed owner, address indexed spender, uint256 amount);
    event Burned(address indexed from, uint256 amount);
    event Created(address indexed to, uint256 amount);

    constructor(
        string memory _hypeName,
        string memory _swagSymbol,
        uint8 _decimalPoints,
        uint256 _initialStacks
    ) {
        hypeName = _hypeName;
        swagSymbol = _swagSymbol;
        decimalPoints = _decimalPoints;
        totalStacks = _initialStacks * 10 ** uint256(_decimalPoints);
        balanceMap[msg.sender] = totalStacks;
        bigBoss = msg.sender;
    }

    modifier onlyBigBoss() {
        require(msg.sender == bigBoss, "Only the Big Boss can call this function");
        _;
    }

    function sendIt(address _to, uint256 _amount) external returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceMap[msg.sender] >= _amount, "Not enough stacks");

        balanceMap[msg.sender] -= _amount;
        balanceMap[_to] += _amount;
        emit SendIt(msg.sender, _to, _amount);
        return true;
    }

    function approve(address _spender, uint256 _amount) external returns (bool success) {
        allowanceMap[msg.sender][_spender] = _amount;
        emit Approved(msg.sender, _spender, _amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) external returns (bool success) {
        require(_from != address(0), "Invalid address");
        require(_to != address(0), "Invalid address");
        require(balanceMap[_from] >= _amount, "Not enough stacks");
        require(allowanceMap[_from][msg.sender] >= _amount, "Allowance exceeded");

        balanceMap[_from] -= _amount;
        balanceMap[_to] += _amount;
        allowanceMap[_from][msg.sender] -= _amount;
        emit SendIt(_from, _to, _amount);
        return true;
    }

    function burnStacks(uint256 _amount) external returns (bool success) {
        require(balanceMap[msg.sender] >= _amount, "Not enough stacks");

        balanceMap[msg.sender] -= _amount;
        totalStacks -= _amount;
        emit Burned(msg.sender, _amount);
        return true;
    }

    function mintStacks(address _to, uint256 _amount) external onlyBigBoss returns (bool success) {
         require(_to != address(0), "Invalid address");
         balanceMap[_to] += _amount;
         totalStacks += _amount;
         emit Created(_to, _amount);
         emit SendIt(address(0), _to, _amount);
         return true;
    }
}

