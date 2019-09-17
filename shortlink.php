<?php

    function shortlink($url) {
        $get = file_get_contents('http://chat.whatsaqp.com/?url='.$url);
        if(preg_match('/Bad input./', $get)) {
            echo "[-] URL tidak balid";
        }else {
            preg_match("/<a href=\"(.*?)\">(.*?)<\/a>/", $get, $match);
            $data = parse_url($match[1]);
            $link = $data['host'].$data['path'];
            echo $link;
            
        }
    }

    return shortlink($argv[1]);

?>
