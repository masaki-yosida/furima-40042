// app/javascript/pay.js

const initializePayjp = async () => {
  const payjp = Payjp('pk_test_110e141f79fd1c929a961ea3'); // PAY.JPテスト公開鍵
  const elements = payjp.elements();

  // クレジットカード情報の入力フォームを生成
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // 各要素を対応する場所にマウント
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  // フォームが送信されたときのイベントハンドラ
  const form = document.getElementById('charge-form'); // フォームを取得

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const { token, error } = await payjp.createToken(numberElement);

    if (error) {
      console.error('トークンの取得に失敗しました', error);
    } else if (token) {
      // トークンをフォームに追加
      const tokenInput = document.createElement('input');
      tokenInput.type = 'hidden';
      tokenInput.name = 'token';
      tokenInput.value = token.id;
      form.appendChild(tokenInput);

      // クレジットカード情報を非表示にする（セキュリティのため）
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      // トークンを含んだフォームを再度送信
      form.submit();
    }
  });
};

window.addEventListener("turbo:load", initializePayjp);
