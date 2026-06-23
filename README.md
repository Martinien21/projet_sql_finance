# Projet SQL — Banque & Finance (PostgreSQL)

Projet d'entraînement SQL basé sur une base de données fictive de type bancaire :
clients, comptes, cartes, catégories de transaction et transactions.

## Schéma de la base

- **clients** (id_client, nom, prenom, date_naissance, ville, date_inscription)
- **comptes** (id_compte, id_client → clients, type_compte, solde, date_ouverture)
- **categories_transaction** (id_categorie, nom_categorie)
- **cartes** (id_carte, id_compte → comptes, type_carte, plafond, date_expiration)
- **transactions** (id_transaction, id_compte → comptes, id_categorie → categories_transaction, type_transaction, montant, date_transaction, description)

## Installation

```bash
createdb projet_finance
psql -d projet_finance -f projet_finance.sql
```

## Questions business et réponses

### Q1. Solde total de la banque
```sql
SELECT sum(solde) AS solde_total
FROM comptes
WHERE type_compte IN ('Courant', 'Professionnel');
```
**Résultats :**
[
  {
    "solde_total": "23125000.00"
  }
]

### Q2. Top 5 des comptes par solde
```sql
select solde from comptes 
order by solde desc
limit 5;
```
**Résultat :**
[
  {
    "nom": "Kpogan",
    "prenom": "Yves",
    "solde": "4500000.00"
  },
  {
    "nom": "Dansou",
    "prenom": "Cyrille",
    "solde": "3100000.00"
  },
  {
    "nom": "Gbenou",
    "prenom": "Marius",
    "solde": "2300000.00"
  },
  {
    "nom": "Lawani",
    "prenom": "Hervé",
    "solde": "2200000.00"
  },
  {
    "nom": "Codjo",
    "prenom": "Anita",
    "solde": "1750000.00"
  }
]
 

### Q3. Solde moyen par type de compte
```sql
select type_compte, avg(solde) as solde_moyen
from comptes
group by type_compte;
```
 **Résultat :**
 [
  {
    "type_compte": "Courant",
    "solde_moyen": "352333.333333333333"
  },
  {
    "type_compte": "Professionnel",
    "solde_moyen": "3266666.666666666667"
  },
  {
    "type_compte": "Épargne",
    "solde_moyen": "1148571.428571428571"
  }
]

### Q4. Clients de Cotonou, triés par inscription récente
```sql
select nom, prenom 
from clients 
where ville = 'Cotonou'
order by date_inscription desc;
```
**Résultats :**
[
  {
    "nom": "Hounsou",
    "prenom": "Linda",
    "date_inscription": "2022-01-10"
  },
  {
    "nom": "Gbenou",
    "prenom": "Marius",
    "date_inscription": "2021-03-05"
  },
  {
    "nom": "Dansou",
    "prenom": "Cyrille",
    "date_inscription": "2020-10-01"
  },
  {
    "nom": "Dossou",
    "prenom": "Akim",
    "date_inscription": "2019-01-15"
  },
  {
    "nom": "Lawani",
    "prenom": "Hervé",
    "date_inscription": "2017-10-10"
  },
  {
    "nom": "Kpogan",
    "prenom": "Yves",
    "date_inscription": "2016-11-30"
  },
  {
    "nom": "Houessou",
    "prenom": "Eric",
    "date_inscription": "2016-06-13"
  }
]
 

### Q5. Transaction la plus élevée
```sql
select cl.nom,cl.prenom, t.type_transaction, t.montant,cat.nom_categorie,t.description, t.date_transaction
from transactions t
join comptes c on t.id_compte = c.id_compte
join clients cl on c.id_client = cl.id_client
join categories_transaction cat on cat.id_categorie = t.id_categorie
order by t.montant desc
limit 1;
```
**Résultat :**
[
  {
    "nom": "Aplogan",
    "prenom": "Nadège",
    "type_transaction": "Crédit",
    "montant": "1100000.00",
    "nom_categorie": "Salaire",
    "description": "Revenus professionnels",
    "date_transaction": "2024-01-31"
  }
]

### Q6. Total des crédits en janvier 2024
```sql
select  sum(montant) as Somme_Credit_en_janvier2021 from transactions
where type_transaction = 'Crédit' and date_transaction between '2024-01-01' and '2024-01-31';

```
 **Résultat :**
 [
  {
    "somme_credit_en_janvier2021": "4330000.00"
  }
]

### Q7. Catégories dont le total dépasse 100 000
```sql
select  c.nom_categorie, sum(t.montant) as total_cumulatif
from transactions t
join categories_transaction c on t.id_categorie = c.id_categorie
group by c.nom_categorie
having sum(t.montant) > 100000;

```
**Résultat:**
[
  {
    "nom_categorie": "Logement",
    "total_cumulatif": "250000.00"
  },
  {
    "nom_categorie": "Virement",
    "total_cumulatif": "350000.00"
  },
  {
    "nom_categorie": "Salaire",
    "total_cumulatif": "4330000.00"
  }
]
 

### Q8. Nombre de comptes par type
```sql
select count(type_compte) as nombre_de_compte, type_compte
from comptes
group by type_compte
order by nombre_de_compte desc;

```
 **Résultat:**
 [
  {
    "nombre_de_compte": "15",
    "type_compte": "Courant"
  },
  {
    "nombre_de_compte": "7",
    "type_compte": "Épargne"
  },
  {
    "nombre_de_compte": "3",
    "type_compte": "Professionnel"
  }
]

### Q9. Top 5 cartes par plafond (> 1 000 000)
```sql
select id_carte, type_carte, plafond, date_expiration
from cartes
where plafond > 1000000
order by plafond desc
limit 5;
```
**Résultat :**
[
  {
    "id_carte": 8,
    "type_carte": "Mastercard",
    "plafond": "3500000.00",
    "date_expiration": "2028-12-31"
  },
  {
    "id_carte": 15,
    "type_carte": "Mastercard",
    "plafond": "2500000.00",
    "date_expiration": "2027-10-05"
  },
  {
    "id_carte": 6,
    "type_carte": "Mastercard",
    "plafond": "2000000.00",
    "date_expiration": "2027-03-31"
  },
  {
    "id_carte": 20,
    "type_carte": "Mastercard",
    "plafond": "1700000.00",
    "date_expiration": "2028-10-15"
  },
  {
    "id_carte": 17,
    "type_carte": "Mastercard",
    "plafond": "1300000.00",
    "date_expiration": "2026-09-12"
  }
]
 

### Q10. Montant moyen des débits par catégorie (> 15 000)
```sql
select c.nom_categorie, avg(t.montant) as montant_moyen
from transactions t     
join categories_transaction c on t.id_categorie = c.id_categorie
where t.type_transaction = 'Débit'
group by c.nom_categorie
having avg(t.montant) > 15000;
```
**Résultat :**
[
  {
    "nom_categorie": "Éducation",
    "montant_moyen": "26000.000000000000"
  },
  {
    "nom_categorie": "Logement",
    "montant_moyen": "83333.333333333333"
  },
  {
    "nom_categorie": "Loisirs",
    "montant_moyen": "24000.000000000000"
  },
  {
    "nom_categorie": "Santé",
    "montant_moyen": "18666.666666666667"
  }
]
## Stack
PostgreSQL, SQL (SELECT, WHERE, ORDER BY, GROUP BY, HAVING, agrégations, LIMIT)
