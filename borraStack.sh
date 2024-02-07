#!/bin/bash

# Localiza el stack en cuestión
STACK_NAME="stack-actividad-4"

# Borrar el stack seleccionado
aws cloudformation delete-stack --stack-name "$STACK_NAME"
