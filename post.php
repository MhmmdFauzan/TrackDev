<?php 


if($_POST['geolocation']) {
    $ipapi = file_get_contents('http://ip-api.com/json/'. $_POST['ip']);
    $ipapi = json_decode($ipapi);
    var_dump($ipapi);
    $data = [
        'ip'          => $_POST['ip'],
        'latitude'    => $_POST['latitude'],
        'longitude'   => $_POST['longitude'],
        'platform'    => $_POST['platform'],
        'provider'    => $ipapi->isp,
        'country_name'=> $ipapi->country,
        'region'      => $ipapi->city,
        'useragent'   => $_POST['useragent'],
        'geolocation' => $_POST['geolocation'],
        'accepted_geolocation' => $_POST['accepted_geolocation']
    ];
    $open = fopen('data'.'.json', 'w');
    fwrite($open, json_encode($data, JSON_PRETTY_PRINT));
    fclose($open);
}else{
    
}

?>