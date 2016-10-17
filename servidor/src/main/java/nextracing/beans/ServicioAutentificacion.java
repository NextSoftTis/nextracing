/*
 * 
 */
package nextracing.beans;

import nextracing.core.rest.UsuarioModel;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

/**
 * 
 */

@Component
public class ServicioAutentificacion {
    private final Map<Integer, UsuarioModel> usuarios = new TreeMap<>();
    private int autoIncrementoID;


    public ServicioAutentificacion(){
        autoIncrementoID = 1;
    }

    public UsuarioModel login(UsuarioModel usuarioModel){
        UsuarioModel usuario = new UsuarioModel();
        usuario.setId(autoIncrementoID);
        usuario.setNombre(usuarioModel.getNombre());
        usuario.setToken(UUID.randomUUID().toString());
        usuarios.put(autoIncrementoID, usuario);

        autoIncrementoID++;
        return usuario;
    }
}