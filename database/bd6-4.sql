/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     09/11/2016 23:07:47                          */
/*==============================================================*/



/*==============================================================*/
/* Table: CARRERA                                               */
/*==============================================================*/
create table CARRERA
(
   ID_CARRERA           int(10) not null auto_increment,
   NOMBRE_CARRERA       varchar(20) not null,
   SIGLA_CARRERA        varchar(15),
   FACULTAD_CARRERA     varchar(20),
   DEPTO_CARRERA        varchar(20),
   primary key (ID_CARRERA)
);

/*==============================================================*/
/* Table: CATALOGO_CURSO                                        */
/*==============================================================*/
create table CATALOGO_CURSO
(
   ID_CATALOGO_CURSO    int(10) not null auto_increment,
   NOMBRE_CURSO         varchar(50),
   ESTADO_CURSO         varchar(50),
   primary key (ID_CATALOGO_CURSO)
);

/*==============================================================*/
/* Table: CURSO                                                 */
/*==============================================================*/
create table CURSO
(
   ID_CURSO             int not null auto_increment,
   ID_CATALOGO_CURSO    int(10) not null,
   TOTAL_HORAS          int,
   COSTO                int,
   PERIODO              varchar(25),
   OBSERVACIONES_CURSO  varchar(50),
   NIVEL_CURSO          varchar(25),
   primary key (ID_CURSO)
);

/*==============================================================*/
/* Table: DOCENTE                                               */
/*==============================================================*/
create table DOCENTE
(
   ID_DOC               int(10) not null auto_increment,
   CI_DOC               int not null,
   NOMBRE_DOC           varchar(50) not null,
   APELLPA_DOC          varchar(50) not null,
   APELLMA_DOC          varchar(50) not null,
   TITULO_DOC           varchar(50),
   DIPLOMA_DOC          varchar(50),
   primary key (ID_DOC)
);

/*==============================================================*/
/* Table: HORARIO_DOC                                           */
/*==============================================================*/
create table HORARIO_DOC
(
   ID_HORARIO_DOC       int(10) not null auto_increment,
   ID_MATERIA_DICTA     int(10) not null,
   GRUPO                varchar(10),
   AULA                 varchar(10),
   NUMERO_ALUMNOS       int,
   primary key (ID_HORARIO_DOC)
);

/*==============================================================*/
/* Table: MATERIA                                               */
/*==============================================================*/
create table MATERIA
(
   ID_MATERIA           int(10) not null auto_increment,
   NOMBRE_MATERIA       varchar(50) not null,
   SIGLA_MATERIA        int,
   TIPO_MATERIA         varchar(30),
   NIVEL_MATERIA        varchar(15),
   primary key (ID_MATERIA)
);

/*==============================================================*/
/* Table: MATERIA_DICTA                                         */
/*==============================================================*/
create table MATERIA_DICTA
(
   ID_MATERIA_DICTA     int(10) not null auto_increment,
   ID_NOMBRAMIENTO_DOC  int(10) not null,
   ID_SEGUIMIENTO_DOC   int(10) not null,
   HORA_SEMANA          time,
   HORA_TEORIA          time,
   HORA_PRACTICA        time,
   primary key (ID_MATERIA_DICTA)
);

/*==============================================================*/
/* Table: NOMBRAMIENTO_DOC                                      */
/*==============================================================*/
create table NOMBRAMIENTO_DOC
(
   ID_NOMBRAMIENTO_DOC  int(10) not null auto_increment,
   ID_DOC               int(10) not null,
   FECHA_NOMBRAMIENTO   date,
   primary key (ID_NOMBRAMIENTO_DOC)
);

/*==============================================================*/
/* Table: PLAN                                                  */
/*==============================================================*/
create table PLAN
(
   ID_PLAN              int(10) not null auto_increment,
   ID_CARRERA           int(10) not null,
   NOMBRE_PLAN          varchar(20),
   CODIGO_SIS           int,
   primary key (ID_PLAN)
);

/*==============================================================*/
/* Table: RELATIONSHIP_4                                        */
/*==============================================================*/
create table RELATIONSHIP_4
(
   ID_USUARIO           int(10) not null,
   ID_ROL_USUARIO       int(10) not null,
   primary key (ID_USUARIO, ID_ROL_USUARIO)
);

