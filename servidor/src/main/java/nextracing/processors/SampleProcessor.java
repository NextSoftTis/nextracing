package nextracing.processors;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

/**
 * 
 */
@Component
public class SampleProcessor implements Processor {
    @Override
    public void process(Exchange exchange) throws Exception {
        String name = (String) exchange.getIn().getBody();
        exchange.getIn().setBody(name + " Dude");
    }
}
