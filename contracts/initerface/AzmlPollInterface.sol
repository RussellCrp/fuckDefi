// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


interface AzmlPollInterface {
    
    /**
     * 存款人执行存款操作 比如存款USDC
     */
    function depositLend(uint256 _pid, uint256 _amount) external;

    /**
     * 借款人质押操作 比如质押 ETH
     */
    function depositBorrow(uint256 _pid, uint256 _amount) external;

    /**
     * 结算
     */
    function settle(uint256 _pid) public;

    /**
     * 退还过量存款给存款人
     */
    function refundLend(uint256 _pid) external;

    /**
     * 退还给借款人的过量存款。
     */
    function refundBorrow(uint256 _pid) external;

    /**
     *  存款人接收 sp_token,主要功能是让存款人领取 sp_token
     */
    function claimLend(uint256 _pid) external;

    /**
     * 借款人接收 sp_token 和贷款资金
     */
    function claimBorrow(uint256 _pid) external;

    /**
     * 完成一个借贷池的操作，包括计算利息、执行交换操作、赎回费用和更新池子状态等步骤。
     */
    function finish(uint256 _pid) public;

    /**
     * 清算
     */
    function liquidate(uint256 _pid) public;

     /**
     * @dev 借款人提取剩余的保证金，这个函数首先检查提取的金额是否大于0，然后销毁相应数量的JPtoken。
     * 接着，它计算JPtoken的份额，并根据池的状态（完成或清算）进行相应的操作。
     * 如果池的状态是完成，它会检查当前时间是否大于结束时间，然后计算赎回金额并进行赎回。
     * 如果池的状态是清算，它会检查当前时间是否大于匹配时间，然后计算赎回金额并进行赎回。
     * @param _pid 是池状态
     * @param _jpAmount 是用户销毁JPtoken的数量
     */
    function withdrawBorrow(uint256 _pid, uint256 _jpAmount ) external;

    /**
     * @dev 存款人取回本金和利息
     * @notice 池的状态可能是完成或清算
     * @param _pid 是池索引
     * @param _spAmount 是销毁的sp数量
     */
    function withdrawLend(uint256 _pid, uint256 _spAmount);

    /**
     * @dev 检查清算条件,它首先获取了池子的基础信息和数据信息，
     * 然后计算了保证金的当前价值和清算阈值，
     * 最后比较了这两个值，如果保证金的当前价值小于清算阈值，那么就满足清算条件，函数返回true，否则返回false。
     * @param _pid 是池子的索引
     */
    function checkoutLiquidate(uint256 _pid) external view returns(bool);


}