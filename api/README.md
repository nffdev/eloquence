# Eloquence API

API for the Eloquence application allowing to list words with their descriptions, types and examples.

## Installation

```bash
# Install dependencies
npm install

# Run in development
npm run dev

# Run in prod
npm start
```

## Endpoints

### Get all words
```
GET /api/words
```

### Get word of the day
```
GET /api/words/today
```

### Get a word by name
```
GET /api/words/:name
```

### Create a new word
```
POST /api/words
```
Request body:
```json
{
  "word": "Exemple",
  "type": "Nom",
  "definition": "Chose semblable ou comparable à ce dont il s'agit",
  "example": "Voici un exemple de phrase utilisant ce mot."
}
```

### Update a word
```
PUT /api/words/:name
```
Request body:
```json
{
  "type": "Nom",
  "definition": "Nouvelle définition",
  "example": "Nouvel exemple"
}
```

### Delete a word
```
DELETE /api/words/:name
```

## Project structure

```
api/
├── index.js          
├── controllers/       
│   └── wordController.js
├── models/           
│   └── Word.js
├── routes/            
│   └── wordRoutes.js
└── data/             
    └── wordRepository.js
```

## Word model

```javascript
{
  "word": "Éthéré",
  "type": "Adj",
  "definition": "D'une beauté irréelle, presque céleste",
  "example": "Son regard était d'une beauté éthérée, comme s'il appartenait à un rêve.",
  "isFavorite": false
}
```

## Multilingual support

- [ ] The API supports French (FR) and English (EN-US) languages.