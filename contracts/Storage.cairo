use starknet::StorageAccess;
use starknet::StorageBaseAddress;
use starknet::contract_address::ContractAddress;
use starknet::contract_address::ContractAddressIntoFelt;
use starknet::contract_address::FeltTryIntoContractAddress;
use traits::Into;
use traits::TryInto;
use option::OptionTrait;

impl StorageAccessContractAddress of StorageAccess::<ContractAddress> {
    fn read(
        address_domain: felt, base: StorageBaseAddress
    ) -> Result::<ContractAddress, Array::<felt>> {
        Result::Ok(
            StorageAccess::<felt>::read(
                address_domain, base
            )?.try_into().expect('StorageAccessU64 - non u64')
        )
    }
    #[inline(always)]
    fn write(
        address_domain: felt, base: StorageBaseAddress, value: ContractAddress
    ) -> Result::<(), Array::<felt>> {
        StorageAccess::<felt>::write(address_domain, base, value.into())
    }
}
