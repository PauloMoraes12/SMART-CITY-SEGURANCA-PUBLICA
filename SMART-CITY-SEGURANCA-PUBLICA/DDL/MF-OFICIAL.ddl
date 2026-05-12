-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-05-11 21:19:12 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE BAIRRO 
    ( 
     id_bairro        NUMBER (10)  NOT NULL , 
     nome_bairro      NVARCHAR2 (100) , 
     CIDADE_id_cidade NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE BAIRRO 
    ADD CONSTRAINT BAIRRO_PK PRIMARY KEY ( id_bairro ) ;

CREATE TABLE CIDADE 
    ( 
     id_cidade   NUMBER (10)  NOT NULL , 
     nome_cidade NVARCHAR2 (100) , 
     uf          CHAR (2) 
    ) 
;

ALTER TABLE CIDADE 
    ADD CONSTRAINT CIDADE_PK PRIMARY KEY ( id_cidade ) ;

CREATE TABLE ESTATISTICA_REGIAO 
    ( 
     id_estatistisca   NUMBER (10)  NOT NULL , 
     periodo_inicio    TIMESTAMP WITH TIME ZONE , 
     periodo_fim       TIMESTAMP WITH TIME ZONE , 
     total_ocorrencias NUMBER (10) , 
     nivel_risco       NVARCHAR2 (20) , 
     BAIRRO_id_bairro  NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE ESTATISTICA_REGIAO 
    ADD CONSTRAINT ESTATISTICA_REGIAO_PK PRIMARY KEY ( id_estatistisca ) ;

CREATE TABLE ILUMINACAO 
    ( 
     id_iluminacao              NUMBER (10)  NOT NULL , 
     tipo_iluminacao            NVARCHAR2 (50) , 
     status                     NVARCHAR2 (20) , 
     potencia                   NUMBER (5,2) , 
     LOCALIZACAO_id_localizacao NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE ILUMINACAO 
    ADD CONSTRAINT ILUMINACAO_PK PRIMARY KEY ( id_iluminacao ) ;

CREATE TABLE LOCALIZACAO 
    ( 
     id_localizacao   NUMBER (10)  NOT NULL , 
     latitude         NUMBER (9,6) , 
     longitude        NUMBER (9,6) , 
     logradouro       NVARCHAR2 (150) , 
     numero           NVARCHAR2 (10) , 
     cep              NUMBER (10) , 
     referencia       NVARCHAR2 (200) , 
     BAIRRO_id_bairro NUMBER (10)  NOT NULL , 
     TOTEM_id_totem   NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE LOCALIZACAO 
    ADD CONSTRAINT LOCALIZACAO_PK PRIMARY KEY ( id_localizacao ) ;

CREATE TABLE MIDIA 
    ( 
     id_midia                 NUMBER (10)  NOT NULL , 
     tipo_arquivo             NVARCHAR2 (30) , 
     url_arquivo              NVARCHAR2 (255) , 
     data_upload              TIMESTAMP WITH LOCAL TIME ZONE , 
     OCORRENCIA_id_ocorrencia NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE MIDIA 
    ADD CONSTRAINT MIDIA_PK PRIMARY KEY ( id_midia ) ;

CREATE TABLE OCORRENCIA 
    ( 
     id_ocorrencia              NUMBER (10)  NOT NULL , 
     data_hora                  TIMESTAMP WITH LOCAL TIME ZONE , 
     tipo_ocorrencia            NVARCHAR2 (50) , 
     descricao                  NVARCHAR2 (500) , 
     status                     NVARCHAR2 (30) , 
     prioridade                 NVARCHAR2 (20) , 
     protocolo                  NVARCHAR2 (30) , 
     USUARIO_id_usuario         NUMBER (10)  NOT NULL , 
     LOCALIZACAO_id_localizacao NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT OCORRENCIA_PK PRIMARY KEY ( id_ocorrencia ) ;

CREATE TABLE PONTO_POLICIAL 
    ( 
     id_ponto          NUMBER (10)  NOT NULL , 
     tipo_ponto        NVARCHAR2 (50) , 
     telefone_contato  NVARCHAR2 (20) , 
     funcionamento_24h CHAR (1) 
    ) 
;

ALTER TABLE PONTO_POLICIAL 
    ADD CONSTRAINT PONTO_POLICIAL_PK PRIMARY KEY ( id_ponto ) ;

CREATE TABLE ROTA_ATENDIMENTO 
    ( 
     id_rota                  NUMBER (10)  NOT NULL , 
     tempo_estimado           NUMBER (5,2) , 
     nivel_risco_rota         NVARCHAR2 (20) , 
     status_rota              NVARCHAR2 (20) , 
     PONTO_POLICIAL_id_ponto  NUMBER (10)  NOT NULL , 
     OCORRENCIA_id_ocorrencia NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE ROTA_ATENDIMENTO 
    ADD CONSTRAINT ROTA_ATENDIMENTO_PK PRIMARY KEY ( id_rota ) ;

CREATE TABLE SMART_VISION_EVENTO 
    ( 
     id_evento      NUMBER (10)  NOT NULL , 
     tipo_evento    NVARCHAR2 (50) , 
     confianca      NUMBER (5,2) , 
     MIDIA_id_midia NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE SMART_VISION_EVENTO 
    ADD CONSTRAINT SMART_VISION_EVENTO_PK PRIMARY KEY ( id_evento ) ;

CREATE TABLE TOTEM 
    ( 
     id_totem        NUMBER (10)  NOT NULL , 
     status          NVARCHAR2 (20) , 
     tipo_totem      NVARCHAR2 (50) , 
     data_instalacao DATE 
    ) 
;

ALTER TABLE TOTEM 
    ADD CONSTRAINT TOTEM_PK PRIMARY KEY ( id_totem ) ;

CREATE TABLE USUARIO 
    ( 
     id_usuario   NUMBER (10)  NOT NULL , 
     cpf          NVARCHAR2 (14) , 
     nome         NVARCHAR2 (100) , 
     email        NVARCHAR2 (100) , 
     celular      NVARCHAR2 (20) , 
     genero       NVARCHAR2 (20) , 
     tipo_usuario NVARCHAR2 (30) 
    ) 
;

ALTER TABLE USUARIO 
    ADD CONSTRAINT USUARIO_PK PRIMARY KEY ( id_usuario ) ;

ALTER TABLE BAIRRO 
    ADD CONSTRAINT BAIRRO_CIDADE_FK FOREIGN KEY 
    ( 
     CIDADE_id_cidade
    ) 
    REFERENCES CIDADE 
    ( 
     id_cidade
    ) 
;

ALTER TABLE ESTATISTICA_REGIAO 
    ADD CONSTRAINT ESTATISTICA_REGIAO_BAIRRO_FK FOREIGN KEY 
    ( 
     BAIRRO_id_bairro
    ) 
    REFERENCES BAIRRO 
    ( 
     id_bairro
    ) 
;

ALTER TABLE ILUMINACAO 
    ADD CONSTRAINT ILUMINACAO_LOCALIZACAO_FK FOREIGN KEY 
    ( 
     LOCALIZACAO_id_localizacao
    ) 
    REFERENCES LOCALIZACAO 
    ( 
     id_localizacao
    ) 
;

ALTER TABLE LOCALIZACAO 
    ADD CONSTRAINT LOCALIZACAO_BAIRRO_FK FOREIGN KEY 
    ( 
     BAIRRO_id_bairro
    ) 
    REFERENCES BAIRRO 
    ( 
     id_bairro
    ) 
;

ALTER TABLE LOCALIZACAO 
    ADD CONSTRAINT LOCALIZACAO_TOTEM_FK FOREIGN KEY 
    ( 
     TOTEM_id_totem
    ) 
    REFERENCES TOTEM 
    ( 
     id_totem
    ) 
;

ALTER TABLE MIDIA 
    ADD CONSTRAINT MIDIA_OCORRENCIA_FK FOREIGN KEY 
    ( 
     OCORRENCIA_id_ocorrencia
    ) 
    REFERENCES OCORRENCIA 
    ( 
     id_ocorrencia
    ) 
;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT OCORRENCIA_LOCALIZACAO_FK FOREIGN KEY 
    ( 
     LOCALIZACAO_id_localizacao
    ) 
    REFERENCES LOCALIZACAO 
    ( 
     id_localizacao
    ) 
;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT OCORRENCIA_USUARIO_FK FOREIGN KEY 
    ( 
     USUARIO_id_usuario
    ) 
    REFERENCES USUARIO 
    ( 
     id_usuario
    ) 
;

ALTER TABLE ROTA_ATENDIMENTO 
    ADD CONSTRAINT ROTA_ATENDIMENTO_OCORRENCIA_FK FOREIGN KEY 
    ( 
     OCORRENCIA_id_ocorrencia
    ) 
    REFERENCES OCORRENCIA 
    ( 
     id_ocorrencia
    ) 
;

ALTER TABLE ROTA_ATENDIMENTO 
    ADD CONSTRAINT ROTA_PP_FK FOREIGN KEY 
    ( 
     PONTO_POLICIAL_id_ponto
    ) 
    REFERENCES PONTO_POLICIAL 
    ( 
     id_ponto
    ) 
;

ALTER TABLE SMART_VISION_EVENTO 
    ADD CONSTRAINT SMART_VISION_EVENTO_MIDIA_FK FOREIGN KEY 
    ( 
     MIDIA_id_midia
    ) 
    REFERENCES MIDIA 
    ( 
     id_midia
    ) 
;



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
