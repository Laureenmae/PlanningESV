<!-- README.md -->
# 📅 Planning ESV 2026

Planning interactif pour gérer les permanences d'accueil et d'orientation.

## 🚀 Démarrage Rapide

### Accès au Site
👉 **[https://laureenmae.github.io/PlanningESV/](https://laureenmae.github.io/PlanningESV/)**

Le site est **live et fonctionnel immédiatement**.

### Utilisation de Base
1. Cliquez sur un samedi ou dimanche
2. Sélectionnez une personne ou ajoutez-en une
3. Les données se sauvegardent automatiquement

## 💾 Stockage des Données

### Actuellement : localStorage (navigateur local)
✅ Fonctionnel  
⚠️ Données non partagées entre utilisateurs  
⚠️ Données perdues si cache vidé  

### Recommandé : Supabase (partagé en temps réel)
✅ Partagé entre tous les utilisateurs  
✅ Gratuit (500 MB inclus)  
✅ Synchronisation automatique  

## 🔧 Configuration Supabase (Optionnel)

### Étape 1 : Créer un compte
1. Allez sur [supabase.com](https://supabase.com)
2. Inscrivez-vous (email + mot de passe)
3. Créez un nouveau projet

### Étape 2 : Configurer la base de données
1. Allez dans **SQL Editor**
2. Créez une nouvelle query
3. Copiez le contenu de `schema.sql`
4. Exécutez la query

### Étape 3 : Obtenir les clés
1. Allez dans **Settings → API**
2. Copiez `Project URL` (SUPABASE_URL)
3. Copiez `anon public` key (SUPABASE_ANON_KEY)

### Étape 4 : Mettre à jour le code
Dans `index.html`, trouvez les lignes 650-660 et remplacez :

```javascript
const SUPABASE_URL = "https://YOUR_PROJECT_ID.supabase.co";
const SUPABASE_ANON_KEY = "YOUR_ANON_KEY_HERE";
```

### Étape 5 : Activer Supabase
Dans `index.html` ligne ~680, décommentez :

```javascript
// Remplacez les `readState` et `save` par les versions Supabase
```

## 📁 Structure des Fichiers

```
PlanningESV/
├── index.html              # Application principale (All-in-one)
├── schema.sql              # Schéma Supabase (SQL)
├── supabase-config.js      # Config Supabase (JS)
├── DEPLOYMENT.md           # Guide de déploiement
└── README.md               # Ce fichier
```

## 🎨 Fonctionnalités

### Affichage
- 📅 Tous les week-ends de 2026
- 👥 Liste des permanenciers avec compteur
- 🎨 Code couleur par personne

### Édition
- ➕ Ajouter une personne à un créneaux
- 🔄 Changer une assignation
- ❌ Retirer une personne
- 👤 Ajouter des noms à l'équipe

### Gestion
- ⚙️ Options (réinitialiser le planning)
- 🔔 Notifications (toasts)
- 📱 Responsive (mobile + desktop)

## 🔐 Sécurité & Confidentialité

**Avant Supabase :**
- Données locales au navigateur seulement
- Aucun serveur
- Aucune transmission réseau

**Avec Supabase :**
- Accès public (à configurer selon vos besoins)
- Chiffrement en transit (HTTPS)
- Audit logs disponibles

## 📊 Données

### Format de stockage
```json
{
  "plan": {
    "2026-05-02": ["MARIE JOSE"],
    "2026-05-03": ["MIGUELLE", "ISMAEL"]
  },
  "team": [
    {
      "name": "MARIE JOSE",
      "bg": "#FAD7C0",
      "fg": "#8A4B25",
      "av": "#E89968"
    }
  ]
}
```

### Export des données
Pour sauvegarder vos données :
1. F12 → Console
2. `JSON.stringify(state)` 
3. Copier/coller dans un fichier

## 🌐 Déploiement Alternatifs

### GitHub Pages (Actuel)
✅ Gratuit  
✅ Automatique  
✅ Pas de limite  

### Vercel / Netlify
Déployez le repo directement.

### Votre serveur
Copiez `index.html` où vous voulez.

## 🐛 Troubleshooting

### "Sauvegarde indisponible"
- ✅ Ça marche localement
- Configurez Supabase pour le partage

### Données manquantes
- Vérifiez localStorage (F12 → Storage → localStorage)
- Vérifiez la table Supabase

### Changements non synchronisés
- Vérifiez la connexion Supabase
- Vérifiez les clés API
- Vérifiez les permissions RLS

## 📞 Support

- 📖 [Documentation Supabase](https://supabase.com/docs)
- 🐛 [Issues GitHub](https://github.com/Laureenmae/PlanningESV/issues)
- 💬 Contactez l'équipe

## 📝 Licence

Libre d'utilisation. Modifiez comme bon vous semble.

---

**Version:** 1.0  
**Dernière mise à jour:** 2026-06-01  
**Déploiement:** ✅ Live sur GitHub Pages
