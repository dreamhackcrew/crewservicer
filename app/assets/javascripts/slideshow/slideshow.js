var Slideshow = new Class({
  initialize: function(intervalTime, slidesUrl) {
    this.previousSlide = null;
    this.currentSlide = null;
    this.nextSlideIndex = null;
    this.slides = [];
    this.slidesUrl = slidesUrl;
    this.interval = null;
    this.intervalTime = intervalTime;

    this.updateSlides();
  },

  nextSlide: function() {
    if (this.slides.length <= 0 || this.nextSlideIndex >= this.slides.length) {
      return;
    }

    if (this.previousSlide) {
      this.previousSlide.destroy();
    }

    if (this.currentSlide) {
      this.previousSlide = this.currentSlide;
      this.previousSlide.removeClass("active");
    }

    this.currentSlide = new Element("article").addClass("slide");
    this.currentSlide.set("html", HandlebarsTemplates["slideshow/slide"](this.slides[this.nextSlideIndex]));
    this.currentSlide.inject(document.body);

    // Delay active class to trigger css transitions
    setTimeout(function() { this.currentSlide.addClass("active"); }.bind(this), 0);

    this.nextSlideIndex++;

    if (this.nextSlideIndex >= this.slides.length) {
      this.updateSlides();
    }
  },

  updateSlides: function() {
    new Request.JSON({
      url: this.slidesUrl,
      onSuccess: this.receiveSlides.bind(this)
    }).get();
  },

  receiveSlides: function(slides) {
    this.nextSlideIndex = 0;
    this.slides = slides;

    if (!this.interval) {
      this.nextSlide();
      this.interval = setInterval(this.nextSlide.bind(this), this.intervalTime);
    }
  }
})
