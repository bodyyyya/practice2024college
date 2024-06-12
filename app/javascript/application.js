// app/javascript/packs/application.js
import "@hotwired/turbo-rails"
import "controllers"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.start()

document.addEventListener('turbo:load', () => {
  document.addEventListener('ajax:success', (event) => {
    const [data, status, xhr] = event.detail;
    document.getElementById('cart-item-count').innerText = data.total_items;
  });
});
