const { freightCostByCep } = require('freight');

describe('Freight computation', () => {
  it('throws an exception if receives an invalid CEP', () => {
    expect(freightCostByCep('11000xxx')).rejects.toEqual('CEP inválido')
  })
})