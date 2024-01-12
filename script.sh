#!/bin/bash

# Naviguer vers le répertoire de votre projet
cd /home/minecraft/ekaiiserver

# Ajouter tous les fichiers modifiés
git add .

# Créer un commit
git commit -m "Mise à jour automatique"

# Pousser les changements
git push origin main
