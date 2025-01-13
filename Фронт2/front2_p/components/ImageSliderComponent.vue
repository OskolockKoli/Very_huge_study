<template>
  <div class="image-slider">
    <div class="slider-wrapper">
      <img :src="currentImage" alt="Slide Image">
    </div>
    <div class="slider-controls">
      <button class="btn btn-primary" @click="prevImage">
        <i class="bi bi-chevron-left"></i>
      </button>
      <button class="btn btn-primary" @click="nextImage">
        <i class="bi bi-chevron-right"></i>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ImageSliderComponent',
  data() {
    return {
      images: [
        'https://via.placeholder.com/800x400',
        'https://via.placeholder.com/800x400/0000FF',
        'https://via.placeholder.com/800x400/FF00FF'
      ],
      currentIndex: 0
    }
  },
  computed: {
    currentImage() {
      return this.images[this.currentIndex];
    }
  },
  methods: {
    prevImage() {
      this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length;
    },
    nextImage() {
      this.currentIndex = (this.currentIndex + 1) % this.images.length;
    }
  }
}
</script>

<style>
.image-slider {
  position: relative;
  max-width: 800px;
  margin: 0 auto;
}

.slider-wrapper {
  width: 100%;
  height: 400px;
  overflow: hidden;
}

.slider-wrapper img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.slider-controls {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 100%;
  display: flex;
  justify-content: space-between;
  padding: 0 20px;
}

.slider-controls button {
  font-size: 24px;
}
</style>
