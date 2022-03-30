package com.aws.localstack.awslocalstack.configuration;

import com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Profile;

public class S3Configuration {
    
    @Bean
    @Profile("!dev")
    public AmazonS3 nonDevS3Client() {
        return AmazonS3ClientBuilder.standard()
            .withRegion(Regions.US_EAST_1).build();
    }

    @Bean
    @Profile("dev")
    public AmazonS3 devS3Client() {
        return AmazonS3ClientBuilder.standard()
            .withEndpointConfiguration(
                new EndpointConfiguration("http://localhost:4566", Regions.US_EAST_1.getName()))
            .build();

    }
}
