package com.aws.localstack.awslocalstack.services;

import com.amazonaws.services.s3.AmazonS3;

import org.springframework.stereotype.Service;

@Service
public class S3Service {
    
    /*
        TODO: change to v2 sdk client
    */

    private AmazonS3 s3Client;

    public S3Service(AmazonS3 s3Client) {
        this.s3Client = s3Client;
    }

    public void uploadFile() {
        this.s3Client.
    }
}
