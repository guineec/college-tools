<html>
    <head>
        <title>Scalable Computing Practicals - Potfiles</title>
    </head>
    <body style="font-family: sans-serif">
        <h1>Potfiles for Scalable Computing - Index</h1>
        <hr>
        <?php
            $files = glob("*.pot");
            foreach($files as $ind => $file) {
                $display_ind = $ind + 1;
                echo "$display_ind: <a href='/$file'>$file</a><br>";
            }
        ?>
    </body>
</html>