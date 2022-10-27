/**
 *Submitted for verification at BscScan.com on 2022-08-22
*/

/**
 *Submitted for verification at BscScan.com on 2022-02-12
*/

pragma solidity ^0.8.11;

// SPDX-License-Identifier: Unlicensed
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function decimals() external view returns (uint256);
    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address _owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Ownable {

    address public _owner;

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
        _owner = newOwner;
    }
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }
}

interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
    external
    view
    returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
    external
    returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
    external
    view
    returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
    external
    view
    returns (
        uint112 reserve0,
        uint112 reserve1,
        uint32 blockTimestampLast
    );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
    external
    returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
    external
    returns (
        uint256 amountA,
        uint256 amountB,
        uint256 liquidity
    );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
    external
    payable
    returns (
        uint256 amountToken,
        uint256 amountETH,
        uint256 liquidity
    );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
    external
    view
    returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
    external
    view
    returns (uint256[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

library TransferHelper {
    function safeApprove(
        address token,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::safeApprove: approve failed'
        );
    }

    function safeTransfer(
        address token,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::safeTransfer: transfer failed'
        );
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::transferFrom: transferFrom failed'
        );
    }

    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, 'TransferHelper::safeTransferETH: ETH transfer failed');
    }
}

contract Award is Ownable {
    using SafeMath for uint256;

    HMC public hmc;
    
    constructor(HMC _hmc) {
        hmc = _hmc;
        _owner = msg.sender;
    }

    function award(address _addr, uint _award) public {
        require(msg.sender == address(hmc), "only hmc");
        // hmc.transfer(_addr, _award);
        TransferHelper.safeTransfer(address(hmc), _addr, _award);
    }

    function withdraw(uint amount) public onlyOwner {
        // hmc.transfer(msg.sender, amount);
        TransferHelper.safeTransfer(address(hmc), msg.sender, amount);
    }
}


