

# Introduction

**On souhaite recréer la base de données minimale d'un système d'authentification.**

**Lorsqu'il n'y a pas d'indication sur les types d'une colonne, choisir les types adéquats.**

**De même pour le choix des Primary Keys et Foreign Keys.**



# Partie I : création de la base de données

## question 1  `part_1_1.sql` 

### a.


On souhaite créer une base de données `app_auth` qui contient les tables nécessaires pour le bon fonctionnement du système d'authentification d'une application.
    
Vous choisirez les types adéquats pour les colonnes, et créerez des colonnes d'identifiant (primary key) et des foreign key lorsque nécessaire.


**Créer une base de données appelée `app_auth` (ne pas inclure cette clause dans le fichier SQL)**

**Créer les tables suivantes :**

- `user_table` : `user_id`, `firstname`, `lastname`, `email`, `username`, `password`, `created_at`

- `user_email_verification_table` : `uev_id`, `user_id`, `verified_at`

- `session_table` : `session_id`,  `user_id`, `connected_at`


### b. 

Ajouter des contraintes sur les colonnes : `username` (doit être unique, plus de 8 caractères), `email` (doit être unique) et `password` (plus de 8 caractères) 


**Vérifier que tout fonctionne : `psql -U <user> -d app_auth -f part_1_1.sql`**


## question 2  `part_1_2.sql` 

Vous pourrez utiliser Python et la librairie Faker pour générer les données (ou même directement les strings représentant les requêtes INSERT INTO), en revanche, vous devez fournir un fichier `part_1_2.sql` avec toutes les requêtes nécessaires (1185 INSERT INTO).

