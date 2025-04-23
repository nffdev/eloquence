# 📖 Eloquence

Une application élégante pour élargir votre vocabulaire français, un mot à la fois.

---

## ✨ Fonctionnalités

- 🗓️ **Mot du jour** : Un mot nouveau chaque jour avec sa définition et un exemple.
- 🔊 **Prononciation TTS** : Écoutez la prononciation correcte du mot.
- ⭐ **Favoris** : Enregistrez vos mots préférés pour les retrouver facilement.
- 🔥 **Système de streak** : Gardez la motivation avec un système de jours consécutifs.
- 🌓 **Thème clair/sombre** : Interface en noir et blanc, switch de thème disponible.
- 🌍 **Traduction** : Traduisez le mot dans d’autres langues.
- 📱 **Widget** : Affichez le mot du jour directement sur votre écran d’accueil.
- 🚀 **Splash screen** : Démarrage fluide et stylé.

---

## 🧱 Architecture

```
lib/
├── core/                # Fonctions/utilitaires communs
│   ├── constants/
│   ├── theme/
│   ├── localization/
│   ├── widgets/         # Widgets réutilisables
│   └── utils/
│
├── features/
│   ├── word_of_the_day/
│   │   ├── data/        # Appels API, fichiers locaux
│   │   ├── domain/      # Entités, usecases
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   └── application/ # Gestion d’état (Controller/ViewModel)
│   │
│   ├── streak/
│   ├── favorites/
│   ├── tts/
│   ├── translation/
│   └── widget_module/   # Pour le widget home screen
│
└── main.dart
```

---

## 🚧 À venir

- [x] 🗓️ Faire un système pour afficher **un mot par jour**.
- [x] 🔥 Ajouter un **système de streak** pour suivre la régularité de l’utilisateur.
- [x] 🔊 Intégrer la **prononciation vocale (TTS)** du mot du jour.
- [x] ⭐ Permettre à l’utilisateur de **sauvegarder ses mots favoris**.
- [ ] 📱 Créer un **widget** affichant le mot du jour sur l’écran d’accueil.
- [x] 🌗 Implémenter un **switcher de thème clair/sombre**.
- [x] 🚀 Ajouter un **splash screen personnalisé**.
- [x] 🌍 Intégrer un **système de traduction** multilingue.
- [ ] 🌐 Utiliser une **API externe** pour récupérer les mots, définitions et exemples.

---

## 🛠️ Lancer le projet

```bash
git clone https://github.com/nffdev/eloquence.git
cd eloquence
flutter pub get
flutter run
```

---

## 📄 Licence

Ce projet est sous licence MIT.