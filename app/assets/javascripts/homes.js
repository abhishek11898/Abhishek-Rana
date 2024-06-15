jQuery(document).ready(function() {
  scrollingByKeyboard();

  jQuery('.section-3 .nav-bullet, .home-container .sauce-button__content').on('click', function() {
    scrollToSection(this);
  });
});

function scrollToSection($this) {
  $this = jQuery($this);
  var sectionId = $this.data('section');
  var section = jQuery('.' + sectionId)[0];
  jQuery($this).closest('#section-nav').find('.current').removeClass('current');
  jQuery($this).addClass('current');
  section.scrollIntoView({ behavior: 'smooth' });
}

function scrollingByKeyboard() {
  jQuery(document).off('keydown');
  jQuery(document).on('keydown', function(event) {
    var currentSection = jQuery('#section-nav').find('.current');
    var nextSection;

    // Handle ArrowDown and ArrowUp keys
    if (event.key === 'ArrowDown') {
      nextSection = currentSection.parent().next().find('.nav-bullet');
    } else if (event.key === 'ArrowUp') {
      nextSection = currentSection.parent().prev().find('.nav-bullet');
    }

    // If the next section exists, scroll to it
    if (nextSection && nextSection.length) {
      scrollToSection(nextSection);
      console.log('Scrolling to next section');
      event.preventDefault(); // Prevent default scrolling behavior
    }
  });
}
