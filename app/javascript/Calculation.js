function calculation (){
  const price  = document.getElementById("room-price");
  price.addEventListener("input", () => {
    const fee = price.value * 0.1;
    const fee_value  = document.getElementById("add-tax-price");
    fee_value.innerHTML = `${fee}`;
    const profit = price.value * 0.9;
    const profit_value  = document.getElementById("profit");
    profit_value.innerHTML = `${profit}`;
  });
}

window.addEventListener('load', calculation);