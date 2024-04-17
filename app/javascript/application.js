import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function() {
  var emailOrPhoneField = document.getElementById('email_or_phone_field');
  var emailField = document.getElementById('ticket_email');
  var phoneField = document.getElementById('ticket_phone');
  var createTicketButton = document.getElementById('create-ticket');
  var ticketForm = document.getElementById('ticket-form-container');
  var newTicketForm = document.getElementById('new-ticket-form');
  var validationMessage = document.getElementById('validation-message');

  // Email or Phone field input event listener
  emailOrPhoneField.addEventListener('input', function() {
    var emailOrPhone = emailOrPhoneField.value;
    if (emailOrPhone.includes('@')) {
      emailField.value = emailOrPhone;
      phoneField.value = '';
    } else {
      phoneField.value = emailOrPhone;
      emailField.value = '';
    }
  });

  // Toggle ticket form display
  createTicketButton.addEventListener('click', function(event) {
    event.preventDefault();
    if (newTicketForm.classList.contains('form-expanded')) {
      newTicketForm.classList.remove('form-expanded');
      ticketForm.style.display = 'none';
      createTicketButton.textContent = 'Create a Ticket'
    } else {
      newTicketForm.classList.add('form-expanded');
      ticketForm.style.display = 'block';
      createTicketButton.textContent = 'Discard Ticket'
      setTimeout(() => {
        ticketForm.style.maxHeight = '1000px';
      }, 10);
    }
  });

  // Form submission validation
  newTicketForm.addEventListener('submit', function(event) {
    event.preventDefault();
    if (emailOrPhoneField && emailOrPhoneField.value.trim() === '') {
      validationMessage.textContent = 'Both fields must be filled in.';
      validationMessage.style.display = 'block';
      emailOrPhoneField.style.borderColor = 'red';
    } else {
      newTicketForm.submit();
    }
  });
});
