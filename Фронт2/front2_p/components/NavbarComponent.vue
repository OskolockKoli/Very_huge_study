<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="#">Способы коммутации</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <router-link to="/" class="nav-link">Главная</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/commutation" class="nav-link">Коммутация</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/packet" class="nav-link">Коммутация пакетов</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/contact" class="nav-link">Контакты</router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'NavbarComponent'
}
</script>
