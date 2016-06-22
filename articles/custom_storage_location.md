---
title: "Creating Custom Storage Locations"
layout: article
excerpt: Follow these steps to set up an external S3 bucket and access it with Synapse. 
---

## **Creating a download bucket**

## Steps for adding an external S3 bucket

### Share your bucket with Synapse
First step is to allow Synapse to access your s3 bucket. You can choose to allow read-only access or read-write access. Either way, you have to make sure that objects that are referenced or managed by Synapse are not modified or deleted.

#### 1. Go to **[Amazon Web Services S3 console](https://console.aws.amazon.com/s3)** and login under your account

____


#### 2. Create a new bucket under your account
Click **Create Bucket**

<img src="/assets/images/create-bucket-button.jpg">

And for the bucket name, use a unique name that ends in your company domain. For example synapse-share.yourcompany.com.
For region, _you must select the US Standard region_.

<img src="/assets/images/create-bucket-dialog.jpg">

____


#### 3. Show the permission properties for the new bucket
Select your new bucket and click the **Properties** button to show the new bucket's properties

<img src="/assets/images/select-properties.jpg">

and expand the **Permissions** for the new bucket

<img src="/assets/images/expand-permissions.jpg">

____


#### 4. Add a policy to give Synapse permissions to access your bucket
Click **Add bucket policy**

<img src="/assets/images/click-add-policy.jpg">

and copy one of the below policies. Change the name of resource from "synapse-share.yourcompany.com" to the name of your new bucket (twice) and **Save** the new policy.

For read-write permissions (you allow Synapse to upload and retrieve files)

