document.addEventListener('DOMContentLoaded', function () {
    const carousel = document.querySelector('.news-carousel');
    const totalItems = document.querySelectorAll('.news-item').length;
    let currentIndex = 0;

    // Function to go to the next item
    function goToNext() {
        currentIndex = (currentIndex + 1) % totalItems; // Loop back to first item if at the end
        updateCarousel();
    }

    // Function to go to the previous item
    function goToPrevious() {
        currentIndex = (currentIndex - 1 + totalItems) % totalItems; // Loop to last item if at the start
        updateCarousel();
    }

    // Update the carousel's position
    function updateCarousel() {
        carousel.style.transform = `translateX(-${currentIndex * 100}%)`;
    }

    // Set interval to automatically scroll
    setInterval(goToNext, 5000); // Change stories every 5 seconds

    // Optionally, you can add controls for navigation (like previous/next buttons)
    // Here we use arrow keys for example purposes
    document.addEventListener('keydown', function (e) {
        if (e.key === 'ArrowRight') {
            goToNext();
        } else if (e.key === 'ArrowLeft') {
            goToPrevious();
        }
    });
});
