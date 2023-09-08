// Test generated by RoostGPT for test uploadfilespringboot using AI Type Vertex AI and AI Model code-bison

package com.bootexample4.products.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.ResponseEntity;

import com.bootexample4.products.model.Product;
import com.bootexample4.products.repository.ProductRepository;

@SpringBootTest
public class ProductController_createProduct_36b748883e_Test {

    @Autowired
    private ProductController productController;

    @MockBean
    private ProductRepository productRepository;

    @Test
    public void testCreateProduct_success() {
        Product product = new Product("iPhone 12", 999.99);

        when(productRepository.save(product)).thenReturn(product);

        ResponseEntity<Product> responseEntity = productController.createProduct(product);

        assertEquals(201, responseEntity.getStatusCodeValue());
        assertEquals(product, responseEntity.getBody());
    }

    @Test
    public void testCreateProduct_failure() {
        Product product = new Product("iPhone 12", 999.99);

        when(productRepository.save(product)).thenReturn(null);

        ResponseEntity<Product> responseEntity = productController.createProduct(product);

        assertEquals(500, responseEntity.getStatusCodeValue());
        assertEquals(null, responseEntity.getBody());
    }

}
