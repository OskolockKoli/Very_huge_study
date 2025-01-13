<template>
  <div id="app">
    <NavbarComponent></NavbarComponent>
    <div class="container mt-5">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import NavbarComponent from './components/NavbarComponent.vue'

export default {
  name: 'App',
  components: {
    NavbarComponent
  }
}
</script>

<style>
</style>
