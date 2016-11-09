--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.7
-- Dumped by pg_dump version 9.1.1
-- Started on 2012-04-24 17:12:31

SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 5 (class 2615 OID 18672)
-- Name: apoyo; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA apoyo;


--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA apoyo; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA apoyo IS 'Este esquema lo creo rogerex el 8 de abril del 2011 con motivos de mejoramiento del sistema de apoyo administrativo. ';


--
-- TOC entry 785 (class 2612 OID 18675)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

--
-- TOC entry 265 (class 1255 OID 18676)
-- Dependencies: 7 785
-- Name: a_entero(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION a_entero(cadena character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total varchar := length(cadena);
	index integer:= 1;
	aux2 integer;
	aux  text;
begin
	if total<=0
	then return null;
	end if;

	while index <= total loop
		aux := substring(cadena, index, 1);
		aux2 := ascii(aux);	
		-- raise notice 'valor encontrado: %', aux2;
		
		if aux2 < 48 or aux2 > 57 then
			-- raise notice 'retornando';
			return null;
		end if;			
		index := index + 1;

	end loop;
	
	return cadena::integer;
end;
$$;


--
-- TOC entry 267 (class 1255 OID 18677)
-- Dependencies: 7 785
-- Name: capital_profesor(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION capital_profesor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

	NEW.nombre := replace(initcap(replace( NEW.nombre, 'Ñ', '123456')), '123456', 'ñ');
	NEW.apellpa := replace(initcap(replace( NEW.apellpa, 'Ñ', '123456')), '123456', 'ñ');
	NEW.apellma := replace(initcap(replace( NEW.apellma, 'Ñ', '123456')), '123456', 'ñ');
	NEW.cargo := initcap(NEW.cargo);
	RETURN NEW;
END;
$$;


--
-- TOC entry 266 (class 1255 OID 18678)
-- Dependencies: 7 785
-- Name: stringinteger(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION stringinteger(dato character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
                RETURN i + 1;
        END;
$$;


SET search_path = apoyo, pg_catalog;

SET default_with_oids = false;

--
-- TOC entry 141 (class 1259 OID 18679)
-- Dependencies: 5
-- Name: variable; Type: TABLE; Schema: apoyo; Owner: -
--

CREATE TABLE variable (
    id_variable integer NOT NULL,
    nombre_variable character varying(64) NOT NULL,
    valor_variable character varying(64) NOT NULL
);


SET search_path = public, pg_catalog;

--
-- TOC entry 142 (class 1259 OID 18682)
-- Dependencies: 7
-- Name: actividad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE actividad (
    id character varying(15) NOT NULL,
    nombre character varying(200),
    estado character varying(15) NOT NULL,
    fk_cargo character varying(15)
);


--
-- TOC entry 145 (class 1259 OID 18692)
-- Dependencies: 2117 2118 7
-- Name: autoridad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE autoridad (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    apellpa character varying(100) NOT NULL,
    apellma character varying(100),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    ini_gestion date DEFAULT ('now'::text)::date,
    fin_gestion date,
    fk_cargo character varying(15),
    sexo character varying(5),
    titulo character varying(20),
    grado_firma character varying(20)
);


--
-- TOC entry 146 (class 1259 OID 18697)
-- Dependencies: 2119 2120 2121 7
-- Name: aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aux (
    id character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    ape_pat character varying(40) NOT NULL,
    ape_mat character varying(40),
    ci character varying(20),
    gestion1 character varying(8),
    gestion2 character varying(8),
    tipo integer DEFAULT 0,
    estado character varying(10) DEFAULT 'ACTIVO'::character varying,
    fecha_estado date DEFAULT ('now'::text)::date
);


--
-- TOC entry 147 (class 1259 OID 18703)
-- Dependencies: 7
-- Name: auxiliar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE auxiliar (
    id character varying(15) NOT NULL,
    ci character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellpa character varying(40) NOT NULL,
    apellma character varying(40),
    tipo character varying(25) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 148 (class 1259 OID 18706)
-- Dependencies: 7
-- Name: auxiliar_ext; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE auxiliar_ext (
    fk_auxiliar character varying(15) NOT NULL,
    email character varying(150),
    telefono character varying(35)
);


--
-- TOC entry 149 (class 1259 OID 18709)
-- Dependencies: 7
-- Name: auxiliatura; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE auxiliatura (
    id character varying(15) NOT NULL,
    docencia character varying(10),
    investigacion character varying(10),
    laboratorio character varying(10),
    interaccion character varying(10),
    servicios character varying(10),
    fk_nombra_aux character varying(15)
);


--
-- TOC entry 150 (class 1259 OID 18712)
-- Dependencies: 7
-- Name: bibliografia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bibliografia (
    id character varying(15) NOT NULL,
    nombre_autor character varying(150) NOT NULL,
    titulo character varying(150) NOT NULL,
    editorial character varying(100),
    detalles character varying(180),
    fk_programa character varying(15)
);


--
-- TOC entry 152 (class 1259 OID 18719)
-- Dependencies: 2123 7
-- Name: car_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE car_aux (
    id character varying(15) NOT NULL,
    gestion character varying(10) NOT NULL,
    fk_auxiliar character varying(15) NOT NULL,
    fk_cargo character varying(15) NOT NULL,
    estado character varying(10),
    fecha_mod date DEFAULT ('now'::text)::date,
    carga_horaria character varying(20)
);


--
-- TOC entry 153 (class 1259 OID 18723)
-- Dependencies: 2124 7
-- Name: cargo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cargo (
    id character varying(15) NOT NULL,
    nombre character varying(150) NOT NULL,
    tipo character varying(15),
    carga_horaria character varying(15) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    fk_laboratorio character varying(15)
);


--
-- TOC entry 154 (class 1259 OID 18727)
-- Dependencies: 7
-- Name: carrera; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE carrera (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    sigla character varying(20) NOT NULL,
    facultad character varying(150),
    depto character varying(100)
);


--
-- TOC entry 155 (class 1259 OID 18730)
-- Dependencies: 2125 7
-- Name: carta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE carta (
    id character varying(15) NOT NULL,
    cod_archivo character varying(15),
    fecha date DEFAULT ('now'::text)::date,
    fk_estandarc character varying(15)
);


--
-- TOC entry 156 (class 1259 OID 18734)
-- Dependencies: 7
-- Name: carta_dest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE carta_dest (
    fk_docente character varying(15),
    fk_destinatario character varying(15),
    fk_carta character varying(15)
);


--
-- TOC entry 157 (class 1259 OID 18737)
-- Dependencies: 2126 7
-- Name: catalogo_curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE catalogo_curso (
    id character varying(6) NOT NULL,
    curso character varying(100) NOT NULL,
    fk_categoria_curso character varying(6) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 158 (class 1259 OID 18741)
-- Dependencies: 7
-- Name: categoria_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categoria_aux (
    id character varying(15) NOT NULL,
    interno character varying(10),
    titular character varying(10),
    fk_nombra_aux character varying(15)
);


--
-- TOC entry 159 (class 1259 OID 18744)
-- Dependencies: 2127 7
-- Name: categoria_curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categoria_curso (
    id character varying(6) NOT NULL,
    nombre character varying(100) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 160 (class 1259 OID 18748)
-- Dependencies: 7
-- Name: categoria_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categoria_doc (
    id character varying(15) NOT NULL,
    interno character varying(10),
    invitado character varying(10),
    asistentea character varying(10),
    adjuntob character varying(10),
    catedraticoc character varying(10),
    fk_nombra_doc character varying(15)
);


--
-- TOC entry 161 (class 1259 OID 18751)
-- Dependencies: 2128 7
-- Name: certificado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE certificado (
    id character varying(15) NOT NULL,
    fecha_emis date DEFAULT ('now'::text)::date,
    fk_aux character varying(15),
    fk_autoridad character varying(15)
);


--
-- TOC entry 162 (class 1259 OID 18755)
-- Dependencies: 7
-- Name: combo_box; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE combo_box (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo character varying(10)
);


--
-- TOC entry 163 (class 1259 OID 18758)
-- Dependencies: 7
-- Name: cprol; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cprol (
    id character varying(9) NOT NULL,
    nombre character varying(35) NOT NULL,
    descripcion character varying(60),
    estado character varying(10) NOT NULL
);


--
-- TOC entry 164 (class 1259 OID 18761)
-- Dependencies: 7
-- Name: cproles_usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cproles_usuario (
    fk_id_usr character varying(10) NOT NULL,
    fk_id_rol character varying(9) NOT NULL
);


--
-- TOC entry 165 (class 1259 OID 18764)
-- Dependencies: 7
-- Name: cptarea; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cptarea (
    id character varying(9) NOT NULL,
    nombre character varying(35) NOT NULL,
    descripcion character varying(60),
    estado character varying(10) NOT NULL
);


--
-- TOC entry 166 (class 1259 OID 18767)
-- Dependencies: 7
-- Name: cptareas_rol; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cptareas_rol (
    fk_id_rol character varying(9) NOT NULL,
    fk_id_tarea character varying(9) NOT NULL
);


--
-- TOC entry 167 (class 1259 OID 18770)
-- Dependencies: 7
-- Name: curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE curso (
    id character varying(15) NOT NULL,
    nombre character varying(100),
    hora_ini time without time zone,
    hora_fin time without time zone,
    fecha_ini date,
    total_horas character varying(10),
    grupo character varying(10),
    costo character varying(10),
    moneda character varying(10),
    periodo character varying(50),
    nota_aprob character varying(3),
    estado character varying(10),
    obs character varying(100),
    fk_profesor character varying(10),
    fecha_fin date,
    nivel_curso character varying(50),
    certificado character varying(3),
    fk_catalogo_curso character varying(6) NOT NULL,
    fk_temp_calendario integer
);


--
-- TOC entry 168 (class 1259 OID 18773)
-- Dependencies: 7
-- Name: destinatario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE destinatario (
    id character varying(15) NOT NULL,
    titulo character varying(50),
    nombre character varying(150),
    cargo character varying(100),
    facultad character varying(100),
    ciudad character varying(100)
);


--
-- TOC entry 169 (class 1259 OID 18776)
-- Dependencies: 7
-- Name: detalle_reserva; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE detalle_reserva (
    id character varying(50) NOT NULL,
    fecha date NOT NULL,
    fk_dia_res character varying(6) NOT NULL,
    fk_rango_res character varying(6) NOT NULL,
    fk_semana_res character varying(6) NOT NULL,
    fk_reserva character varying(50) NOT NULL,
    grupo_rango character varying(50) NOT NULL
);


--
-- TOC entry 170 (class 1259 OID 18779)
-- Dependencies: 7
-- Name: dia_res; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dia_res (
    id character varying(6) NOT NULL,
    nombre character(10) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 171 (class 1259 OID 18782)
-- Dependencies: 2129 7
-- Name: docente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE docente (
    id character varying(15) NOT NULL,
    ci character varying(15),
    nombre character varying(50) NOT NULL,
    apellpa character varying(40) NOT NULL,
    apellma character varying(40),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL,
    titulo character varying(100),
    tiempo character varying(50),
    diploma character varying(50)
);


--
-- TOC entry 172 (class 1259 OID 18786)
-- Dependencies: 2130 7
-- Name: empresa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE empresa (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying
);


--
-- TOC entry 173 (class 1259 OID 18790)
-- Dependencies: 2131 7
-- Name: estandarc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE estandarc (
    id character varying(15) NOT NULL,
    ref character varying(150) NOT NULL,
    dirigido character varying(100) NOT NULL,
    cuerpo character varying(1000) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying
);


--
-- TOC entry 174 (class 1259 OID 18794)
-- Dependencies: 7
-- Name: gestion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gestion (
    id character varying(15) NOT NULL,
    gestion character varying(10),
    fecha_ini date,
    fecha_fin date,
    estado character varying(15)
);


--
-- TOC entry 175 (class 1259 OID 18797)
-- Dependencies: 7
-- Name: hist_auxiliatura; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_auxiliatura (
    id character varying(15) NOT NULL,
    docencia character varying(10),
    investigacion character varying(10),
    laboratorio character varying(10),
    interaccion character varying(10),
    servicios character varying(10),
    fk_nombra_aux character varying(15)
);


--
-- TOC entry 176 (class 1259 OID 18800)
-- Dependencies: 7
-- Name: hist_categoria_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_categoria_doc (
    id character varying(15) NOT NULL,
    interno character varying(10),
    invitado character varying(10),
    asistentea character varying(10),
    adjuntob character varying(10),
    catedraticoc character varying(10),
    fk_nombra_doc character varying(15)
);


--
-- TOC entry 177 (class 1259 OID 18803)
-- Dependencies: 7
-- Name: hist_horario_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_horario_aux (
    id character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    gestion character varying(10),
    rango_ini character varying(10),
    rango_fin character varying(10),
    sigla_lab character varying(10),
    fk_materia_labo character varying(15),
    fk_materia_dicta character varying(15),
    fk_materia_labo1 character varying(15)
);


--
-- TOC entry 178 (class 1259 OID 18806)
-- Dependencies: 7
-- Name: hist_horario_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_horario_doc (
    id character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    gestion character varying(10),
    rango_ini character varying(10),
    rango_fin character varying(10),
    fk_materia_dicta character varying(15),
    fk_materia_dicta1 character varying(15)
);


--
-- TOC entry 179 (class 1259 OID 18809)
-- Dependencies: 7
-- Name: hist_materia_dicta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_materia_dicta (
    id character varying(15) NOT NULL,
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    tipo character varying(100),
    gestion character varying(10),
    exclu integer,
    hor_auto integer,
    fk_segui_doc character varying(15),
    fk_nombra_doc character varying(15),
    fk_materia character varying(25)
);


--
-- TOC entry 180 (class 1259 OID 18812)
-- Dependencies: 7
-- Name: hist_materia_labo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_materia_labo (
    id character varying(15) NOT NULL,
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    gestion character varying(10),
    sigla_lab character varying(10),
    tipo character varying(10),
    fk_segui_aux character varying(15),
    fk_nombra_aux character varying(15),
    fk_materia character varying(15),
    fk_laboratorio character varying(15)
);


--
-- TOC entry 181 (class 1259 OID 18815)
-- Dependencies: 7
-- Name: hist_nombra_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_nombra_aux (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    carrera character varying(100) NOT NULL,
    departamento character varying(50) NOT NULL,
    facultad character varying(50) NOT NULL,
    tiempo character varying(20) NOT NULL,
    fecha_nom date NOT NULL,
    fecha_sol date,
    duracion character varying(20),
    gestion character varying(10),
    hrs_sem integer,
    fk_auxiliar character varying(15)
);


--
-- TOC entry 182 (class 1259 OID 18818)
-- Dependencies: 7
-- Name: hist_nombra_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_nombra_doc (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    carrera character varying(100) NOT NULL,
    departamento character varying(50) NOT NULL,
    facultad character varying(50) NOT NULL,
    diploma character varying(50) NOT NULL,
    titulo character varying(50) NOT NULL,
    tiempo character varying(20) NOT NULL,
    fecha_nom date NOT NULL,
    fecha_sol date,
    duracion character varying(20) NOT NULL,
    gestion character varying(10),
    hrs_sem integer,
    fk_docente character varying(15)
);


--
-- TOC entry 183 (class 1259 OID 18821)
-- Dependencies: 7
-- Name: hist_segui_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_segui_aux (
    id character varying(15) NOT NULL,
    ape_esposo character varying(50),
    asist character varying(10),
    adj character varying(10),
    cat character varying(10),
    aux_doc character varying(10),
    otro_cargo character varying(100),
    hrs_teor character varying(5),
    hrs_inves character varying(5),
    hrs_ext character varying(5),
    hrs_ser character varying(5),
    hrs_prac character varying(5),
    rcfn1 character varying(5),
    rcfn2 character varying(5),
    rcfn3 character varying(5),
    hrs_prod character varying(5),
    hrs_serv character varying(5),
    hrs_prod_acad character varying(5),
    hrs_adm_acad character varying(5),
    rcfn4 character varying(5),
    rcfn5 character varying(5),
    rcfn6 character varying(5),
    rcfn7 character varying(5),
    hrs_trab_sem character varying(5),
    hrs_trab_mes character varying(5),
    hrs_auto character varying(5),
    tiempo_par character varying(5),
    dedi_exclu character varying(5),
    gestion character varying(10),
    obs character varying(200),
    fk_auxiliar character varying(15)
);


--
-- TOC entry 184 (class 1259 OID 18824)
-- Dependencies: 7
-- Name: hist_segui_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hist_segui_doc (
    id character varying(15) NOT NULL,
    ape_esposo character varying(50),
    asist character varying(10),
    adj character varying(10),
    cat character varying(10),
    aux_doc character varying(10),
    otro_cargo character varying(100),
    hrs_teor character varying(5),
    hrs_inves character varying(5),
    hrs_ext character varying(5),
    hrs_ser character varying(5),
    hrs_prac character varying(5),
    rcfn1 character varying(5),
    rcfn2 character varying(5),
    rcfn3 character varying(5),
    hrs_prod character varying(5),
    hrs_serv character varying(5),
    hrs_prod_acad character varying(5),
    hrs_adm_acad character varying(5),
    rcfn4 character varying(5),
    rcfn5 character varying(5),
    rcfn6 character varying(5),
    rcfn7 character varying(5),
    hrs_trab_sem character varying(5),
    hrs_trab_mes character varying(5),
    hrs_auto character varying(5),
    tiempo_par character varying(5),
    dedi_exclu character varying(5),
    gestion character varying(10),
    obs character varying(15),
    fk_docente character varying(15)
);


--
-- TOC entry 185 (class 1259 OID 18827)
-- Dependencies: 7
-- Name: historico; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE historico (
    fecha date,
    gestion character varying(10),
    ges_creacion character varying(10)
);


--
-- TOC entry 186 (class 1259 OID 18830)
-- Dependencies: 7
-- Name: horario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE horario (
    referencia character varying(10),
    dia character varying(10),
    hra_ini time without time zone,
    hra_fin time without time zone
);


--
-- TOC entry 187 (class 1259 OID 18833)
-- Dependencies: 7
-- Name: horario_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE horario_aux (
    id character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2),
    aula character varying(5),
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    gestion character varying(10),
    estado character varying(15),
    sigla_lab character varying(10),
    fk_materia_labo character varying(15),
    fk_materia_dicta character varying(15),
    fk_materia_labo1 character varying(15)
);


--
-- TOC entry 188 (class 1259 OID 18836)
-- Dependencies: 7
-- Name: horario_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE horario_doc (
    id character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    gestion character varying(10),
    estado character varying(15),
    fk_materia_dicta character varying(15),
    fk_materia_dicta1 character varying(15)
);


--
-- TOC entry 189 (class 1259 OID 18839)
-- Dependencies: 2132 7
-- Name: horario_rangos_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE horario_rangos_aux (
    hor_ini time without time zone NOT NULL,
    hor_fin time without time zone NOT NULL,
    rango_ini character varying(10),
    rango_fin character varying(10),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    gestion character varying(10),
    fk_horario_aux character varying(15)
);


--
-- TOC entry 190 (class 1259 OID 18843)
-- Dependencies: 2133 7
-- Name: horario_rangos_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE horario_rangos_doc (
    hor_ini time without time zone NOT NULL,
    hor_fin time without time zone NOT NULL,
    rango_ini character varying(10),
    rango_fin character varying(10),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    gestion character varying(10),
    fk_horario_doc character varying(15)
);


--
-- TOC entry 191 (class 1259 OID 18847)
-- Dependencies: 2134 7
-- Name: horas_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE horas_aux (
    id character varying(15) NOT NULL,
    rango_ini time without time zone NOT NULL,
    rango_fin time without time zone NOT NULL,
    tipo character varying(10),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 192 (class 1259 OID 18851)
-- Dependencies: 2135 7
-- Name: horas_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE horas_doc (
    id character varying(15) NOT NULL,
    rango_ini time without time zone NOT NULL,
    rango_fin time without time zone NOT NULL,
    tipo character varying(10),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 193 (class 1259 OID 18855)
-- Dependencies: 7
-- Name: inscritos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inscritos (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    apellpa character varying(50) NOT NULL,
    apellma character varying(50),
    ci character varying(15)
);


--
-- TOC entry 194 (class 1259 OID 18858)
-- Dependencies: 7
-- Name: institucion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE institucion (
    id character varying(10) NOT NULL,
    nombre character varying(50) NOT NULL,
    direccion character varying(50),
    telefono character varying(20),
    estado character varying(10)
);


--
-- TOC entry 195 (class 1259 OID 18861)
-- Dependencies: 2136 2137 7
-- Name: laboratorio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE laboratorio (
    id character varying(15) NOT NULL,
    descrip character varying(100) NOT NULL,
    sigla character varying(10) NOT NULL,
    estado character varying(10) DEFAULT 'ACTIVO'::character varying,
    fecha_estado date DEFAULT ('now'::text)::date
);


--
-- TOC entry 196 (class 1259 OID 18866)
-- Dependencies: 2138 7
-- Name: materia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE materia (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    sigla character varying(30) NOT NULL,
    tipo character varying(30) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL,
    seg_nom character varying(10) NOT NULL,
    nivel character varying(3),
    acronimo character varying(15)
);


--
-- TOC entry 197 (class 1259 OID 18870)
-- Dependencies: 7
-- Name: materia_dicta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE materia_dicta (
    id character varying(15) NOT NULL,
    cod_nom character varying(10),
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    tipo character varying(100),
    estado character varying(15),
    gestion character varying(10),
    exclu integer,
    hor_auto integer,
    fk_segui_doc character varying(15),
    fk_nombra_doc character varying(15),
    fk_materia character varying(15),
    grupo character varying(2)
);


--
-- TOC entry 198 (class 1259 OID 18873)
-- Dependencies: 7
-- Name: materia_labo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE materia_labo (
    id character varying(15) NOT NULL,
    cod_nom character varying(10),
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    estado character varying(15),
    gestion character varying(10),
    sigla_lab character varying(10),
    tipo character varying(10),
    fk_segui_aux character varying(15),
    fk_nombra_aux character varying(15),
    fk_materia character varying(15),
    fk_laboratorio character varying(15),
    grupo character varying(2)
);


--
-- TOC entry 199 (class 1259 OID 18876)
-- Dependencies: 7
-- Name: mes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mes (
    num character varying(20),
    nombre character varying(10)
);


--
-- TOC entry 200 (class 1259 OID 18879)
-- Dependencies: 7
-- Name: nombra_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE nombra_aux (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    carrera character varying(100) NOT NULL,
    departamento character varying(50) NOT NULL,
    facultad character varying(50) NOT NULL,
    tiempo character varying(20) NOT NULL,
    fecha_nom date NOT NULL,
    fecha_sol date,
    duracion character varying(20),
    gestion character varying(10),
    hrs_sem integer,
    estado character varying(15),
    fk_auxiliar character varying(15)
);


--
-- TOC entry 201 (class 1259 OID 18882)
-- Dependencies: 7
-- Name: nombra_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE nombra_doc (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    carrera character varying(100) NOT NULL,
    departamento character varying(50) NOT NULL,
    facultad character varying(50) NOT NULL,
    diploma character varying(50) NOT NULL,
    titulo character varying(50) NOT NULL,
    tiempo character varying(20) NOT NULL,
    fecha_nom date NOT NULL,
    fecha_sol date,
    duracion character varying(20) NOT NULL,
    gestion character varying(10),
    hrs_sem integer,
    estado character varying(15),
    fk_docente character varying(15)
);


--
-- TOC entry 202 (class 1259 OID 18885)
-- Dependencies: 7
-- Name: nota; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE nota (
    calif character varying(3) NOT NULL,
    fk_curso character varying(15) NOT NULL,
    fk_inscritos character varying(15) NOT NULL,
    nro_faltas character varying(10),
    descuento_n character varying(30),
    concepto_desc_n character varying(150),
    cancelado_n character varying(10),
    est_cuenta_n character varying(20),
    obs_n character varying(100)
);


--
-- TOC entry 203 (class 1259 OID 18888)
-- Dependencies: 7
-- Name: pga_diagrams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pga_diagrams (
    diagramname character varying(64) NOT NULL,
    diagramtables text,
    diagramlinks text
);


--
-- TOC entry 204 (class 1259 OID 18894)
-- Dependencies: 7
-- Name: pga_forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pga_forms (
    formname character varying(64) NOT NULL,
    formsource text
);


--
-- TOC entry 205 (class 1259 OID 18900)
-- Dependencies: 7
-- Name: pga_graphs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pga_graphs (
    graphname character varying(64) NOT NULL,
    graphsource text,
    graphcode text
);


--
-- TOC entry 206 (class 1259 OID 18906)
-- Dependencies: 7
-- Name: pga_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pga_images (
    imagename character varying(64) NOT NULL,
    imagesource text
);


--
-- TOC entry 207 (class 1259 OID 18912)
-- Dependencies: 7
-- Name: pga_layout; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pga_layout (
    tablename character varying(64) NOT NULL,
    nrcols smallint,
    colnames text,
    colwidth text
);


--
-- TOC entry 208 (class 1259 OID 18918)
-- Dependencies: 7
-- Name: pga_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pga_queries (
    queryname character varying(64) NOT NULL,
    querytype character(1),
    querycommand text,
    querytables text,
    querylinks text,
    queryresults text,
    querycomments text
);


--
-- TOC entry 209 (class 1259 OID 18924)
-- Dependencies: 7
-- Name: pga_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pga_reports (
    reportname character varying(64) NOT NULL,
    reportsource text,
    reportbody text,
    reportprocs text,
    reportoptions text
);


--
-- TOC entry 210 (class 1259 OID 18930)
-- Dependencies: 7
-- Name: pga_scripts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pga_scripts (
    scriptname character varying(64) NOT NULL,
    scriptsource text
);


--
-- TOC entry 211 (class 1259 OID 18936)
-- Dependencies: 7
-- Name: plan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE plan (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    fecha_ini date,
    fecha_fin date,
    estado character varying(15) NOT NULL,
    fk_carrera character varying(15),
    id_sis character varying(25)
);


--
-- TOC entry 212 (class 1259 OID 18939)
-- Dependencies: 7
-- Name: plan_mat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE plan_mat (
    id character varying(15) NOT NULL,
    fk_plan character varying(15),
    fk_materia character varying(15)
);


--
-- TOC entry 213 (class 1259 OID 18942)
-- Dependencies: 7
-- Name: prerequisito; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE prerequisito (
    fk_materia character varying(15),
    fk_pre_materia character varying(15)
);

--
-- TOC entry 215 (class 1259 OID 18951)
-- Dependencies: 7
-- Name: profesor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE profesor (
    id character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    apellpa character varying(50) NOT NULL,
    apellma character varying(50),
    estado character varying(10),
    obs character varying(100),
    cargo character varying(50),
    sexo character varying(2),
    telefono character varying(15),
    direccion character varying(50),
    ci character varying(10)
);


--
-- TOC entry 216 (class 1259 OID 18954)
-- Dependencies: 2142 7
-- Name: programa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE programa (
    id character varying(15) NOT NULL,
    facultad character varying(50) NOT NULL,
    periodo character varying(20) NOT NULL,
    carga_horaria character varying(20) NOT NULL,
    estado character varying(10) DEFAULT 'ACTIVO'::character varying,
    fk_materia character varying(15)
);


--
-- TOC entry 217 (class 1259 OID 18958)
-- Dependencies: 7
-- Name: rango_res; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rango_res (
    id character varying(6) NOT NULL,
    hora_ini character varying(50) NOT NULL,
    hora_fin character varying(50) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 18961)
-- Dependencies: 7
-- Name: remitente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE remitente (
    fk_cargo character varying(15),
    fk_estandar character varying(15)
);


--
-- TOC entry 219 (class 1259 OID 18964)
-- Dependencies: 7
-- Name: reserva; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE reserva (
    id character varying(50) NOT NULL,
    asunto character varying(50) NOT NULL,
    fecha_ini date NOT NULL,
    fecha_fin date NOT NULL,
    cant_equi character varying(50) NOT NULL,
    responsable character varying(200),
    observaciones character varying(150) NOT NULL,
    estado character varying(15) NOT NULL,
    pasa_sabados character varying(10) NOT NULL,
    costo_reserva character varying(50) NOT NULL,
    moneda character varying(10) NOT NULL,
    horario_fijo character varying(10) NOT NULL,
    fk_sala character varying(6) NOT NULL,
    fk_curso character varying(50) NOT NULL,
    fk_materia character varying(50),
    fk_institucion character varying(10),
    concepto character varying(255) NOT NULL,
    telefono_resp character varying(20),
    dir_resp character varying(50)
);


--
-- TOC entry 220 (class 1259 OID 18967)
-- Dependencies: 7
-- Name: sala; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sala (
    id character varying(6) NOT NULL,
    nombre character varying(50) NOT NULL,
    cant_equi character varying(50) NOT NULL,
    descrip character varying(50) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 18970)
-- Dependencies: 7
-- Name: segui_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE segui_aux (
    id character varying(15) NOT NULL,
    ape_esposo character varying(50),
    asist character varying(10),
    adj character varying(10),
    cat character varying(10),
    aux_doc character varying(10),
    otro_cargo character varying(100),
    hrs_teor character varying(5),
    hrs_inves character varying(5),
    hrs_ext character varying(5),
    hrs_ser character varying(5),
    hrs_prac character varying(5),
    rcfn1 character varying(5),
    rcfn2 character varying(5),
    rcfn3 character varying(5),
    hrs_prod character varying(5),
    hrs_serv character varying(5),
    hrs_prod_acad character varying(5),
    hrs_adm_acad character varying(5),
    rcfn4 character varying(5),
    rcfn5 character varying(5),
    rcfn6 character varying(5),
    rcfn7 character varying(5),
    hrs_trab_sem character varying(5),
    hrs_trab_mes character varying(5),
    hrs_auto character varying(5),
    tiempo_par character varying(5),
    dedi_exclu character varying(5),
    gestion character varying(10),
    obs character varying(200),
    fk_auxiliar character varying(15),
    estado character varying(15)
);


--
-- TOC entry 222 (class 1259 OID 18973)
-- Dependencies: 7
-- Name: segui_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE segui_doc (
    id character varying(15) NOT NULL,
    ape_esposo character varying(50),
    asist character varying(10),
    adj character varying(10),
    cat character varying(10),
    aux_doc character varying(10),
    otro_cargo character varying(100),
    hrs_teor character varying(5),
    hrs_inves character varying(5),
    hrs_ext character varying(5),
    hrs_ser character varying(5),
    hrs_prac character varying(5),
    rcfn1 character varying(5),
    rcfn2 character varying(5),
    rcfn3 character varying(5),
    hrs_prod character varying(5),
    hrs_serv character varying(5),
    hrs_prod_acad character varying(5),
    hrs_adm_acad character varying(5),
    rcfn4 character varying(5),
    rcfn5 character varying(5),
    rcfn6 character varying(5),
    rcfn7 character varying(5),
    hrs_trab_sem character varying(5),
    hrs_trab_mes character varying(5),
    hrs_auto character varying(5),
    tiempo_par character varying(5),
    dedi_exclu character varying(5),
    gestion character varying(10),
    obs character varying(15),
    fk_docente character varying(15),
    estado character varying(15)
);


--
-- TOC entry 223 (class 1259 OID 18976)
-- Dependencies: 7
-- Name: segui_exclu_auto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE segui_exclu_auto (
    id character varying(15) NOT NULL,
    caso character varying(15),
    tipo character varying(15),
    nombre character varying(26),
    hora_ini time without time zone NOT NULL,
    rango_ini character varying(15),
    hora_fin time without time zone NOT NULL,
    rango_fin character varying(15),
    estado character varying(15),
    fk_segui_doc character varying(15)
);


--
-- TOC entry 224 (class 1259 OID 18979)
-- Dependencies: 2143 7
-- Name: sesion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sesion (
    id character varying(15) NOT NULL,
    fk_usuario character varying(15) NOT NULL,
    fecha timestamp without time zone DEFAULT ('now'::text)::timestamp(6) with time zone
);


--
-- TOC entry 225 (class 1259 OID 18983)
-- Dependencies: 7
-- Name: tabla_horario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tabla_horario (
    rango character varying(50) NOT NULL,
    grupo character varying(50) NOT NULL,
    lunes character varying(50),
    martes character varying(50),
    miercoles character varying(50),
    jueves character varying(50),
    viernes character varying(50),
    sabado character varying(50),
    estado character varying(15) NOT NULL,
    fk_materia_dicta character varying(20) NOT NULL,
    fk_sesion character varying(15)
);


--
-- TOC entry 226 (class 1259 OID 18986)
-- Dependencies: 7
-- Name: tabla_horario_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tabla_horario_aux (
    rango character varying(50) NOT NULL,
    grupo character varying(50) NOT NULL,
    lunes character varying(50),
    martes character varying(50),
    miercoles character varying(50),
    jueves character varying(50),
    viernes character varying(50),
    sabado character varying(50),
    estado character varying(15) NOT NULL,
    sigla_lab character varying(10),
    fk_laboratorio character varying(15),
    fk_materia_dicta character varying(15),
    fk_sesion character varying(15)
);


--
-- TOC entry 227 (class 1259 OID 18989)
-- Dependencies: 7
-- Name: tema; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tema (
    id character varying(15) NOT NULL,
    nombre character varying(150) NOT NULL,
    nivel character varying(2) NOT NULL,
    padre character varying(5) NOT NULL,
    fk_programa character varying(15)
);


--
-- TOC entry 228 (class 1259 OID 18992)
-- Dependencies: 7
-- Name: temp_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_aux (
    id character varying(15) NOT NULL,
    nombres character varying(200),
    cargo character varying(150),
    horas character varying(15),
    ci character varying(20),
    gestion1 character varying(10),
    gestion2 character varying(10),
    fecha character varying(100),
    fk_sesion character varying(15),
    tipo character varying(2),
    condicion character varying(20)
);


--
-- TOC entry 229 (class 1259 OID 18995)
-- Dependencies: 7
-- Name: temp_bibliografia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_bibliografia (
    id character varying(15) NOT NULL,
    nombre_autor character varying(150) NOT NULL,
    titulo character varying(150) NOT NULL,
    editorial character varying(100),
    detalles character varying(180),
    fk_sesion character varying(50),
    fk_programa character varying(15)
);


--
-- TOC entry 230 (class 1259 OID 18998)
-- Dependencies: 7
-- Name: temp_calendario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_calendario (
    id integer NOT NULL,
    nombremes character varying,
    posicion integer NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 19004)
-- Dependencies: 7
-- Name: temp_cert_curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_cert_curso (
    id character varying(15) NOT NULL,
    nombres character varying(200),
    obs character varying(50),
    fk_curso character varying(15),
    fk_sesion character varying(15)
);


--
-- TOC entry 232 (class 1259 OID 19007)
-- Dependencies: 7
-- Name: temp_control_segui; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_control_segui (
    fk_sesion character varying(15),
    cod_doc_aux character varying(15)
);


--
-- TOC entry 233 (class 1259 OID 19010)
-- Dependencies: 7
-- Name: temp_destinatario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_destinatario (
    id character varying(15) NOT NULL,
    titulo character varying(50),
    nombre character varying(150),
    cargo character varying(100),
    facultad character varying(100),
    ciudad character varying(100),
    fk_docente character varying(100)
);


--
-- TOC entry 234 (class 1259 OID 19013)
-- Dependencies: 7
-- Name: temp_detalle_reserva; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_detalle_reserva (
    id character varying(50) NOT NULL,
    id_dt character varying(50) NOT NULL,
    fecha date NOT NULL,
    fk_dia_res character varying(6) NOT NULL,
    fk_rango_res character varying(6) NOT NULL,
    fk_semana_res character varying(6) NOT NULL,
    fk_reserva character varying(50) NOT NULL,
    grupo_rango character varying(50) NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 19016)
-- Dependencies: 7
-- Name: temp_horario_aux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_horario_aux (
    id character varying(15),
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    estado character varying(15) NOT NULL,
    sigla_lab character varying(10),
    fk_laboratorio character varying(15),
    fk_materia_labo character varying(15) NOT NULL,
    fk_sesion character varying(15)
);


--
-- TOC entry 236 (class 1259 OID 19019)
-- Dependencies: 7
-- Name: temp_horario_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_horario_doc (
    id character varying(15),
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    estado character varying(15) NOT NULL,
    fk_materia_dicta character varying(15) NOT NULL,
    fk_sesion character varying(15)
);


--
-- TOC entry 237 (class 1259 OID 19022)
-- Dependencies: 7
-- Name: temp_impresion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_impresion (
    fecha character varying(50),
    titulo character varying(50),
    nombre character varying(150),
    cargo character varying(100),
    ciudad character varying(100),
    fk_estandarc character varying(15)
);


--
-- TOC entry 238 (class 1259 OID 19025)
-- Dependencies: 7
-- Name: temp_materia_dicta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_materia_dicta (
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    tipo character varying(100),
    estado character varying(15),
    gestion character varying(10),
    exclu integer,
    hor_auto integer,
    fk_segui_doc character varying(15),
    fk_nombra_doc character varying(15),
    fk_materia character varying(15),
    grupo character varying(2),
    fk_sesion character varying(15)
);


--
-- TOC entry 239 (class 1259 OID 19028)
-- Dependencies: 7
-- Name: temp_materia_labo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_materia_labo (
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    estado character varying(15),
    gestion character varying(10),
    sigla_lab character varying(10),
    tipo character varying(10),
    fk_segui_aux character varying(15),
    fk_nombra_aux character varying(15),
    fk_materia character varying(15),
    fk_laboratorio character varying(15),
    grupo character varying(2),
    fk_sesion character varying(15)
);


--
-- TOC entry 240 (class 1259 OID 19031)
-- Dependencies: 7
-- Name: temp_materias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_materias (
    id character varying(15),
    nombre character varying(150),
    sigla character varying(30),
    tipo character varying(30)
);


--
-- TOC entry 241 (class 1259 OID 19034)
-- Dependencies: 7
-- Name: temp_nota; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_nota (
    nombre character varying(100) NOT NULL,
    apellpa character varying(50) NOT NULL,
    apellma character varying(50),
    est_cuenta character varying(20),
    calif character varying(3),
    obs character varying(50),
    fk_inscritos character varying(15),
    nro_faltas character varying(10)
);


--
-- TOC entry 242 (class 1259 OID 19037)
-- Dependencies: 7
-- Name: temp_rango; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_rango (
    hora time without time zone NOT NULL,
    rango character varying(10),
    fk_sesion character varying(15)
);

--
-- TOC entry 246 (class 1259 OID 19049)
-- Dependencies: 7
-- Name: temp_validar_hor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE temp_validar_hor (
    id character varying(6) NOT NULL,
    cant_equi character varying(50) NOT NULL,
    asunto character varying(50) NOT NULL,
    fecha character varying(50) NOT NULL,
    hora_ini character varying(50) NOT NULL,
    hora_fin character varying(50) NOT NULL
);


--
-- TOC entry 249 (class 1259 OID 19058)
-- Dependencies: 7
-- Name: test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE test (
    empname text,
    salary integer,
    lastdate date,
    lastuser name
);


--
-- TOC entry 250 (class 1259 OID 19064)
-- Dependencies: 7
-- Name: titulo_adic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE titulo_adic (
    id character varying(10) NOT NULL,
    titulo character varying(100) NOT NULL,
    estado character varying(10) NOT NULL,
    fecha_ins date NOT NULL,
    num_cursos character varying(5)
);


--
-- TOC entry 251 (class 1259 OID 19067)
-- Dependencies: 7
-- Name: titulo_curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE titulo_curso (
    fk_titulo character varying(10) NOT NULL,
    fk_curso character varying(15) NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 19070)
-- Dependencies: 2144 7
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE usuario (
    id character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellpa character varying(40) NOT NULL,
    apellma character varying(40),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    sexo character varying(5),
    cuenta character varying(50) NOT NULL,
    clave character varying(50),
    fk_autoridad character varying(15),
    fk_carrera character varying(20)
);


SET search_path = apoyo, pg_catalog;

--
-- TOC entry 2146 (class 2606 OID 19084)
-- Dependencies: 141 141
-- Name: pk_variable; Type: CONSTRAINT; Schema: apoyo; Owner: -
--

ALTER TABLE ONLY variable
    ADD CONSTRAINT pk_variable PRIMARY KEY (id_variable);


SET search_path = public, pg_catalog;

--
-- TOC entry 2148 (class 2606 OID 19086)
-- Dependencies: 142 142
-- Name: actividad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_pkey PRIMARY KEY (id);


--
-- TOC entry 2160 (class 2606 OID 19090)
-- Dependencies: 145 145
-- Name: autoridad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY autoridad
    ADD CONSTRAINT autoridad_pkey PRIMARY KEY (id);


--
-- TOC entry 2162 (class 2606 OID 19092)
-- Dependencies: 146 146
-- Name: aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aux
    ADD CONSTRAINT aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2164 (class 2606 OID 19094)
-- Dependencies: 147 147
-- Name: auxiliar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliar
    ADD CONSTRAINT auxiliar_pkey PRIMARY KEY (id);


--
-- TOC entry 2170 (class 2606 OID 19096)
-- Dependencies: 149 149
-- Name: auxiliatura_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliatura
    ADD CONSTRAINT auxiliatura_pkey PRIMARY KEY (id);


--
-- TOC entry 2172 (class 2606 OID 19098)
-- Dependencies: 150 150
-- Name: bibliografia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bibliografia
    ADD CONSTRAINT bibliografia_pkey PRIMARY KEY (id);

--
-- TOC entry 2178 (class 2606 OID 19102)
-- Dependencies: 152 152
-- Name: car_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_aux
    ADD CONSTRAINT car_aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2182 (class 2606 OID 19104)
-- Dependencies: 153 153
-- Name: cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cargo
    ADD CONSTRAINT cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2184 (class 2606 OID 19106)
-- Dependencies: 154 154
-- Name: carrera_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carrera
    ADD CONSTRAINT carrera_pkey PRIMARY KEY (id);


--
-- TOC entry 2186 (class 2606 OID 19108)
-- Dependencies: 155 155
-- Name: carta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta
    ADD CONSTRAINT carta_pkey PRIMARY KEY (id);


--
-- TOC entry 2190 (class 2606 OID 19110)
-- Dependencies: 158 158
-- Name: categoria_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria_aux
    ADD CONSTRAINT categoria_aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2194 (class 2606 OID 19112)
-- Dependencies: 160 160
-- Name: categoria_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria_doc
    ADD CONSTRAINT categoria_doc_pkey PRIMARY KEY (id);


--
-- TOC entry 2196 (class 2606 OID 19114)
-- Dependencies: 161 161
-- Name: certificado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificado
    ADD CONSTRAINT certificado_pkey PRIMARY KEY (id);


--
-- TOC entry 2198 (class 2606 OID 19116)
-- Dependencies: 162 162
-- Name: combo_box_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY combo_box
    ADD CONSTRAINT combo_box_pkey PRIMARY KEY (id);


--
-- TOC entry 2208 (class 2606 OID 19118)
-- Dependencies: 167 167
-- Name: curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2210 (class 2606 OID 19120)
-- Dependencies: 168 168
-- Name: destinatario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY destinatario
    ADD CONSTRAINT destinatario_pkey PRIMARY KEY (id);


--
-- TOC entry 2212 (class 2606 OID 19122)
-- Dependencies: 169 169
-- Name: detalle_reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY detalle_reserva
    ADD CONSTRAINT detalle_reserva_pkey PRIMARY KEY (id);


--
-- TOC entry 2214 (class 2606 OID 19124)
-- Dependencies: 170 170
-- Name: dia_res_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dia_res
    ADD CONSTRAINT dia_res_pkey PRIMARY KEY (id);


--
-- TOC entry 2216 (class 2606 OID 19126)
-- Dependencies: 171 171
-- Name: docente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY docente
    ADD CONSTRAINT docente_pkey PRIMARY KEY (id);


--
-- TOC entry 2218 (class 2606 OID 19128)
-- Dependencies: 172 172
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2220 (class 2606 OID 19130)
-- Dependencies: 173 173
-- Name: estandarc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estandarc
    ADD CONSTRAINT estandarc_pkey PRIMARY KEY (id);


--
-- TOC entry 2298 (class 2606 OID 19935)
-- Dependencies: 223 223
-- Name: fk_segui_exclu_auto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY segui_exclu_auto
    ADD CONSTRAINT fk_segui_exclu_auto PRIMARY KEY (id);


--
-- TOC entry 2222 (class 2606 OID 19132)
-- Dependencies: 174 174
-- Name: gestion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gestion
    ADD CONSTRAINT gestion_pkey PRIMARY KEY (id);


--
-- TOC entry 2224 (class 2606 OID 19134)
-- Dependencies: 175 175
-- Name: hist_auxiliatura_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_auxiliatura
    ADD CONSTRAINT hist_auxiliatura_pkey PRIMARY KEY (id);


--
-- TOC entry 2226 (class 2606 OID 19136)
-- Dependencies: 176 176
-- Name: hist_categoria_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_categoria_doc
    ADD CONSTRAINT hist_categoria_doc_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 19138)
-- Dependencies: 179 179
-- Name: hist_materia_dicta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT hist_materia_dicta_pkey PRIMARY KEY (id);


--
-- TOC entry 2230 (class 2606 OID 19140)
-- Dependencies: 180 180
-- Name: hist_materia_labo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_labo
    ADD CONSTRAINT hist_materia_labo_pkey PRIMARY KEY (id);


--
-- TOC entry 2232 (class 2606 OID 19142)
-- Dependencies: 181 181
-- Name: hist_nombra_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_nombra_aux
    ADD CONSTRAINT hist_nombra_aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 2606 OID 19144)
-- Dependencies: 182 182
-- Name: hist_nombra_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_nombra_doc
    ADD CONSTRAINT hist_nombra_doc_pkey PRIMARY KEY (id);


--
-- TOC entry 2236 (class 2606 OID 19146)
-- Dependencies: 183 183
-- Name: hist_segui_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_segui_aux
    ADD CONSTRAINT hist_segui_aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2238 (class 2606 OID 19148)
-- Dependencies: 184 184
-- Name: hist_segui_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_segui_doc
    ADD CONSTRAINT hist_segui_doc_pkey PRIMARY KEY (id);


--
-- TOC entry 2240 (class 2606 OID 19150)
-- Dependencies: 187 187
-- Name: horario_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horario_aux
    ADD CONSTRAINT horario_aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2242 (class 2606 OID 19152)
-- Dependencies: 188 188
-- Name: horario_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horario_doc
    ADD CONSTRAINT horario_doc_pkey PRIMARY KEY (id);


--
-- TOC entry 2244 (class 2606 OID 19154)
-- Dependencies: 191 191
-- Name: horas_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horas_aux
    ADD CONSTRAINT horas_aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2246 (class 2606 OID 19156)
-- Dependencies: 192 192
-- Name: horas_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horas_doc
    ADD CONSTRAINT horas_doc_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 19158)
-- Dependencies: 193 193
-- Name: inscritos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inscritos
    ADD CONSTRAINT inscritos_pkey PRIMARY KEY (id);


--
-- TOC entry 2250 (class 2606 OID 19160)
-- Dependencies: 194 194
-- Name: institucion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY institucion
    ADD CONSTRAINT institucion_pkey PRIMARY KEY (id);


--
-- TOC entry 2252 (class 2606 OID 19162)
-- Dependencies: 195 195
-- Name: laboratorio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY laboratorio
    ADD CONSTRAINT laboratorio_pkey PRIMARY KEY (id);


--
-- TOC entry 2256 (class 2606 OID 19164)
-- Dependencies: 197 197
-- Name: materia_dicta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT materia_dicta_pkey PRIMARY KEY (id);


--
-- TOC entry 2258 (class 2606 OID 19166)
-- Dependencies: 198 198
-- Name: materia_labo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT materia_labo_pkey PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 19168)
-- Dependencies: 196 196
-- Name: materia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia
    ADD CONSTRAINT materia_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 19170)
-- Dependencies: 200 200
-- Name: nombra_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nombra_aux
    ADD CONSTRAINT nombra_aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2262 (class 2606 OID 19172)
-- Dependencies: 201 201
-- Name: nombra_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nombra_doc
    ADD CONSTRAINT nombra_doc_pkey PRIMARY KEY (id);


--
-- TOC entry 2266 (class 2606 OID 19174)
-- Dependencies: 203 203
-- Name: pga_diagrams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pga_diagrams
    ADD CONSTRAINT pga_diagrams_pkey PRIMARY KEY (diagramname);


--
-- TOC entry 2268 (class 2606 OID 19176)
-- Dependencies: 204 204
-- Name: pga_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pga_forms
    ADD CONSTRAINT pga_forms_pkey PRIMARY KEY (formname);


--
-- TOC entry 2270 (class 2606 OID 19178)
-- Dependencies: 205 205
-- Name: pga_graphs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pga_graphs
    ADD CONSTRAINT pga_graphs_pkey PRIMARY KEY (graphname);


--
-- TOC entry 2272 (class 2606 OID 19180)
-- Dependencies: 206 206
-- Name: pga_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pga_images
    ADD CONSTRAINT pga_images_pkey PRIMARY KEY (imagename);


--
-- TOC entry 2274 (class 2606 OID 19182)
-- Dependencies: 207 207
-- Name: pga_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pga_layout
    ADD CONSTRAINT pga_layout_pkey PRIMARY KEY (tablename);


--
-- TOC entry 2276 (class 2606 OID 19184)
-- Dependencies: 208 208
-- Name: pga_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pga_queries
    ADD CONSTRAINT pga_queries_pkey PRIMARY KEY (queryname);


--
-- TOC entry 2278 (class 2606 OID 19186)
-- Dependencies: 209 209
-- Name: pga_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pga_reports
    ADD CONSTRAINT pga_reports_pkey PRIMARY KEY (reportname);


--
-- TOC entry 2280 (class 2606 OID 19188)
-- Dependencies: 210 210
-- Name: pga_scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pga_scripts
    ADD CONSTRAINT pga_scripts_pkey PRIMARY KEY (scriptname);



--
-- TOC entry 2168 (class 2606 OID 19192)
-- Dependencies: 148 148
-- Name: pk_auxiliar_ext; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliar_ext
    ADD CONSTRAINT pk_auxiliar_ext PRIMARY KEY (fk_auxiliar);


--
-- TOC entry 2188 (class 2606 OID 19194)
-- Dependencies: 157 157
-- Name: pk_catalogo_curso; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY catalogo_curso
    ADD CONSTRAINT pk_catalogo_curso PRIMARY KEY (id);


--
-- TOC entry 2192 (class 2606 OID 19196)
-- Dependencies: 159 159
-- Name: pk_categoria_curso; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria_curso
    ADD CONSTRAINT pk_categoria_curso PRIMARY KEY (id);


--
-- TOC entry 2200 (class 2606 OID 19198)
-- Dependencies: 163 163
-- Name: pk_cprol; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cprol
    ADD CONSTRAINT pk_cprol PRIMARY KEY (id);


--
-- TOC entry 2202 (class 2606 OID 19929)
-- Dependencies: 164 164 164
-- Name: pk_cproles_usuario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cproles_usuario
    ADD CONSTRAINT pk_cproles_usuario PRIMARY KEY (fk_id_usr, fk_id_rol);


--
-- TOC entry 2204 (class 2606 OID 19200)
-- Dependencies: 165 165
-- Name: pk_cptarea; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cptarea
    ADD CONSTRAINT pk_cptarea PRIMARY KEY (id);


--
-- TOC entry 2206 (class 2606 OID 19933)
-- Dependencies: 166 166 166
-- Name: pk_cptareas_rol; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cptareas_rol
    ADD CONSTRAINT pk_cptareas_rol PRIMARY KEY (fk_id_rol, fk_id_tarea);


--
-- TOC entry 2264 (class 2606 OID 40333)
-- Dependencies: 202 202 202 202
-- Name: pk_nota; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nota
    ADD CONSTRAINT pk_nota PRIMARY KEY (fk_curso, fk_inscritos, calif);


--
-- TOC entry 2304 (class 2606 OID 19202)
-- Dependencies: 230 230
-- Name: pk_temp_calendario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY temp_calendario
    ADD CONSTRAINT pk_temp_calendario PRIMARY KEY (id);


--
-- TOC entry 2284 (class 2606 OID 19204)
-- Dependencies: 212 212
-- Name: plan_mat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plan_mat
    ADD CONSTRAINT plan_mat_pkey PRIMARY KEY (id);


--
-- TOC entry 2282 (class 2606 OID 19206)
-- Dependencies: 211 211
-- Name: plan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (id);


--
-- TOC entry 2288 (class 2606 OID 19210)
-- Dependencies: 215 215
-- Name: profesor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT profesor_pkey PRIMARY KEY (id);


--
-- TOC entry 2290 (class 2606 OID 19212)
-- Dependencies: 216 216
-- Name: programa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY programa
    ADD CONSTRAINT programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2292 (class 2606 OID 19214)
-- Dependencies: 217 217
-- Name: rango_res_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rango_res
    ADD CONSTRAINT rango_res_pkey PRIMARY KEY (id);


--
-- TOC entry 2294 (class 2606 OID 19216)
-- Dependencies: 220 220
-- Name: sala_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sala
    ADD CONSTRAINT sala_pkey PRIMARY KEY (id);


--
-- TOC entry 2296 (class 2606 OID 19218)
-- Dependencies: 222 222
-- Name: segui_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY segui_doc
    ADD CONSTRAINT segui_doc_pkey PRIMARY KEY (id);


--
-- TOC entry 2300 (class 2606 OID 19220)
-- Dependencies: 224 224
-- Name: sesion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sesion
    ADD CONSTRAINT sesion_pkey PRIMARY KEY (id);


--
-- TOC entry 2302 (class 2606 OID 19222)
-- Dependencies: 228 228
-- Name: temp_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY temp_aux
    ADD CONSTRAINT temp_aux_pkey PRIMARY KEY (id);


--
-- TOC entry 2306 (class 2606 OID 19224)
-- Dependencies: 231 231
-- Name: temp_cert_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY temp_cert_curso
    ADD CONSTRAINT temp_cert_curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2308 (class 2606 OID 19226)
-- Dependencies: 233 233
-- Name: temp_destinatario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY temp_destinatario
    ADD CONSTRAINT temp_destinatario_pkey PRIMARY KEY (id);


--
-- TOC entry 2310 (class 2606 OID 19228)
-- Dependencies: 234 234
-- Name: temp_detalle_reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY temp_detalle_reserva
    ADD CONSTRAINT temp_detalle_reserva_pkey PRIMARY KEY (id);


--
-- TOC entry 2312 (class 2606 OID 19230)
-- Dependencies: 246 246
-- Name: temp_validar_hor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY temp_validar_hor
    ADD CONSTRAINT temp_validar_hor_pkey PRIMARY KEY (id);


--
-- TOC entry 2318 (class 2606 OID 19236)
-- Dependencies: 250 250
-- Name: titulo_adic_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY titulo_adic
    ADD CONSTRAINT titulo_adic_pkey PRIMARY KEY (id);


--
-- TOC entry 2320 (class 2606 OID 19238)
-- Dependencies: 251 251 251
-- Name: titulo_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY titulo_curso
    ADD CONSTRAINT titulo_curso_pkey PRIMARY KEY (fk_titulo, fk_curso);


--
-- TOC entry 2166 (class 2606 OID 19242)
-- Dependencies: 147 147 147 147 147
-- Name: unico_auxiliar; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliar
    ADD CONSTRAINT unico_auxiliar UNIQUE (nombre, apellpa, apellma, ci);


--
-- TOC entry 2180 (class 2606 OID 19246)
-- Dependencies: 152 152 152 152
-- Name: unico_car_aux; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_aux
    ADD CONSTRAINT unico_car_aux UNIQUE (gestion, fk_auxiliar, fk_cargo);


--
-- TOC entry 2322 (class 2606 OID 19252)
-- Dependencies: 252 252
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2351 (class 2620 OID 19253)
-- Dependencies: 215 267
-- Name: trigger_capital_profesor; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_capital_profesor
    BEFORE INSERT OR UPDATE ON profesor
    FOR EACH ROW
    EXECUTE PROCEDURE capital_profesor();


--
-- TOC entry 2346 (class 2606 OID 19254)
-- Dependencies: 188 190 2241
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horario_rangos_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_horario_doc) REFERENCES horario_doc(id);


--
-- TOC entry 2332 (class 2606 OID 19259)
-- Dependencies: 2287 167 215
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_profesor) REFERENCES profesor(id);


--
-- TOC entry 2349 (class 2606 OID 19264)
-- Dependencies: 196 2253 216
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY programa
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_materia) REFERENCES materia(id);


--
-- TOC entry 2350 (class 2606 OID 19269)
-- Dependencies: 227 2289 216
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_programa) REFERENCES programa(id);


--
-- TOC entry 2326 (class 2606 OID 19274)
-- Dependencies: 216 150 2289
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bibliografia
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_programa) REFERENCES programa(id);


