// 共通の関数を定義
const updatePriceDetails = () => {
  var priceInput = document.getElementById("item-price");
  var addTaxDom = document.getElementById("add-tax-price");
  var profitDom = document.getElementById("profit");

  // 入力された金額を取得
  var price = parseFloat(priceInput.value) || 0;

  // 販売手数料と販売利益を計算
  var tax = price * 0.1;
  var profitAmount = price - tax;

  // 計算結果を表示
  addTaxDom.innerHTML = Math.round(tax).toLocaleString();  // 販売手数料を整数に四捨五入して表示
  profitDom.innerHTML = Math.round(profitAmount).toLocaleString();  // 販売利益を整数に四捨五入して表示
};

// turbo:load イベント時の処理
document.addEventListener("turbo:load", function() {
  // 初回読み込み時とページ遷移時に共通の処理を実行
  updatePriceDetails();

  var priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", updatePriceDetails);
});

// turbo:render イベント時の処理
document.addEventListener("turbo:render", function() {
  // ページ遷移時にも共通の処理を実行
  updatePriceDetails();

  var priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", updatePriceDetails);
});