Vous pouvez aussi vous inspirer de ce [post](https://stackoverflow.com/questions/553303/generate-a-random-date-between-two-other-dates), et en particulier de la réponse de nosklo.

## a.

Insérer 100 utilisateurs avec des données crédibles, les comptes ont été créés entre le 01/01/2023 et le 30/06/2023.  Il doit y avoir des `created_at` sur les 6 mois.

## b.

Insérer 85 vérification d'emails (1 seule par utilisateur max). Les vérifications ne peuvent pas être antérieures à la création du compte. Les valeurs de `verified_at` sont comprises entre le 01/01/2023 et le 30/06/2023.

## c.

Insérer 1000 sessions pour des `connected_at` comprises entre le 01/01/2023 et le 30/06/2023. Il doit y avoir des valeurs sur les 6 mois. Les sessions ne peuvent pas être antérieures à la création du compte, ni à la vérification de l'email. 


**Vérifier que tout fonctionne : `psql -U <user> -d app_auth -f part_1_2.sql`**


## question 3 

## a. `part_1_3_a.sql` 

Créer une vue `session_and_user` qui permet d'afficher toutes les sessions, ainsi que les données des utilisateurs des sessions. Sur une même ligne, on veut voir tous les champs des deux tables.

**Vérifier que tout fonctionne : `psql -U <user> -d app_auth -f part_1_3_a.sql`**


## b. `part_1_3_b.sql`  & `part_1_3_b_view.sql`

(Nécessite probablement une recherche) :  
Ajouter une colonne `connected_at_month` de type INTEGER à la table `session_table`, avec le mois de la colonne `connected_at` .

**Vérifier que tout fonctionne : `psql -U <user> -d app_auth -f part_1_3_b.sql`**

Dans un fichier `part_1_3_b_view.sql` créer une vue `session_per_month` qui permet d'afficher le nombre de sessions par mois.

**Vérifier que tout fonctionne : `psql -U <user> -d app_auth -f part_1_3_b_view.sql`**


## c. `part_1_3_c.sql` 

Écrire une vue `very_active_users_may` qui permet d'afficher les `usernames` des users qui ont un nombre de sessions total en mai supérieur à 60 % du nombre moyen de session par utilisateur en mai. 

**Vérifier que tout fonctionne : `psql -U <user> -d app_auth -f part_1_3_c.sql`**


# Partie II : Comprendre les données : 


## question 1 : `part_2_1.sql` 

Créer une table `subscription_table` qui contient les colonnes : 
- `subscription_id`
- `subscribed_at`  (même intervalle de dates que précédemment)
- `user_id`
- `paid` (c'est un INTEGER qui vaut 10, 100 ou 1000 en fonction du plan qui suit)
- `subscription_plan` (qui peut valoir "monthly", "yearly" ou "lifetime").  

Insérer 60 subscriptions (avec plusieurs occurences pour chaque plan) pour des utilisateurs ayant vérifié leur email (on peut imaginer qu'ils ont souscrit depuis une app tierce, et donc il n'est pas nécessaire que les utilisateurs liés apparaissent dans la table de sessions).  Un utilisateur doit apparaître une seule fois maximum dans la table `subscription_table`. Le fichier doit contenir les 60 clauses INSERT INTO;


**Vérifier que tout fonctionne : `psql -U <user> -d app_auth -f part_2_1.sql`**

## question 2 : `part_2_2.sql` 

**Créer une vue `subscription_per_plan_per_month` qui affiche pour chaque plan et chaque mois :**
- le total payé par les utilisateurs ayant choisi ce plan
- le nombre total de subscriptions pour ce plan


**Vérifier que tout fonctionne : `psql -U <user> -d app_auth -f part_2_2.sql`**


# Partie III : Comparaison de requêtes `part_3.ipynb` 

## question 1 
Créer une table `user_for_comparison` qui contient les mêmes colonnes et admet les mêmes contraintes que la table `user_table` et y insérer 100 000 lignes (crédibles).


## question 2
Avec Python, pour plusieurs valeurs de `username` mesurer le temps d'exécution d'une requête SELECT avec un filtre WHERE sur cet `username` (sur la table `user_for_comparison`). 

**Veiller à ce que le temps soit apparent dans l'output de votre notebook qui sera ajouté sur Git (on doit voir le temps d'affiché sur Git : il faut commit et push après sauvegarde quand l'output est apparent sur le notebook, et ne pas effacer les outputs avant).**


## question 3 
Créer un indexe sur la colonne `username` de `user_for_comparison`. 
Répéter la procédure de la question 2.


# Partie IV : Monitoring 

## question 1 : `part_4_1.sql` 

Créer une table `session_count` qui contient les colonnes : `session_count_id`,  `user_id`, `session_count_value`  

Créer un trigger `trigger_update_session_count` afin d'avoir une ligne par utilisateur dans la table `session_count` (seulement si l'utilisateur a au moins une session). La valeur de `session_count_value` doit être égale au nombre total de sessions de l'utilisateur. (On écrira dans la table `session_count` uniquement via le trigger).


**Vérifier que tout fonctionne :  `psql -U <user> -d app_auth -f part_1_1.sql`**


## question 2 : `part_4_2.sql` 

(Nécessite probablement une recherche) :  

Créer une table `username_history` et un trigger `trigger_update_username` :
- le trigger doit permettre de conserver l'historique des valeurs de `usernames` (On écrira dans la table `username_history` uniquement via le trigger)
- la table `username_history` contient les colonnes : `username_history_id`, `user_id`,`username_new`
- insérer un `username` avec une clause INSERT ou le modifier  avec une clause UPDATE dans la table `users` doit déclencher le trigger qui écrira les valeurs adéquates dans la table `username_history`
- tester le trigger avec 5 clauses INSERT et 5 clauses UPDATE sur des utilisateurs différents
- utiliser une clause SELECT sur `username_history` pour vérifier


**Vérifier que tout fonctionne :  `psql -U <user> -d app_auth -f part_4_2.sql`**

## question 3 : `part_4_3.ipynb` 

Comparer les temps d'exécution nécessaires (qui seront visibles dans le notebook) pour ces deux cas : 
- Le code Python se charger de changer le `username`, mais un TRIGGER est utilisé pour garder l'historique (cas de la question précédente)

- Le code Python se charge aussi d'enregistrer l'historique, dans une table `username_history_from_app` (table à re-créer sur le même modèle que `username_history`)

**Vous comparerez sur 100, 1000 et 10000 éditions**



# Partie V : Considérations applicatives `part_5.ipynb` 


## question 1 
Créer une base de données `app_auth` avec MongoDb et créer des collections pour les trois tables créées en Partie I / question 1 / a.
Insérer les toutes données (dans la bonne collection à chaque fois).


## question 2
Érire une fonction `migrate_subscription` qui permette d'insérer les données de la table `subscription` dans une collection du même nom. 


## question 3

**Peu importe le langage mais inclure le résultat dans le notebook**
Avec la méthode de votre choix, créer une table ou une collection `time_between_session` avec une colonne (ou un champ) `user_id` et une colonne `time_between_avg` qui contient le temps moyen en seconde entre deux sessions consécutives d'un même utilisateur.


