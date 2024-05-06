let idea;

document.getElementById('ideaInput').addEventListener('change', function(event) {
    // Get the rectangle element
    var rectangle = document.getElementById('rectangle');

    // Change the content of the rectangle element
    rectangle.textContent = event.target.value;

    // Change the text style of the rectangle element
    rectangle.style.color = 'black';
    rectangle.style.fontSize = '17px';
    rectangle.style.fontFamily = 'Inter';
    rectangle.style.fontWeight = '400';
    rectangle.style.lineHeight = '24px';

    // Hide the Dot1, Dot2, Dot3 elements
    document.querySelectorAll('.Dot1, .Dot2, .Dot3').forEach(function(element) {
        if (event.target.value === '') {
            element.style.display = 'block';
        } else {
            element.style.display = 'none';
        }
    });
});