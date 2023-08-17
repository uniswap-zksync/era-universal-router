import JSBI from 'jsbi'
// import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers'
// import { BigintIsh, CurrencyAmount, Token } from '@uniswap/sdk-core'
import { BigintIsh } from '@uniswap/sdk-core'
// import { Pair } from '@uniswap/v2-sdk'
import { FeeAmount } from '@uniswap/v3-sdk'
// import { getV2PoolReserves } from './mainnetForkHelpers'
import { BigNumber } from 'ethers'

// v2
// export const makePair = async (alice: SignerWithAddress, token0: Token, token1: Token) => {
//   const reserves = await getV2PoolReserves(alice, token0, token1)
//   let reserve0: CurrencyAmount<Token> = CurrencyAmount.fromRawAmount(token0, JSBI.BigInt(reserves.reserve0))
//   let reserve1: CurrencyAmount<Token> = CurrencyAmount.fromRawAmount(token1, JSBI.BigInt(reserves.reserve1))
//
//   return new Pair(reserve0, reserve1)
// }

const FEE_SIZE = 3

// v3
export function encodePath(path: string[], fees: FeeAmount[]): string {
  if (path.length != fees.length + 1) {
    throw new Error('path/fee lengths do not match')
  }

  let encoded = '0x'
  for (let i = 0; i < fees.length; i++) {
    // 20 byte encoding of the address
    encoded += path[i].slice(2)
    // 3 byte encoding of the fee
    encoded += fees[i].toString(16).padStart(2 * FEE_SIZE, '0')
  }
  // encode the final token
  encoded += path[path.length - 1].slice(2)

  return encoded.toLowerCase()
}

export function expandTo18Decimals(n: number): BigintIsh {
  return JSBI.BigInt(BigNumber.from(n).mul(BigNumber.from(10).pow(18)).toString())
}