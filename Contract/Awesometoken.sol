// SPDX-License-Identifier: UNLICENSE
pragma solidity >=0.8.7 <0.9.0;

contract AwesomeToken {
    // Token name
    string public name = "AwesomeToken";
    // Token symbol
    string public symbol = "ATK";
    string public standard = "AwesomeToken v1.0";

    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    constructor(uint256 _totalSupply) {
        balanceOf[msg.sender] = _totalSupply;
        totalSupply = _totalSupply; // 1M Tokens
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balanceOf[_from] >= _value);
        require(allowance[_from][msg.sender] >= _value);

        // Transfer the balance.
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        // Decrease the allowance by the amount being transfered.
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }
}