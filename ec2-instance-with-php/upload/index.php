<?php

        echo file_get_contents('{LAMBDA_FUNCTION_URL}/*');
        //lambda endpoint

?>
<br>
<img src="https://{S3_BUCKET_NAME}.s3-eu-west-1.amazonaws.com/image.png">
<!--image file stored on S3-->
