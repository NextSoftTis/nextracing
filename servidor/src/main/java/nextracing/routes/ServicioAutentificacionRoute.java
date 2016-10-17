/*
 * 
 */
package nextracing.routes;

import org.apache.camel.BeanInject;
import org.apache.camel.model.rest.RestBindingMode;
import org.apache.camel.model.rest.RestPropertyDefinition;
import org.apache.camel.spring.SpringRouteBuilder;
import nextracing.beans.ServicioAutentificacion;
import nextracing.core.rest.UsuarioModel;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Jhonatan Mamani
 */

@Component
public class ServicioAutentificacionRoute extends SpringRouteBuilder {


    @BeanInject("servicioAutentificacion")
    private ServicioAutentificacion servicioAutentificacion;


    @Override
    public void configure() throws Exception {

        restConfiguration().component("jetty")
                .bindingMode(RestBindingMode.json)
                .dataFormatProperty("prettyPrint", "true")
                .enableCORS(true)
                .corsHeaderProperty("Access-Control-Allow-Headers", "Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers, Authorization")
                .port(9999);

        rest("/login").description("Login servicio rest")
                .consumes("application/json").produces("application/json")

                .post().description("Crear un usario").type(UsuarioModel.class)
                .to("bean:servicioAutentificacion?method=login")

                .verb("options").route();
    }
}