````json
{
    "Statement": [
        {
            "Action": "s3:ListBucket*",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::synapse-share.yourcompany.com",
            "Principal": { "AWS": "325565585839" }
        },
        {
            "Action": [ "s3:*Object*", "s3:*MultipartUpload*" ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::synapse-share.yourcompany.com/*",
            "Principal": { "AWS": "325565585839" }
        }
    ]
}
````


## **Downloading requester pays data**

Data kept in Synapse that is large enough to have significant download costs, there is a separate method for downloading.
Steps to take:

1. Create a new AWS S3 bucket in the us-east-1 region under your account (see [Creating a download bucket](https://www.synapse.org/#!Synapse:syn3316305/wiki/217751) for details)
2. Use the s3FileCopy API to copy the files to that new bucket
3. Download the files from that new bucket using the AWS tools
4. Don't forget to delete the files from that bucket to avoid paying the associated storage costs



## **External S3 buckets**

## Steps for adding an external S3 bucket

### Share your bucket with Synapse
First step is to allow Synapse to access your s3 bucket. You can choose to allow read-only access or read-write access. Either way, you have to make sure that objects that are referenced or managed by Synapse are not modified or deleted.

#### 1. Go to **[Amazon Web Services S3 console](https://console.aws.amazon.com/s3)** and login under your account

____

#### 2. Create a new bucket under your account
Click **Create Bucket**

<img src="/assets/images/create-bucket-button.jpg">

And for the bucket name, use a unique name that ends in your company domain. For example synapse-share.yourcompany.com.
For region, _you must select the US Standard region_.

<img src="/assets/images/create-bucket-dialog.jpg">

____


#### 3. Show the permission properties for the new bucket
Select your new bucket and click the **Properties** button to show the new bucket's properties

<img src="/assets/images/select-properties.jpg">

and expand the **Permissions** for the new bucket

<img src="/assets/images/expand-permissions.jpg">

____


#### 4. Add a policy to give Synapse permissions to access your bucket
Click **Add bucket policy**

<img src="/assets/images/expand-permissions.jpg">

and copy one of the below policies. Change the name of resource from "synapse-share.yourcompany.com" to the name of your new bucket (twice) and **Save** the new policy.

For read-write permissions (you allow Synapse to upload and retrieve files)

````json
{
    "Statement": [
        {
            "Action": "s3:ListBucket*",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::synapse-share.yourcompany.com",
            "Principal": { "AWS": "325565585839" }
        },
        {
            "Action": [ "s3:*Object*", "s3:*MultipartUpload*" ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::synapse-share.yourcompany.com/*",
            "Principal": { "AWS": "325565585839" }
        }
    ]
}
````

For read-only permissions (you only allow Synapse to read files that you upload to this bucket)

````json
{
    "Statement": [
        {
            "Action": "s3:ListBucket*",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::synapse-share.yourcompany.com",
            "Principal": { "AWS": "325565585839" }
        },
        {
            "Action": [ "s3:GetObject*", "s3:*MultipartUpload*" ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::synapse-share.yourcompany.com/*",
            "Principal": { "AWS": "325565585839" }
        }
    ]
}
````

<img src="/assets/images/policy-dialog-paste.jpg">

____


#### 5. Create an object that proves to the Synapse service that you own this bucket
Open a new file in notepad and type in your synapse user name

<img src="/assets/images/notepad.jpg">

and save the file as **owner.txt**

<img src="/assets/images/save-as-owner.jpg">

click on the new bucket name to open up your new bucket

<img src="/assets/images/select-bucket.jpg">

and click the **Upload** button

<img src="/assets/images/click-upload.jpg">

to show the upload dialog

<img src="/assets/images/upload-dialog.jpg">

click on **Add Files**

<img src="/assets/images/click-add-file.jpg">

and select the **owner.txt** file you created earlier

<img src="/assets/images/select-owner-file.jpg">

click on **Start Upload**

<img src="/assets/images/click-start-upload.jpg">

and wait for the upload to finish

<img src="/assets/images/wait-until-done.jpg">

____


#### 6. Make sure to enable cross-origin resource sharing

In **Properties**, click **Edit CORS configuration**

<img src="/assets/images/edit-cors-config.png">

You will see a popup that looks like this:

<img src="/assets/images/cors-config-confirm.png">

Edit this and save. Make sure your `AllowedOrigin` includes Synapse. For more information, please read: [How Do I Enable CORS on My Bucket?](https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html#how-do-i-enable-cors)
Example CORS content:

```xml
<CORSConfiguration>
    <CORSRule>
        <AllowedOrigin>*</AllowedOrigin>
        <AllowedMethod>GET</AllowedMethod>
        <AllowedMethod>POST</AllowedMethod>
        <AllowedMethod>PUT</AllowedMethod>
        <AllowedMethod>HEAD</AllowedMethod>
        <MaxAgeSeconds>3000</MaxAgeSeconds>
        <AllowedHeader>*</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```

____


### Create a new external s3 upload location setting
Go to your Project/Folder in Synapse, and select Tools->Change Storage Location.

<img src="/assets/images/tools.png">

By default, it uses Synapse storage.  To use the external bucket configured above, select Amazon S3 Bucket and fill in the parameters.

<img src="/assets/images/amazon-s3-bucket.png">

____


## Synapse Proxy for access to restricted filesystem

While Synapse provides physical storage for files (using Amazon's S3), not all data 'in' Synapse is stored on Synapse controlled buckets. For files stored outside of Amazon, an additional proxy is needed to validate the pre-signed URL and then proxy the requested file contents. The primary purpose of this project is to provide such validation and file proxying.  View more information [here](https://github.com/Sage-Bionetworks/file-proxy/wiki) about setting up file-proxy.

### Connecting synapse to the restricted filesystem

You must have a key "your_sftp_key" to allow synapse to interact with the filesystem

```python
import synapseclient
import json
syn = synapseclient.login()
PROJECT = 'syn12345'
destination = {"uploadType":"SFTP", 
               "secretKey":"your_sftp_key", 
               "proxyUrl":"https://your-proxy.prod.sagebase.org", 
               "concreteType":"org.sagebionetworks.repo.model.project.ProxyStorageLocationSettings"}
destination = syn.restPOST('/storageLocation', body=json.dumps(destination))
project_destination ={"concreteType": "org.sagebionetworks.repo.model.project.UploadDestinationListSetting", 
                      "settingsType": "upload"}
project_destination['locations'] = destination['storageLocationId']
project_destination['projectId'] = PROJECT
project_destination = syn.restPOST('/projectSettings', body = json.dumps(project_destination))
```

#### Create a fileHandle

A filehandle is merely a synapse representation of the file, therefore you will have to specify all the metadata below for synapse to recognize it.

```python
import mimetypes
path='/path/to/your/file.txt'
fileType = mimetypes.guess_type(path,strict=False)[0]
fileHandle = {'concreteType': 'org.sagebionetworks.repo.model.file.ProxyFileHandle',
              'fileName'    : os.path.basename(path),
              'contentSize' : "2252439673",
              'filePath' : path,
              'contentType' : fileType,
              'contentMd5' :  '67a3688466ad3f606e2cc7b42df4d4bb',
              'storageLocationId': destination['storageLocationId']}
fileHandle = syn.restPOST('/externalFileHandle/proxy', json.dumps(fileHandle), endpoint=syn.fileHandleEndpoint)
f = synapseclient.File(parentId=PROJECT, dataFileHandleId = fileHandle['id'])
f = syn.store(f)
```
