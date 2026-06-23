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
  On a le solde total, soit 23125000

### Q2. Top 5 des comptes par solde
```sql
select solde from comptes 
order by solde desc
limit 5;
```
 

### Q3. Solde moyen par type de compte
```sql
select type_compte, avg(solde) as solde_moyen
from comptes
group by type_compte;
```
 

### Q4. Clients de Cotonou, triés par inscription récente
```sql
select nom, prenom 
from clients 
where ville = 'Cotonou'
order by date_inscription desc;
```
 

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
 

### Q6. Total des crédits en janvier 2024
```sql
select  sum(montant) as Somme_Credit_en_janvier2021 from transactions
where type_transaction = 'Crédit' and date_transaction between '2024-01-01' and '2024-01-31';

```
 

### Q7. Catégories dont le total dépasse 100 000
```sql
select  c.nom_categorie, sum(t.montant) as total_cumulatif
from transactions t
join categories_transaction c on t.id_categorie = c.id_categorie
group by c.nom_categorie
having sum(t.montant) > 100000;

```
 

### Q8. Nombre de comptes par type
```sql
select count(type_compte) as nombre_de_compte, type_compte
from comptes
group by type_compte
order by nombre_de_compte desc;

```
 

### Q9. Top 5 cartes par plafond (> 1 000 000)
```sql
select id_carte, type_carte, plafond, date_expiration
from cartes
where plafond > 1000000
order by plafond desc
limit 5;
```
 

### Q10. Montant moyen des débits par catégorie (> 15 000)
```sql
select c.nom_categorie, avg(t.montant) as montant_moyen
from transactions t     
join categories_transaction c on t.id_categorie = c.id_categorie
where t.type_transaction = 'Débit'
group by c.nom_categorie
having avg(t.montant) > 15000;
```

## Stack
PostgreSQL, SQL (SELECT, WHERE, ORDER BY, GROUP BY, HAVING, agrégations, LIMIT)
