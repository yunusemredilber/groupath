function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#imagePreview').css('background-image', 'url('+e.target.result +')');
            $('#imagePreview').hide();
            $('#imagePreview').fadeIn(200);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function listenAvatarUpload() {
    $("#imageUpload").change(function() {
        readURL(this);
    });
}
