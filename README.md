# Moustibox

A new Flutter project.

## Getting Started

FlutterFlow projects are built to run on the Flutter _stable_ release.

### Description

#### Add Device Page
- **Initialisation**: À la création de la page, un modèle de données `AddDevicePageModel` est initialisé pour gérer l'état local de la page. Des contrôleurs pour les champs de texte et des focus nodes sont également initialisés pour gérer les entrées utilisateur.
- **Scan de QR code**: L'utilisateur peut déclencher un scan de QR code qui, une fois complété, vérifie si le dispositif est déjà enregistré dans l'application. Si c'est le cas, un message d'erreur est affiché. Sinon, le dispositif est ajouté à la liste des dispositifs de l'application.
- **Dialogues de traitement**: Pendant le processus de scan du QR code, des dialogues de chargement sont affichés pour indiquer à l'utilisateur que l'application est en train de traiter les données du QR code.
- **Gestion des erreurs**: En cas d'échec du scan du QR code (par exemple, si le QR code est invalide ou si les données ne peuvent pas être traitées), un message d'erreur est affiché à l'utilisateur.
- **Affichage et interaction**: La page affiche un champ de texte permettant à l'utilisateur de nommer le dispositif ajouté et un bouton pour confirmer l'ajout du dispositif. Un icône de QR code indique visuellement si un dispositif a été scanné avec succès.
- **Ajout du dispositif**: Lorsque l'utilisateur confirme l'ajout du dispositif, le dispositif est connecté via Bluetooth, ses services sont découverts, et les informations du dispositif sont rafraîchies avant d'être ajoutées à la liste des dispositifs dans l'état global de l'application.
- **Navigation**: Des boutons sont présents pour revenir à la page précédente ou pour finaliser l'ajout du dispositif.

#### Device Page

Cette classe gère l'affichage et l'interaction avec la liste des appareils dans l'application. Elle permet aux utilisateurs de voir les appareils qu'ils ont ajoutés, d'interagir avec eux via un scan de QR code, et de naviguer vers des pages de détails spécifiques pour chaque appareil. Elle intègre également une barre de navigation personnalisée pour faciliter la navigation au sein de l'application.

#### Notification Page

La classe `NotificationPageWidget` s'occupe de présenter une liste de notifications à l'utilisateur. Elle affiche des informations sur les différents événements ou alertes liés aux appareils de l'utilisateur, comme des niveaux bas de consommables ou des états nécessitant une attention. Cette page permet une interaction simple, offrant à l'utilisateur la possibilité de parcourir et de gérer ses notifications.

#### Notification Service

La classe `NotificationService` est conçue pour gérer les notifications locales au sein d'une application Flutter, en utilisant le package `flutter_local_notifications`. Elle offre une abstraction permettant de simplifier l'envoi de notifications et de réagir aux interactions de l'utilisateur avec ces notifications.

- **Initialisation**: La méthode `init` configure les paramètres d'initialisation pour Android et iOS (Darwin), crée un canal de notification pour Android (important pour Android 8.0+), et prépare le service à recevoir des réponses aux notifications.

- **Configuration Android**: Définit les paramètres d'initialisation spécifiques à Android, y compris l'icône de l'application et la création d'un canal de notification.

- **Configuration iOS (Darwin)**: La configuration pour iOS inclut les permissions (son, badge, alertes) et une callback `onDidReceiveLocalNotification` pour gérer la réception de notifications en premier plan.

- **Envoi de notifications**: La méthode `sendLocalNotification` utilise la structure `NotificationStruct` pour construire et afficher une notification locale.

- **Réaction aux interactions**: `onDidReceiveNotificationResponse` est appelée lorsque l'utilisateur interagit avec une notification.

- **Gestion du Singleton**: La classe utilise le pattern Singleton pour s'assurer qu'une unique instance du service est créée et utilisée à travers l'application.

#### Device Utilities

La classe `DeviceUtilities` encapsule diverses fonctions axées sur les interactions avec des dispositifs via Bluetooth et le traitement des QR codes.

- **Gestion Bluetooth et QR Code**: Inclut la méthode pour scanner un QR code et pour récupérer un appareil depuis le QR code.

- **Commandes Bluetooth**: Permet d'envoyer des commandes à un appareil spécifié et d'ajouter un nouvel horaire de fonctionnement.

- **Gestion des Informations de l'Appareil**: Inclut la mise à jour des informations de l'appareil et la restauration de la connexion.

- **Gestion des Notifications**: Génère des notifications basées sur l'état de l'appareil.

#### Add Schedule Page

Permet aux utilisateurs d'ajouter une nouvelle plage horaire pour un appareil spécifique, avec une interface utilisateur comprenant la sélection de date/heure, la récurrence, et un bouton de confirmation pour enregistrer la nouvelle plage horaire.
