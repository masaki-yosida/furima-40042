document.addEventListener("DOMContentLoaded", function() {
  var priceInput = document.getElementById("item-price");
  var addTaxDom = document.getElementById("add-tax-price");
  var profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", function() {
    // 入力された金額を取得
    var price = parseFloat(priceInput.value) || 0;

    // 販売手数料と販売利益を計算
    var tax = price * 0.1;
    var profitAmount = price - tax;

    // 計算結果を表示
    addTaxDom.innerHTML = Math.round(tax).toLocaleString() ;  // 販売手数料を整数に四捨五入して表示
    profitDom.innerHTML = Math.round(profitAmount).toLocaleString() ;  // 販売利益を整数に四捨五入して表示
  });
});