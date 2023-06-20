<?php
function createTempFile($courierInformation)
{
	$shippingUrls = explode('|', $courierInformation['labelPaths']);
	$tempFilePath = tempnam(sys_get_temp_dir(), "courierInfo.ZPL");
	$tempFile = fopen($tempFilePath, 'a+');
	foreach ($shippingUrls as $file) {
		$file = trim($file, " ");
		$fileContent =  file_get_contents($file);
		fwrite($tempFile, file_get_contents($file));
	}
	$courierInformation['labelFile'] = file_get_contents($tempFilePath);
	fclose($tempFile);
	unlink($tempFilePath);
}
