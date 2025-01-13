<template>
  <div>
    <h2>Свяжитесь с нами</h2>
    <form @submit.prevent="submitForm">
      <div class="mb-3">
        <label for="name" class="form-label">Имя</label>
        <input type="text" class="form-control" id="name" v-model="name" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" class="form-control" id="email" v-model="email" required>
      </div>
      <div class="mb-3">
        <label for="message" class="form-label">Сообщение</label>

        <textarea class="form-control" id="message" rows="3" v-model="message" required></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Отправить</button>
    </form>

    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="successModalLabel">Спасибо!</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            Ваше сообщение успешно отправлено.
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable no-undef */
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap/dist/js/bootstrap.js'

export default {
  name: 'ContactComponent',
  data() {
    return {
      name: '',
      email: '',
      message: ''
    }
  },
  methods: {
    submitForm() {
      // Проверка валидности полей
      if (!this.name || !this.email || !this.message) {
        alert('Пожалуйста, заполните все поля формы.');
        return;
      }

      // Отправка формы (можно добавить логику отправки на сервер)
      this.showSuccessModal();
      this.clearForm();
    },
    showSuccessModal() {
      // Показ модального окна об успешной отправке
      const successModal = document.getElementById('successModal');
      const modal = new bootstrap.Modal(successModal);
      modal.show();
    },
    clearForm() {
      // Очистка полей формы
      this.name = '';
      this.email = '';
      this.message = '';
    }
  }
}
</script>
