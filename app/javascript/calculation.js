function tax() {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup",() => {
    const taxPrice = parseFloat(itemPrice.value) * 0.1;
    const addPrice = document.getElementById("add-tax-price");
    addPrice.innerHTML = Math.floor(taxPrice);
    const salesPrice = itemPrice.value - taxPrice;
    const profit = document.getElementById("profit")
    profit.innerHTML = Math.floor(salesPrice);
  });
};
window.addEventListener('load',tax);