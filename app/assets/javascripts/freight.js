async function computeFreight(genId) {
  const input = document.querySelector('input[data-cep]');
  const output = document.querySelector('span[data-freight]');
  const cep = input.value;
  const cepResponse = await fetch('https://api.postmon.com.br/v1/cep/' + cep, { mode: 'cors' });
  const state = (await cepResponse.json()).estado;

  const freightResponse = await fetch(
    `/freights/${state}?generator=${genId}`,
    { Accept: 'application/json' });
  const { cost } = await freightResponse.json();
  output.textContent = cost;
}
