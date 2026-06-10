(function (global) {
  const EARN_KEY = "myfirstapp_earnings_v1";
  const CREATOR_KEY = "myfirstapp_creator_v1";
  const OWNER_SECRET = "idris-pancia-2026";

  function load() {
    try {
      const raw = localStorage.getItem(EARN_KEY);
      if (raw) {
        const d = JSON.parse(raw);
        return {
          totalChf: d.totalChf || 0,
          count: d.count || 0,
          payments: Array.isArray(d.payments) ? d.payments : [],
        };
      }
    } catch (_) {}
    return { totalChf: 0, count: 0, payments: [] };
  }

  function save(data) {
    try {
      localStorage.setItem(EARN_KEY, JSON.stringify(data));
    } catch (_) {}
  }

  function isCreator() {
    return (
      localStorage.getItem(CREATOR_KEY) === "1" ||
      localStorage.getItem("pancia_owner_v2") === "1"
    );
  }

  function loginCreator(password) {
    if (password === OWNER_SECRET) {
      localStorage.setItem(CREATOR_KEY, "1");
      localStorage.setItem("pancia_owner_v2", "1");
      return true;
    }
    return false;
  }

  function recordPayment(game, amountChf) {
    const data = load();
    data.totalChf += amountChf;
    data.count += 1;
    data.payments.unshift({
      game: game,
      amountChf: amountChf,
      at: new Date().toISOString(),
    });
    if (data.payments.length > 30) data.payments.length = 30;
    save(data);
    return data;
  }

  function formatChf(n) {
    return n.toLocaleString("it-CH") + " CHF";
  }

  global.MyFirstAppEarnings = {
    load: load,
    save: save,
    isCreator: isCreator,
    loginCreator: loginCreator,
    recordPayment: recordPayment,
    formatChf: formatChf,
    OWNER_SECRET: OWNER_SECRET,
  };
})(window);
