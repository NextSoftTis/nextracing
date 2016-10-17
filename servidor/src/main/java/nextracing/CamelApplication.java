/*
 * 
 */
package nextracing;

import org.apache.camel.spring.javaconfig.Main;
import org.apache.log4j.Logger;

/**
 *  Contiene el inicio a un servicio rest camel.
 *  
 * @author Jhonatan Mamani 
 */

public class CamelApplication {

    private static final Logger logger = Logger.getLogger(CamelApplication.class);

    public static void main(String[] args) throws Exception {
        Main main = new Main();
        main.setConfigClasses(CamelConfig.class.getName());
        try{
            main.run();
        } catch (Exception ex){
            logger.fatal("Camel startup fallida", ex);
        }
    }

}
