pragma solidity ^0.4.24;

import "./oz/Ownable.sol";
import "./oz/SafeMath.sol";
import "./BatchBondedToken.sol";

contract CurvedGuildBank is BatchBondedToken, Ownable {
    using SafeMath for uint256;

    event Withdrawal(address indexed receiver, uint256 amount);

    constructor(
        string memory name,
        string memory symbol,
        uint256 _batchBlocks,
        uint32 _reserveRatio,
        uint256 _virtualSupply,
        uint256 _virtualBalance
    ) public BatchBondedToken(name, symbol, _batchBlocks, _reserveRatio, _virtualSupply, _virtualBalance) {
    }

    function withdraw(address receiver, uint256 shares, uint256 totalShares) public onlyOwner returns (bool) {
        uint256 amount = balanceOf(msg.sender).mul(shares).div(totalShares);
        emit Withdrawal(receiver, amount);
        return transfer(receiver, amount);
    }
}
