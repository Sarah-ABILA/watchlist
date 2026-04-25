# Watchlist

> Application Ruby on Rails 8 pour gérer sa cinémathèque personnelle : ajouter des films, leur attribuer une jaquette, et marquer ceux que l'on a vus.

[![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-8.1-CC0000?logo=rubyonrails&logoColor=white)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Hotwire](https://img.shields.io/badge/Hotwire-Turbo_+_Stimulus-5BBAD5)](https://hotwired.dev/)
[![Kamal](https://img.shields.io/badge/Deploy-Kamal-2E7D32)](https://kamal-deploy.org/)

---

## À propos

Watchlist est un projet **solo** que j'ai conçu et livré juste avant ma certification RNCP niveau 6 (Le Wagon, mars 2026), pour consolider mes acquis Rails sur un produit complet de bout en bout : modélisation, authentification, upload de fichiers, conteneurisation et préparation au déploiement.

L'application permet à chaque utilisateur·trice de constituer sa propre bibliothèque de films, d'y associer une jaquette stockée en local ou sur un service compatible Active Storage, et de tracker ce qu'il ou elle a déjà visionné.

## Stack technique

| Couche | Choix |
|---|---|
| **Framework** | Ruby on Rails 8.1.2 |
| **Base de données** | PostgreSQL |
| **Authentification** | Devise (database_authenticatable, registerable, recoverable, rememberable, validatable) |
| **Front** | Hotwire (Turbo + Stimulus), Importmap |
| **Stockage de fichiers** | Active Storage (jaquettes des films) |
| **File d'attente / cache / WebSocket** | Solid Queue, Solid Cache, Solid Cable (natifs Rails 8) |
| **Conteneurisation** | Dockerfile multi-stage |
| **Déploiement** | Kamal (préconfiguré) |
| **Qualité** | RuboCop, fixtures de test |

## Modèle de données

```
User ─────< Movie         (un User crée plusieurs Movies)
User ─────< WatchlistItem >───── Movie   (table de jointure : films vus)
Movie ───── ActiveStorage::Attachment (jaquette)
```

- `User` (Devise) : email, mot de passe chiffré, helpers `has_many :movies`, `has_many :watched_movies, through: :watchlist_items`.
- `Movie` : `title` (unique), `genre`, `description` (longueur min. 10), `jacket` (image Active Storage), appartient à un User.
- `WatchlistItem` : table de jointure `user_id` × `movie_id` qui matérialise le statut « vu ».

## Routes

```ruby
devise_for :users
resources :movies
root to: "pages#home"
get "up" => "rails/health#show"
```

## Lancer le projet localement

Prérequis : **Ruby 3.2+**, **PostgreSQL 14+**, **Node** (pour Importmap).

```bash
git clone https://github.com/Sarah-ABILA/watchlist.git
cd watchlist

bundle install

# Préparer la base
rails db:create db:migrate

# Démarrer
bin/dev
```

L'application démarre sur `http://localhost:3000`. Créez un compte via `/users/sign_up`, puis ajoutez vos films sur `/movies/new`.

## Déploiement

Le projet est packagé pour **Kamal** :

```bash
kamal setup    # premier déploiement
kamal deploy   # déploiements suivants
```

Le `Dockerfile` est multi-stage et optimisé pour la production (Thruster en façade pour la compression et le cache HTTP).

## Ce que j'ai appris en construisant ce projet

- **Modélisation propre** d'un domaine simple mais complet : entités, jointure, validation métier.
- **Active Storage** de bout en bout : upload, variantes, contraintes de taille.
- **Hotwire idiomatique** : navigation Turbo Drive sans recharger la page, réactivité ciblée avec Stimulus.
- **Préparation production** : Docker, Kamal, gestion des credentials chiffrés Rails.
- **Hygiène de code** : RuboCop, tests, fixtures, conventions Rails 8 (Solid Queue plutôt que Sidekiq, Importmap plutôt que esbuild).

## Améliorations possibles (roadmap)

- Liste publique partageable (lien permanent sans authentification)
- Recherche full-text PostgreSQL sur titre / description
- Import depuis l'API TMDb (jaquette + métadonnées)
- Notation 1-5 étoiles + tri par note

---

_Sarah Abila — Hyères (83) — [LinkedIn](https://linkedin.com/in/sarah-abila-278041378) — [GitHub](https://github.com/Sarah-ABILA)_
