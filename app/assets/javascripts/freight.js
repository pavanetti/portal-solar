async function computeFreight(genId) {
  const input = document.querySelector('input[data-cep]');
  const output = document.querySelector('span[data-freight]');

  try {
    output.textContent = await freightCostByCep(input.value, genId);
  } catch (err) {
    output.textContent = 'CEP inválido. Confira o número digitado.';
  }
}

async function freightCostByCep(cep, genId) {
  validateCep(cep);
  const state = await stateByCep(cep);
  return freightCostbyState(state, genId);
}

function validateCep(cep) {
  const format = /^\d{5}\-?\d{3}$/;
  if (!format.test(cep)) throw 'CEP inválido';
}

async function stateByCep(cep) {
  const cepResponse = await fetch(
    'https://api.postmon.com.br/v1/cep/' + cep,
    { mode: 'cors' }
  );
  const { estado } = await cepResponse.json();
  return estado;
}

async function freightCostbyState(state, genId) {
  const freightResponse = await fetch(
    `/freights/${state}?generator=${genId}`,
    { Accept: 'application/json' });
  const { cost } = await freightResponse.json();
  return cost;
}

module.exports = { freightCostByCep };