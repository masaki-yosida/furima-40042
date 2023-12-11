const pay = () => {
  const payjp = Payjp('pk_test_110e141f79fd1c929a961ea3'); // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    try {
      const { token } = await payjp.createToken(numberElement);
      const tokenObj = `<input value=${token} name='token' type="hidden">`;

      form.insertAdjacentHTML("beforeend", tokenObj);
      form.submit();
    } catch (error) {
      // エラーハンドリングを追加
      console.error('トークンの生成に失敗しました:', error.message);
    } finally {
      // フォームのクリア処理を追加
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
    }
  });
};

// ページが読み込まれたときに pay 関数を実行
document.addEventListener("DOMContentLoaded", () => {
  pay();
});
