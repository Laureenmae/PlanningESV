# 🚀 Guide de Déploiement - Planning ESV 2026

## ✅ Étape 1 : Activation de GitHub Pages (FAIT)

Le fichier `index.html` est maintenant déployé. Votre site est accessible à :

👉 **https://laureenmae.github.io/PlanningESV/**

> GitHub Pages se met à jour automatiquement à chaque changement sur `main`

---

## 🔄 Étape 2 : Configuration du Stockage Partagé

Actuellement, le planning utilise **localStorage** (données locales au navigateur). Pour que **tous les utilisateurs partagent le même planning**, vous avez 3 options :

### Option A : Supabase (Recommandé - Gratuit)
Le plus simple avec une vraie base de données.

**1. Créer un compte**
- Allez sur [supabase.com](https://supabase.com)
- Inscrivez-vous (gratuit)
- Créez un nouveau projet

**2. Créer une table**
```sql
CREATE TABLE planning_2026 (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  key TEXT UNIQUE,
  data JSONB,
  updated_at TIMESTAMP DEFAULT NOW()
);
```

**3. Activer l'accès public**
- Allez dans SQL Editor → Policies
- Créez une policy `SELECT` pour tous
- Créez une policy `INSERT/UPDATE` pour tous

**4. Copier les clés**
- Settings → API → `SUPABASE_URL` et `anon key`
- Remplacez dans `index.html` lignes 650-660 :

```javascript
const SUPABASE_URL = "https://YOUR_PROJECT.supabase.co";
const SUPABASE_ANON_KEY = "YOUR_ANON_KEY";
```

**5. Décommenter le code Supabase**
Supprimez les `/*` et `*/` autour des lignes 650-660 et 680-750.

---

### Option B : Firebase (Alternative gratuite)
Google Firebase Realtime Database.

1. Allez sur [console.firebase.google.com](https://console.firebase.google.com)
2. Créez un nouveau projet
3. Activez Realtime Database
4. Configurez les règles de sécurité :
```json
{
  "rules": {
    "planning2026": {
      ".read": true,
      ".write": true
    }
  }
}
```

---

### Option C : Backend personnalisé
Si vous avez un serveur (Node.js, Python, etc.), créez une API :

```javascript
// Remplacez readState() et save() dans index.html par :

async function readState() {
  const res = await fetch("https://votre-api.com/planning");
  const data = await res.json();
  state.plan = data.plan;
  state.team = data.team;
}

async function save() {
  const res = await fetch("https://votre-api.com/planning", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(state)
  });
  return res.ok;
}
```

---

## 📋 Status Actuel

| Aspect | État | Notes |
|--------|------|-------|
| **Déploiement Web** | ✅ Live | GitHub Pages activé |
| **URL** | ✅ https://laureenmae.github.io/PlanningESV/ | Accessible |
| **Stockage** | ⚠️ localStorage | Données locales au navigateur |
| **Partage temps réel** | ❌ Non | À configurer avec Supabase/Firebase |

---

## 🎯 Prochaines Étapes

1. **Testez** : Allez sur le lien et vérifiez que tout fonctionne
2. **Choisissez** un stockage partagé (Supabase recommandé)
3. **Configurez** les clés API
4. **Mettez à jour** `index.html`
5. **Partagez** le lien avec votre équipe

---

## 🔧 Support Technique

**Problème ?**
- Vérifiez la console (F12 > Console)
- Les données se sauvegardent localement même sans cloud
- Vous pouvez utiliser le site sans configuration Supabase

**Questions ?** Consultez [la doc Supabase](https://supabase.com/docs) ou contactez le support GitHub.