/*==============================================================*/
/* Table: RESERVA                                               */
/*==============================================================*/
create table RESERVA
(
   ID_RESERVA           int(10) not null auto_increment,
   ID_SALA              int(10) not null,
   ID_CURSO             int not null,
   ID_MATERIA           int(10) not null,
   ASUNTO               varchar(25),
   CANT_EQUI            int,
   RESPONSABLE_CARRERA  varchar(30),
   COSTO_RESERVA        int,
   MONEDA               varchar(20),
   HORARIO_FIJO         date,
   TELEFONO_RESP        int,
   DIRECCION_RESP       varchar(50),
   FECHA_INICIAL_RESERVA date,
   FECHA_FINAL_RESERVA  date,
   primary key (ID_RESERVA)
);

/*==============================================================*/
/* Table: ROL_USUARIO                                           */
/*==============================================================*/
create table ROL_USUARIO
(
   ID_ROL_USUARIO       int(10) not null auto_increment,
   NOMBRE_ROL           varchar(20),
   DESCRIPCION_ROL      varchar(50),
   primary key (ID_ROL_USUARIO)
);

/*==============================================================*/
/* Table: SALA                                                  */
/*==============================================================*/
create table SALA
(
   ID_SALA              int(10) not null auto_increment,
   NOMBRE_SALA          varchar(50),
   CANTIDAD_EQUI_SALA   int,
   primary key (ID_SALA)
);

/*==============================================================*/
/* Table: SEGUIMIENTO_DOC                                       */
/*==============================================================*/
create table SEGUIMIENTO_DOC
(
   ID_SEGUIMIENTO_DOC   int(10) not null auto_increment,
   APELLESPOSO          varchar(20),
   ASIST                varchar(15),
   ADJ                  varchar(15),
   CAT                  varchar(15),
   AUX_DOC              varchar(15),
   OTRO_CARGO           varchar(25),
   HRS_TEORIA           time,
   HRS_INVES            time,
   HRS_EXT              time,
   HRS_SER              time,
   HRS_PRAC             time,
   HRS_PROD             time,
   HRS_SERV             time,
   HRS_PROD_ACAD        time,
   HRS_ADM_ACAD         time,
   HRS_TRAB_SEM         time,
   HRS_TRAB_MES         time,
   HRS_AUTO             time,
   DEDICACION_EXCLUSIVA varchar(50),
   OBSERVACION          varchar(50),
   primary key (ID_SEGUIMIENTO_DOC)
);

/*==============================================================*/
/* Table: SEGUIMIENTO_EXCLU_DOC                                 */
/*==============================================================*/
create table SEGUIMIENTO_EXCLU_DOC
(
   ID_SEGUIMIENTO_EXCLU int(10) not null auto_increment,
   ID_SEGUIMIENTO_DOC   int(10) not null,
   CASO_EXCLU           varchar(20),
   TIPO_EXCLU           varchar(20) not null,
   HORA_INIAL_EXCLU     time,
   RANGO_INICIAL_EXCLU  varchar(15),
   HORA_FINAL_EXCLU     time,
   RANGO_FINAL_EXCLU    varchar(15),
   primary key (ID_SEGUIMIENTO_EXCLU)
);

/*==============================================================*/
/* Table: SESION                                                */
/*==============================================================*/
create table SESION
(
   ID_SESION            int(10) not null auto_increment,
   ID_USUARIO           int(10) not null,
   FECHA_SESION         date,
   primary key (ID_SESION)
);

/*==============================================================*/
/* Table: TABLA_HORARIO                                         */
/*==============================================================*/
create table TABLA_HORARIO
(
   ID_TABLA_HORARIO     int(0) not null auto_increment,
   ID_MATERIA_DICTA     int(10) not null,
   ID_SESION            int(10) not null,
   RANGO                varchar(15),
   DIA                  date,
   primary key (ID_TABLA_HORARIO)
);

