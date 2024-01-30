#!/bin/bash

# Nombramos el stack
STACK_NAME=stack_actividad_4

# Ruta del archivo de la plantilla
TEMPLATE_FILE=main.yml

# Desplegamos el stack
aws cloudformation deploy --stack-name $STACK_NAME --template-file $TEMPLATE_FILE --capabilities CAPABILITY_IAM
