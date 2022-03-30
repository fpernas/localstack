package com.aws.localstack.awslocalstack.rest;

import com.aws.localstack.awslocalstack.services.S3Service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class FileController {
    
    private final S3Service s3Service;

    public FileController(S3Service s3Service) {
        this.s3Service = s3Service;
    }

    @PostMapping("/api/upload")
    public ResponseEntity<?> uploadFile (@RequestParam MultipartFile file) {
        return ResponseEntity.ok().build();
    }
}
