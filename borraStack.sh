#!/bin/bash

# Localiza el stack en cuestión
STACK_NAME="stack_actividad_4"

# Borrar el stack seleccionado
aws cloudformation delete-stack --stack-name "$STACK_NAME"