--
-- TOC entry 2347 (class 2606 OID 19279)
-- Dependencies: 2253 196 213
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prerequisito
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_materia) REFERENCES materia(id);


--
-- TOC entry 2343 (class 2606 OID 19284)
-- Dependencies: 171 2215 182
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_nombra_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(id);


--
-- TOC entry 2336 (class 2606 OID 19289)
-- Dependencies: 2233 176 182
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_categoria_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_doc) REFERENCES hist_nombra_doc(id);


--
-- TOC entry 2345 (class 2606 OID 19294)
-- Dependencies: 184 171 2215
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_segui_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(id);


--
-- TOC entry 2337 (class 2606 OID 19299)
-- Dependencies: 179 184 2237
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_doc) REFERENCES hist_segui_doc(id);


--
-- TOC entry 2342 (class 2606 OID 19304)
-- Dependencies: 181 147 2163
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_nombra_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(id);


--
-- TOC entry 2335 (class 2606 OID 19309)
-- Dependencies: 175 181 2231
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_auxiliatura
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_aux) REFERENCES hist_nombra_aux(id);


--
-- TOC entry 2344 (class 2606 OID 19314)
-- Dependencies: 183 147 2163
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_segui_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(id);


--
-- TOC entry 2340 (class 2606 OID 19319)
-- Dependencies: 180 183 2235
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_labo
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_aux) REFERENCES hist_segui_aux(id);


