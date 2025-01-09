// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "trix"
import "@rails/actiontext"
import Rails from "@rails/ujs";
Rails.start();

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      document.querySelector(this.getAttribute('href')).scrollIntoView({
        behavior: 'smooth'
      });
    });
  });
  
  