import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function() {
  const createTicketButton = document.getElementById('create-ticket');
  const ticketForm = document.getElementById('ticket-form-container');
  const newTicketForm = document.getElementById('new-ticket-form');
  var validationMessage = document.getElementById('validation-message');

  // Ensure elements exist before adding event listeners
  if (createTicketButton) {
    createTicketButton.addEventListener('click', function(event) {
      event.preventDefault();
      // Toggle class and style for form visibility and animation
      if (newTicketForm.classList.contains('form-expanded')) {
        newTicketForm.classList.remove('form-expanded');
        ticketForm.style.display = 'none';
        createTicketButton.textContent = 'Create a Ticket'
      } else {
        newTicketForm.classList.add('form-expanded');
        ticketForm.style.display = 'block'; // Ensure the form is displayed
        createTicketButton.textContent = 'Discard Ticket'
        setTimeout(() => {
          ticketForm.style.maxHeight = '1000px'; // Adjust maxHeight as needed
        }, 10);
      }
    });
  }

  // Check before adding another event listener
  if (newTicketForm) {
    newTicketForm.addEventListener('submit', function(event) {
      event.preventDefault();

      var emailOrPhoneField = document.getElementById('email_or_phone_field');
      if (emailOrPhoneField && emailOrPhoneField.value.trim() === '') {
        validationMessage.textContent = 'Both fields must be filled in.';
        validationMessage.style.display = 'block';
        emailOrPhoneField.style.borderColor = 'red';
      } else {
        newTicketForm.submit();
      }
    });
  }
});