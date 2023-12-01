// 共通の関数を定義
const updatePriceDetails = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  // 入力された金額を取得
  const price = parseFloat(priceInput.value) || 0;

  // 販売手数料と販売利益を計算
  const tax = Math.floor(price * 0.1); // 使用例: Math.floorで切り捨て
  const profitAmount = Math.floor(price - tax); // 使用例: Math.floorで切り捨て

  // 計算結果を表示
  addTaxDom.innerHTML = tax.toLocaleString();  // 販売手数料を整数に切り捨てて表示
  profitDom.innerHTML = profitAmount.toLocaleString();  // 販売利益を整数に切り捨てて表示
};

// turbo:load イベント時の処理
document.addEventListener("turbo:load", function() {
  // 初回読み込み時とページ遷移時に共通の処理を実行
  updatePriceDetails();

  const priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", updatePriceDetails);
});

// turbo:render イベント時の処理
document.addEventListener("turbo:render", function() {
  // ページ遷移時にも共通の処理を実行
  updatePriceDetails();

  const priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", updatePriceDetails);
});
