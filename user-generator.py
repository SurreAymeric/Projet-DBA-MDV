# from faker import Faker
# import random
# from datetime import datetime, timedelta

# # Initialiser Faker
# fake = Faker()

# # Fonction pour générer une date aléatoire entre deux dates
# def random_date(start, end):
#     return start + timedelta(
#         seconds=random.randint(0, int((end - start).total_seconds())),
#     )

# # Dates de début et de fin
# start_date = datetime(2023, 1, 1)
# end_date = datetime(2023, 6, 30)

# # Générer 100 utilisateurs
# users = []
# verified_emails = []

# for user_id in range(1, 101):
#     firstname = fake.first_name()
#     lastname = fake.last_name()
#     username = f"{firstname.lower()}{lastname.lower()}{random.randint(100, 999)}"
#     email = f"{firstname.lower()}.{lastname.lower()}@example.com"
#     password = fake.password(length=12)
#     created_at = random_date(start_date, end_date).strftime("%Y-%m-%d")
#     users.append(f"('{firstname}', '{lastname}', '{email}', '{username}', '{password}', '{created_at}')")

#     # Générer des dates de vérification d'email pour 85 utilisateurs
#     if len(verified_emails) < 85:
#         verified_at = random_date(datetime.strptime(created_at, "%Y-%m-%d"), end_date).strftime("%Y-%m-%d")
#         verified_emails.append(f"({user_id}, '{verified_at}')")

# # Génération des sessions
# sessions = []
# for session_id in range(1, 1001):
#     user_id = random.randint(1, 100)

#     # Trouver les dates correspondantes pour l'utilisateur choisi
#     created_at_str = users[user_id - 1].split(', ')[-1].strip("')\n")
#     created_at = datetime.strptime(created_at_str, "%Y-%m-%d")

#     # Déterminer la date de début la plus tardive
#     latest_start_date = created_at
#     if user_id <= 85:
#         verified_at_str = verified_emails[user_id - 1].split(', ')[-1].strip("')\n")
#         verified_at = datetime.strptime(verified_at_str, "%Y-%m-%d")
#         latest_start_date = max(latest_start_date, verified_at)

#     # Générer une date aléatoire pour la session
#     connected_at = random_date(latest_start_date, end_date).strftime("%Y-%m-%d")
#     sessions.append(f"({user_id}, '{connected_at}')")

# # Sauvegarder les données dans des fichiers texte
# with open('users.txt', 'w') as file:
#     for user in users:
#         file.write(f"{user}\n")

# with open('verified_emails.txt', 'w') as file:
#     for email in verified_emails:
#         file.write(f"{email}\n")

# with open('sessions.txt', 'w') as file:
#     for session in sessions:
#         file.write(f"{session}\n")

from faker import Faker
import random
from datetime import datetime, timedelta

# Initialiser Faker
fake = Faker()

# Fonction pour générer une date aléatoire entre deux dates
def random_date(start, end):
    return start + timedelta(
        seconds=random.randint(0, int((end - start).total_seconds())),
    )

# Dates de début et de fin
start_date = datetime(2023, 1, 1)
end_date = datetime(2023, 6, 30)

# Générer 100 utilisateurs et les dates de vérification pour 85 d'entre eux
users = []
verified_emails = []

for user_id in range(1, 101):
    firstname = fake.first_name()
    lastname = fake.last_name()
    username = f"{firstname.lower()}{lastname.lower()}{random.randint(100, 999)}"
    email = f"{firstname.lower()}.{lastname.lower()}@example.com"
    password = fake.password(length=12)
    created_at = random_date(start_date, end_date).strftime("%Y-%m-%d")
    users.append(f"('{firstname}', '{lastname}', '{email}', '{username}', '{password}', '{created_at}')")

    # Générer des dates de vérification d'email pour 85 utilisateurs
    if len(verified_emails) < 85:
        verified_at = random_date(datetime.strptime(created_at, "%Y-%m-%d"), end_date).strftime("%Y-%m-%d")
        verified_emails.append(f"({user_id}, '{verified_at}')")

# Génération des sessions uniquement pour les utilisateurs vérifiés
sessions = []
for _ in range(1000):
    # Sélectionner aléatoirement un utilisateur parmi les 85 vérifiés
    user_id, verified_at_str = random.choice(verified_emails).split(', ')
    user_id = int(user_id.strip("("))
    verified_at = datetime.strptime(verified_at_str.strip("')\n"), "%Y-%m-%d")

    # Générer une date de session qui respecte les contraintes de date
    connected_at = random_date(verified_at, end_date).strftime("%Y-%m-%d")
    sessions.append(f"({user_id}, '{connected_at}')")

# Sauvegarder les données dans des fichiers texte
with open('users.txt', 'w') as file:
    for user in users:
        file.write(f"{user}\n")

with open('verified_emails.txt', 'w') as file:
    for email in verified_emails:
        file.write(f"{email}\n")

with open('sessions.txt', 'w') as file:
    for session in sessions:
        file.write(f"{session}\n")


# SELECT u.user_id, u.created_at, v.verified_at
# FROM user_table u
# JOIN user_email_verification_table v ON u.user_id = v.user_id
# WHERE v.verified_at < u.created_at;

# SELECT u.user_id, u.created_at, s.connected_at
# FROM user_table u
# JOIN session_table s ON u.user_id = s.user_id
# WHERE s.connected_at < u.created_at;

# SELECT u.user_id, v.verified_at, s.connected_at
# FROM user_table u
# JOIN user_email_verification_table v ON u.user_id = v.user_id
# JOIN session_table s ON u.user_id = s.user_id
# WHERE s.connected_at < v.verified_at;
