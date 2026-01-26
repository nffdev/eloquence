# 📖 Eloquence

Une application élégante pour élargir votre vocabulaire français / anglais, un mot à la fois.

---

## ✨ Fonctionnalités

- 🗓️ **Mot du jour** : Un nouveau mot chaque jour avec sa définition et un exemple contextualisé
- 🔊 **Prononciation TTS** : Écoutez la prononciation correcte du mot pour améliorer votre diction
- ⭐ **Favoris** : Enregistrez vos mots préférés pour créer votre dictionnaire personnel
- 🔥 **Système de streak** : Gardez la motivation avec un suivi des jours consécutifs d'apprentissage
- 🌓 **Thème clair/sombre** : Interface adaptative pour un confort visuel optimal
- 🌍 **Multilingue** : Support du français et anglais avec possibilité d'extension
- 📱 **Widget d'écran d'accueil** : Affichez le mot du jour directement sur votre écran d'accueil
- 🌐 **API RESTful** : Backend robuste pour la gestion des mots et définitions

---

## 🏗️ Architecture du projet

Eloquence est composé de deux parties principales :

### 📱 Application mobile (Flutter)

```
app/
├── lib/
│   ├── core/                # Fonctions et utilitaires communs
│   │   ├── constants/       # Constantes de l'application
│   │   ├── theme/           # Thèmes et styles
│   │   ├── localization/    # Support multilingue
│   │   ├── widgets/         # Widgets réutilisables
│   │   └── utils/           # Fonctions utilitaires
│   │
│   ├── features/            # Modules fonctionnels
│   │   ├── word_of_the_day/ # Fonctionnalité principale
│   │   │   ├── data/        # Sources de données (API, local)
│   │   │   ├── domain/      # Modèles et logique métier
│   │   │   ├── presentation/# UI et contrôleurs
│   │   │   └── application/ # Gestion d'état
│   │   ├── streak/          # Système de suivi quotidien
│   │   ├── favorites/       # Gestion des favoris
│   │   ├── tts/             # Synthèse vocale
│   │   ├── translation/     # Traductions
│   │   └── widget_module/   # Widget d'écran d'accueil
│   │
│   └── main.dart           # Point d'entrée de l'application
```

### 🖥️ API Backend (Node.js)

```
api/
├── index.js                # Point d'entrée de l'API
├── controllers/            # Contrôleurs des routes
│   └── wordController.js
├── models/                 # Modèles de données
│   └── Word.js
├── routes/                 # Définition des routes
│   └── wordRoutes.js
└── data/                   # Accès aux données
    └── wordRepository.js
```

---

## 🚀 Installation et démarrage

### Prérequis

- Flutter SDK 3.19.0 ou supérieur
- Node.js 18.x ou supérieur
- npm 8.x ou supérieur

### Configuration de l'application Flutter

```bash
# Cloner le dépôt
git clone https://github.com/nffdev/eloquence.git
cd eloquence/app

# Installer les dépendances
flutter pub get

# Lancer l'application en mode développement
flutter run

# Compiler pour la production
flutter build apk --release       # Android
flutter build ios --release       # iOS
```

### Configuration de l'API

```bash
# Naviguer vers le dossier de l'API
cd eloquence/api

# Installer les dépendances
npm install

# Lancer en mode développement
npm run dev

# Lancer en mode production
npm start
```

---

## 🌐 API Endpoints

| Méthode | Endpoint | Description |
|---------|----------|-------------|
| GET | `/api/words` | Récupérer tous les mots |
| GET | `/api/words/today` | Récupérer le mot du jour |
| GET | `/api/words/:name` | Récupérer un mot spécifique |
| POST | `/api/words` | Créer un nouveau mot |
| PUT | `/api/words/:name` | Mettre à jour un mot existant |
| DELETE | `/api/words/:name` | Supprimer un mot |

### Format de donnée

```json
{
  "word": "Éthéré",
  "type": "Adj",
  "definition": "D'une beauté irréelle, presque céleste",
  "example": "Son regard était d'une beauté éthérée, comme s'il appartenait à un rêve.",
  "date": "2023-04-06",
  "isFavorite": false
}
```

---

## 🛠️ Technologies utilisées

### Application mobile
- **Flutter** : Framework UI cross-platform
- **Provider** : Gestion d'état
- **HTTP** : Communication avec l'API
- **SharedPreferences** : Stockage local
- **Flutter TTS** : Synthèse vocale
- **Home Widget** : Widget d'écran d'accueil

### API Backend
- **Node.js** : Environnement d'exécution
- **Express** : Framework web
- **Mongoose** : ORM pour MongoDB

---

## 🔮 Roadmap

- [x] 🗓️ Système de mot quotidien
- [x] 🔥 Système de streak
- [x] 🔊 Prononciation vocale (TTS)
- [x] ⭐ Sauvegarde des mots favoris
- [x] 📱 Widget d'écran d'accueil
- [x] 🌗 Thème clair/sombre
- [x] 🚀 Splash screen personnalisé
- [x] 🌍 Système de traduction multilingue
- [x] 🌐 API externe pour les mots et définitions

---

## 📄 Licence

Ce projet est sous licence MIT.

---

## 👥 Contributeurs

- [@nffdev](https://github.com/nffdev) - Développeur & créateur de l'app

---
