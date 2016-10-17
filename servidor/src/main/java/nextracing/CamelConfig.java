/*
 * 
 */
package nextracing;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.spring.javaconfig.CamelConfiguration;
import nextracing.routes.ServicioAutentificacionRoute;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.List;

/**
 * Contiene la basica configuracion para la aplicacion Camel.
 * 
 * @author Jhonatan Mamani
 */

@Configuration
@ComponentScan(basePackages = "nextracing")
public class CamelConfig extends CamelConfiguration {

    @Autowired
    private ServicioAutentificacionRoute servicioAutentificacionRoute;

    @Override
    public List<RouteBuilder> routes() {
        return Arrays.asList(servicioAutentificacionRoute);
    }
}
