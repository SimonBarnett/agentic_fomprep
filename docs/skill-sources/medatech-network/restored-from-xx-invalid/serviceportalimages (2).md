# serviceportalimages (2)

- **Source:** `serviceportalimages (2).docx`

Uploading an image to service call remarks in a way that can be viewed on the service call portal

Introduction

When you paste an image into service call remarks it automatically puts the image in the system/mail directory on the Priority server.

The service portal does not have the right permissions to be able to see an image that is on the priority server, therefore if we want an image to be able to be seen by a customer logged in to the service portal, we have to do it in a slightly different way.

Instructions

Save the desired image to O:\

The O drive is fully accessible by the service portal. We may create sub directories in this drive if needed.

Use the image button to insert the image in the service call external dialogue. Do not paste in the image.

Enter the URL for the attachment. This will be something like this if the image is in the O drive:

http://support.medatechuk.com/Medatech/image.jpg

If the image is in a subfolder in the O drive, the URL will be as follows:

http://support.medatechuk.com/Medatech/subfolder/image.jpg
