const ScrollProducts = {
  mounted() {
    const selector = "#" + this.el.id;
    this.observer = new IntersectionObserver(entries => {
      const entry = entries[0];
      if (entry.isIntersecting) {
        this.pushEventTo(selector, "products-loading", {})
      }
    })
    this.observer.observe(this.el)
  },
  destroyed() {
    this.observer.disconnect();
  }
}

export default ScrollProducts;