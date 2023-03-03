#[contract]
mod GS {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::contract_address_const;
    use starknet::ContractAddressZeroable;
    use array::ArrayTrait;
    use option::OptionTrait;

    struct Storage {
        name: felt,
        symbol: felt,
        decimals: u8,
        total_supply: u256,
        balances: LegacyMap::<ContractAddress, u256>,
        allowances: LegacyMap::<(ContractAddress, ContractAddress), u256>,
        from: ContractAddress,
        to: ContractAddress,
        amount: u64,
        executed: bool,
        owner_count: u32,
        required_signatures: u64,
        owners: Array::<ContractAddress>,
    }

    // #[event]
    // fn Executed(from: ContractAddress, to: ContractAddress, value: u256) {}

    // #[event]
    // fn Approval(owner: ContractAddress, spender: ContractAddress, value: u256) {}

    #[constructor]
    fn constructor(
        _required_signatures: u64,
        initial_owners: Array::<ContractAddress>,
        name_: felt, symbol_: felt, decimals_: u8, initial_supply: u256, recipient: ContractAddress
    ) {
        let len = initial_owners.len();
        owner_count::write(len);
        required_signatures::write(_required_signatures);
        owners::write(initial_owners);
        name::write(name_);
        symbol::write(symbol_);
        decimals::write(decimals_);
        assert(!recipient.is_zero(), 'ERC20: mint to the 0 address');
        total_supply::write(initial_supply);
        balances::write(recipient, initial_supply);
        Transfer(contract_address_const::<0>(), recipient, initial_supply);
    }
}
