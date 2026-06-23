/*  Quel est le solde total détenu par la banque, tous comptes confondus ? */

SELECT sum(solde) AS solde_total
FROM comptes;

/*Q2. Quels sont les 5 comptes ayant le solde le plus élevé ?*/
select solde from comptes 
order by solde desc
limit 5;

/*Q3. Quel est le solde moyen par type de compte (Courant, Épargne, Professionnel) ?*/
select type_compte, avg(solde) as solde_moyen
from comptes
group by type_compte;

/*-- Q4. Quels clients habitent à Cotonou, triés par date d'inscription la plus récente ?*/
select nom, prenom 
from clients 
where ville = 'Cotonou'
order by date_inscription desc;
/*Quelle est la transaction (  montant) la plus élevée enregistrée, et de quel type est-elle (Débit/Crédit) ?*/
select cl.nom,cl.prenom, t.type_transaction, t.montant,cat.nom_categorie,t.description, t.date_transaction
from transactions t
join comptes c on t.id_compte = c.id_compte
join clients cl on c.id_client = cl.id_client
join categories_transaction cat on cat.id_categorie = t.id_categorie
order by t.montant desc
limit 1;

/*Q6. Quel est le montant total des crédits (entrées d'argent) enregistrés en janvier 2024 ?*/
select  sum(montant) as Somme_Credit_en_janvier2021 from transactions
where type_transaction = 'Crédit' and date_transaction between '2024-01-01' and '2024-01-31';

/*Q7. Quelles catégories de transaction ont un montant total cumulé supérieur à 100 000 (HAVING) ?*/
select  c.nom_categorie, sum(t.montant) as total_cumulatif
from transactions t
join categories_transaction c on t.id_categorie = c.id_categorie
group by c.nom_categorie
having sum(t.montant) > 100000;

/*-- Q8. Quel est le nombre de comptes par type de compte, et lequel est le plus répandu ?*/
select count(type_compte) as nombre_de_compte, type_compte
from comptes
group by type_compte
order by nombre_de_compte desc;

/*Q9. Quelles cartes ont un plafond supérieur à 1 000 000, triées du plafond le plus élevé au plus faible, limité aux 5 premières ?*/
select id_carte, type_carte, plafond, date_expiration
from cartes
where plafond > 1000000
order by plafond desc
limit 5;

/*Q10. Quel est le montant moyen des transactions de type "Débit" par catégorie, en ne gardant que les catégories où la moyenne dépasse 15 000 (HAVING) ?
*/
select c.nom_categorie, avg(t.montant) as montant_moyen
from transactions t     
join categories_transaction c on t.id_categorie = c.id_categorie
where t.type_transaction = 'Débit'
group by c.nom_categorie
having avg(t.montant) > 15000;