--
-- TOC entry 2323 (class 2606 OID 19324)
-- Dependencies: 2181 153 142
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actividad
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(id);


--
-- TOC entry 2348 (class 2606 OID 19329)
-- Dependencies: 213 2253 196
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prerequisito
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_pre_materia) REFERENCES materia(id);


--
-- TOC entry 2338 (class 2606 OID 19334)
-- Dependencies: 179 2233 182
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_doc) REFERENCES hist_nombra_doc(id);


--
-- TOC entry 2341 (class 2606 OID 19339)
-- Dependencies: 180 2231 181
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_labo
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_aux) REFERENCES hist_nombra_aux(id);


--
-- TOC entry 2339 (class 2606 OID 19344)
-- Dependencies: 179 2253 196
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_materia) REFERENCES materia(id);


--
-- TOC entry 2325 (class 2606 OID 19354)
-- Dependencies: 2163 147 148
-- Name: fk_aux_ext_reference_auxiliar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliar_ext
    ADD CONSTRAINT fk_aux_ext_reference_auxiliar FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2327 (class 2606 OID 19359)
-- Dependencies: 157 2191 159
-- Name: fk_cat_cur_reference_catalogo_curso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY catalogo_curso
    ADD CONSTRAINT fk_cat_cur_reference_catalogo_curso FOREIGN KEY (fk_categoria_curso) REFERENCES categoria_curso(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2333 (class 2606 OID 19364)
-- Dependencies: 157 2187 167
-- Name: fk_cat_cur_reference_catalogo_curso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT fk_cat_cur_reference_catalogo_curso FOREIGN KEY (fk_catalogo_curso) REFERENCES catalogo_curso(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2334 (class 2606 OID 19369)
-- Dependencies: 230 2303 167
-- Name: fk_curso_temp_calendario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT fk_curso_temp_calendario FOREIGN KEY (fk_temp_calendario) REFERENCES temp_calendario(id) ON UPDATE CASCADE;


--
-- TOC entry 2330 (class 2606 OID 19374)
-- Dependencies: 163 2199 166
-- Name: tiene1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cptareas_rol
    ADD CONSTRAINT tiene1 FOREIGN KEY (fk_id_rol) REFERENCES cprol(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2328 (class 2606 OID 19379)
-- Dependencies: 163 2199 164
-- Name: tiene1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cproles_usuario
    ADD CONSTRAINT tiene1 FOREIGN KEY (fk_id_rol) REFERENCES cprol(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2331 (class 2606 OID 19384)
-- Dependencies: 165 166 2203
-- Name: tiene2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cptareas_rol
    ADD CONSTRAINT tiene2 FOREIGN KEY (fk_id_tarea) REFERENCES cptarea(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2329 (class 2606 OID 19389)
-- Dependencies: 164 252 2321
-- Name: tiene2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cproles_usuario
    ADD CONSTRAINT tiene2 FOREIGN KEY (fk_id_usr) REFERENCES usuario(id) ON UPDATE RESTRICT ON DELETE CASCADE;


-- Completed on 2012-04-24 17:12:32

--
-- PostgreSQL database dump complete
--