/*==============================================================*/
/* Table: TIENE                                                 */
/*==============================================================*/
create table TIENE
(
   ID_MATERIA           int(10) not null,
   ID_PLAN              int(10) not null,
   primary key (ID_MATERIA, ID_PLAN)
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO
(
   ID_USUARIO           int(10) not null auto_increment,
   ID_CARRERA           int(10) not null,
   NOMBRE_USUARIO       varchar(50) not null,
   APELLPA_USUARIO      varchar(50) not null,
   APELLMA_USUARIO      varchar(50),
   ESTADO_USUARIO       varchar(50),
   GENERO_USUARIO       varchar(15),
   CUENTA_USUARIO       varchar(50) not null,
   CONTRASENIA_USUARIO  varchar(20) not null,
   primary key (ID_USUARIO)
);

alter table CURSO add constraint FK_RELATIONSHIP_13 foreign key (ID_CATALOGO_CURSO)
      references CATALOGO_CURSO (ID_CATALOGO_CURSO) on delete restrict on update restrict;

alter table HORARIO_DOC add constraint FK_RELATIONSHIP_10 foreign key (ID_MATERIA_DICTA)
      references MATERIA_DICTA (ID_MATERIA_DICTA) on delete restrict on update restrict;

alter table MATERIA_DICTA add constraint FK_RELATIONSHIP_15 foreign key (ID_NOMBRAMIENTO_DOC)
      references NOMBRAMIENTO_DOC (ID_NOMBRAMIENTO_DOC) on delete restrict on update restrict;

alter table MATERIA_DICTA add constraint FK_RELATIONSHIP_8 foreign key (ID_SEGUIMIENTO_DOC)
      references SEGUIMIENTO_DOC (ID_SEGUIMIENTO_DOC) on delete restrict on update restrict;

alter table NOMBRAMIENTO_DOC add constraint FK_RELATIONSHIP_16 foreign key (ID_DOC)
      references DOCENTE (ID_DOC) on delete restrict on update restrict;

alter table PLAN add constraint FK_RELATIONSHIP_6 foreign key (ID_CARRERA)
      references CARRERA (ID_CARRERA) on delete restrict on update restrict;

alter table RELATIONSHIP_4 add constraint FK_RELATIONSHIP_4 foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO) on delete restrict on update restrict;

alter table RELATIONSHIP_4 add constraint FK_RELATIONSHIP_5 foreign key (ID_ROL_USUARIO)
      references ROL_USUARIO (ID_ROL_USUARIO) on delete restrict on update restrict;

alter table RESERVA add constraint FK_RELATIONSHIP_11 foreign key (ID_MATERIA)
      references MATERIA (ID_MATERIA) on delete restrict on update restrict;

alter table RESERVA add constraint FK_RELATIONSHIP_12 foreign key (ID_CURSO)
      references CURSO (ID_CURSO) on delete restrict on update restrict;

alter table RESERVA add constraint FK_RELATIONSHIP_14 foreign key (ID_SALA)
      references SALA (ID_SALA) on delete restrict on update restrict;

alter table SEGUIMIENTO_EXCLU_DOC add constraint FK_RELATIONSHIP_9 foreign key (ID_SEGUIMIENTO_DOC)
      references SEGUIMIENTO_DOC (ID_SEGUIMIENTO_DOC) on delete restrict on update restrict;

alter table SESION add constraint FK_RELATIONSHIP_2 foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO) on delete restrict on update restrict;

alter table TABLA_HORARIO add constraint FK_RELATIONSHIP_3 foreign key (ID_SESION)
      references SESION (ID_SESION) on delete restrict on update restrict;

alter table TABLA_HORARIO add constraint FK_RELATIONSHIP_7 foreign key (ID_MATERIA_DICTA)
      references MATERIA_DICTA (ID_MATERIA_DICTA) on delete restrict on update restrict;

alter table TIENE add constraint FK_TIENE foreign key (ID_MATERIA)
      references MATERIA (ID_MATERIA) on delete restrict on update restrict;

alter table TIENE add constraint FK_TIENE2 foreign key (ID_PLAN)
      references PLAN (ID_PLAN) on delete restrict on update restrict;

alter table USUARIO add constraint FK_RELATIONSHIP_1 foreign key (ID_CARRERA)
      references CARRERA (ID_CARRERA) on delete restrict on update restrict;

