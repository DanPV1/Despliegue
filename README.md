# Instalación de Tomcat en EC2

Este proyecto proporciona scripts y plantillas para facilitar la instalación de Apache Tomcat en instancias EC2 de AWS.

## Actividad 3. Interacción con AWS CloudFormation

Puedes usar el siguiente script para crear una instancia de EC2 que tiene un grupo de seguridad asociado. 

### Plantilla de creación de instancia EC2 (`main.yml`)

Esta plantilla de AWS CloudFormation crea una instancia EC2 con la configuración habitual usada en Despliegue así como un grupo de seguridad que permite el tráfico en los puertos 22 y 8080 desde cualquier dirección IP. Adicionalmente, la instancia está asociada con un perfil de IAM llamado LabInstanceProfile.

## Actividad 4. Interacción con AWS CloudFormation

Puedes utilizar los siguientes scripts para interactuar con CloudFormation y gestionar tus recursos de AWS de forma automatizada:

### Script de Despliegue (`crearStack.sh`)

Este script de shell se utiliza para desplegar una pila de AWS CloudFormation llamada "stack_actividad_4", utilizando la plantilla definida en el archivo "main.yml".

### Script de Eliminación (`borraStack.sh`)

Este script localiza la pila de CloudFormation con el nombre "stack_actividad_4" y la elimina utilizando la AWS CLI. 
