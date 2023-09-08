import com.bootexample4.products.model.Product;
import com.bootexample4.products.repository.ProductRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class ProductController_getProductById_d22f3ea272_Test {

    @InjectMocks
    private ProductController productController;

    @Mock
    private ProductRepository productRepository;

    @Test
    public void shouldReturnProductWhenFound() {
        // given
        Long id = 1L;
        Product product = new Product();
        product.setId(id);
        product.setName("Product 1");
        when(productRepository.findById(id)).thenReturn(Optional.of(product));

        // when
        ResponseEntity<Product> responseEntity = productController.getProductById(id);

        // then
        assertThat(responseEntity.getStatusCodeValue()).isEqualTo(200);
        assertThat(responseEntity.getBody()).isEqualTo(product);
    }

    @Test
    public void shouldReturnNotFoundWhenProductNotFound() {
        // given
        Long id = 1L;
        when(productRepository.findById(id)).thenReturn(Optional.empty());

        // when
        ResponseEntity<Product> responseEntity = productController.getProductById(id);

        // then
        assertThat(responseEntity.getStatusCodeValue()).isEqualTo(404);
        assertThat(responseEntity.getBody()).isNull();
    }
}