contract HMC is IERC20, Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public _rOwned;
    mapping(address => mapping(address => uint256)) private _allowances;

    mapping(address => bool) private _isExcludedFromFee;
    mapping(address => bool) public isStop;

    mapping(address => bool) public isRoute;

    uint256 private constant MAX = ~uint256(0);
    uint256 private _tTotal;
    uint256 private _rTotal;
    uint256 private _tFeeTotal;

    string private _name;
    string private _symbol;
    uint256 private _decimals;


    uint256 public _destroyFee;
    address private _destroyAddress = address(0x000000000000000000000000000000000000dEaD);

    uint256 public _inviterFee;

    uint256 public _fundFee = 3;
    uint256 public _fundFee1 = 1;
    uint256 public _fundFee2 = 2;
    uint256 public _fundFee3 = 1;

    uint256 public _fundFee4 = 3;
    uint256 public _fundFee5 = 4;
    uint256 public _fundFee6 = 3;
    uint256 public _fundFee7 = 1;
    uint256 public _fundFee8 = 1;
    uint256 public _fundFee9 = 3;
    
    uint256 public _fundFee10 = 8;


    
    address private fundAddress = address(0xaE4DEa229F498279E9A49D42D8c2Ad3ed459aB13);
    address private fundAddress1 = address(0x4Da7C91d9aCF653C993c28627dE4272CAd75994B);
    address private fundAddress2 = address(0x1752690bA3db190AE654f58303960B391a0aFf7A);
    address private fundAddress3 = address(0xe4C6dA55e52da493a697135D4Dd0698b262677e0);

    address private fundAddress4 = address(0x9ef37cEda6cf7E2432Cd5d35a83b089eDdbA5BaD);
    address private fundAddress5 = address(0x000000000000000000000000000000000000dEaD);
    address private fundAddress6 = address(0x355e476B464B30f8d5536d8903d454566D42b4e4);
    address private fundAddress7 = address(0xe4C6dA55e52da493a697135D4Dd0698b262677e0);
    address private fundAddress8 = address(0x4Da7C91d9aCF653C993c28627dE4272CAd75994B);
    address private fundAddress9 = address(0xaE4DEa229F498279E9A49D42D8c2Ad3ed459aB13);
    
    address private fundAddress10 = address(0x9ef37cEda6cf7E2432Cd5d35a83b089eDdbA5BaD);

    mapping(address => address) public inviter;
    mapping(address => uint256) public inviterNum;

    IUniswapV2Router02 public immutable uniswapV2Router;
    address public uniswapV2Pair;

    bool public isOpen = true;

    address private USDT;

    Award public awarder;

    constructor() {
        _name = "HMC";
        _symbol = "HMC";
        _decimals = 18;

        USDT = address(0x55d398326f99059fF775485246999027B3197955);
        isRoute[0x10ED43C718714eb63d5aA57B78B54704E256024E]=true;
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), USDT);

        uniswapV2Router = _uniswapV2Router;

        _tTotal = 10000000 * 10 ** _decimals;
        _rTotal = (MAX - (MAX % _tTotal));

        address tokenReceiver = address(0xAf57c947285d4F6A529Ae46485a8a69ac54fE440);

        _rOwned[tokenReceiver] = _rTotal;


        _isExcludedFromFee[tokenReceiver] = true;
        _isExcludedFromFee[msg.sender] = true;
        _isExcludedFromFee[address(this)] = true;

        _owner = msg.sender;
        emit Transfer(address(0), tokenReceiver, _tTotal);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() external view override returns (uint256) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return tokenFromReflection(_rOwned[account]);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            _allowances[sender][msg.sender].sub(amount, "ERC20: transfer amount exceeds allowance")
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool){
        _approve(
            msg.sender,
            spender,
            _allowances[msg.sender][spender].add(addedValue)
        );
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool){
        _approve(
            msg.sender,
            spender,
            _allowances[msg.sender][spender].sub(
                subtractedValue,
                "ERC20: decreased allowance below zero"
            )
        );
        return true;
    }

    function totalFees() public view returns (uint256) {
        return _tFeeTotal;
    }

    function tokenFromReflection(uint256 rAmount) public view returns (uint256) {
        require(
            rAmount <= _rTotal,
            "Amount must be less than total reflections"
        );
        uint256 currentRate = _getRate();
        return rAmount.div(currentRate);
    }

    function excludeFromFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = true;
    }

    function includeInFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = false;
    }

    function setAwarder(Award _awarder) public onlyOwner {
        awarder = _awarder;
    }

    function setStop(
        address _addr,
        bool _bool
    ) external onlyOwner{
        isStop[_addr] = _bool;
    }

    function setOpen() external onlyOwner{
        isOpen = !isOpen;
    }

    receive() external payable {}

    function _getRate() private view returns (uint256) {
        (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
        return rSupply.div(tSupply);
    }

    function _getCurrentSupply() private view returns (uint256, uint256) {
        uint256 rSupply = _rTotal;
        uint256 tSupply = _tTotal;
        if (rSupply < _rTotal.div(_tTotal)) return (_rTotal, _tTotal);
        return (rSupply, tSupply);
    }

    function claim() public onlyOwner {
        payable(_owner).transfer(address(this).balance);
    }

    function claimTokens(address token,address to,uint256 amount) public onlyOwner {
        IERC20(token).transfer(to,amount);
    }

    function isExcludedFromFee(address account) public view returns (bool) {
        return _isExcludedFromFee[account];
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function getReserves() public view returns(uint112 reserve0,uint112 reserve1){
        (reserve0,reserve1,)=IUniswapV2Pair(uniswapV2Pair).getReserves();
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) private {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require((!isStop[from] && !isStop[to]),"address error");
        if (!_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
            require(isOpen,"open error");
        }

    
        bool takeFee = false;

        if (from==uniswapV2Pair && isRoute[to]){
            takeFee = false;
        }else if (from==uniswapV2Pair && !isRoute[to]) {
            takeFee = true;
        }else if (to==uniswapV2Pair) {
            takeFee = true;
        }else{
            if (from!=uniswapV2Pair && isRoute[from]){
                takeFee = true;
            }else {
                takeFee = true;
            }
        }

        if (_isExcludedFromFee[from] || _isExcludedFromFee[to]) {
            takeFee = false;
        }

        bool shouldSetInviter = inviter[to] == address(0) && !isContract(from) && !isContract(to);

        _tokenTransfer(from, to, amount, takeFee);


        if (shouldSetInviter) {
            inviter[to] = from;
        }
    }

    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    function _tokenTransfer(
        address sender,
        address recipient,
        uint256 tAmount,
        bool takeFee
    ) private {

        uint256 currentRate = _getRate();
        uint256 multiple = 1;
        uint256 rAmount = tAmount.mul(currentRate);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        uint256 rate = 0;

        if (takeFee) {

            if (sender==uniswapV2Pair && isRoute[recipient]){

            }else if (sender==uniswapV2Pair && !isRoute[recipient]) {
                _takeInviterFee(sender, recipient, tAmount);
                _takeTransfer(
                    sender,
                    fundAddress,
                    tAmount.div(100).mul(_fundFee.mul(multiple)),
                    currentRate
                );
                _takeTransfer(
                    sender,
                    fundAddress1,
                    tAmount.div(100).mul(_fundFee1.mul(multiple)),
                    currentRate
                );
                _takeTransfer(
                    sender,
                    fundAddress2,
                    tAmount.div(100).mul(_fundFee2.mul(multiple)),
                    currentRate
                );
                _takeTransfer(
                    sender,
                    fundAddress3,
                    tAmount.div(100).mul(_fundFee3.mul(multiple)),
                    currentRate
                );
                rate = (_fundFee + _fundFee1 + _fundFee2 + _fundFee3).mul(multiple);
            }else if (recipient==uniswapV2Pair) {
                // _takeInviterFee(sender, recipient, tAmount);
                _takeTransfer(
                    sender,
                    fundAddress4,
                    tAmount.div(100).mul(_fundFee4.mul(multiple)),
                    currentRate
                );
                _takeTransfer(
                    sender,
                    fundAddress5,
                    tAmount.div(100).mul(_fundFee5.mul(multiple)),
                    currentRate
                );
                _takeTransfer(
                    sender,
                    fundAddress6,
                    tAmount.div(100).mul(_fundFee6.mul(multiple)),
                    currentRate
                );
                _takeTransfer(
                    sender,
                    fundAddress7,
                    tAmount.div(100).mul(_fundFee7.mul(multiple)),
                    currentRate
                );
                _takeTransfer(
                    sender,
                    fundAddress8,
                    tAmount.div(100).mul(_fundFee8.mul(multiple)),
                    currentRate
                );
                _takeTransfer(
                    sender,
                    fundAddress9,
                    tAmount.div(100).mul(_fundFee9.mul(multiple)),
                    currentRate
                );
                rate = (_fundFee4 + _fundFee5 + _fundFee6 + _fundFee7 + _fundFee8 + _fundFee9).mul(multiple);
            }else{
                _takeTransfer(
                    sender,
                    fundAddress10,
                    tAmount.div(100).mul(_fundFee10.mul(multiple)),
                    currentRate
                );
                rate = _fundFee10.mul(multiple);
            }
        }


        uint256 recipientRate = 100 - rate;
        _rOwned[recipient] = _rOwned[recipient].add(
            rAmount.div(100).mul(recipientRate)
        );
        emit Transfer(sender, recipient, tAmount.div(100).mul(recipientRate));
    }

    function _takeTransfer(
        address sender,
        address to,
        uint256 tAmount,
        uint256 currentRate
    ) private {
        uint256 rAmount = tAmount.mul(currentRate);
        _rOwned[to] = _rOwned[to].add(rAmount);
        emit Transfer(sender, to, tAmount);
    }

    function _takeTransfersub(
        address sender,
        uint256 tAmount,
        uint256 currentRate
    ) private {
        uint256 rAmount = tAmount.mul(currentRate);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
    }

    function _reflectFee(uint256 rFee, uint256 tFee) private {
        _rTotal = _rTotal.sub(rFee);
        _tFeeTotal = _tFeeTotal.add(tFee);
    }

    function _takeInviterFee(
        address sender,
        address recipient,
        uint256 tAmount
    ) private {
        address cur;
        uint256 multiple = 1;

        if (sender == uniswapV2Pair) {
            cur = recipient;
        } else {
            cur = sender;
        }
        cur = inviter[cur];
        for (uint256 i = 1; i <= 8; i++) {
            uint256 rate;

            if (i == 1) {
                rate = 70 * multiple;
            }else if(i == 2) {
                rate = 60 * multiple;
            }else if(i == 3) {
                rate = 50 * multiple;
            }else if(i == 4) {
                rate = 40 * multiple;
            }else if(i == 5) {
                rate = 30 * multiple;
            }else if(i == 6) {
                rate = 20 * multiple;
            }else if(i == 7) {
                rate = 20 * multiple;
            }else{
                rate = 20 * multiple;
            }
            if (cur != address(0)) {
                uint256 curTAmount = tAmount.div(10000).mul(rate);
                // _rOwned[cur] = _rOwned[cur].add(curTAmount);
                // emit Transfer(sender, cur, curTAmount);
                awarder.award(cur, curTAmount);
                cur = inviter[cur];
            }
        }
    }
}