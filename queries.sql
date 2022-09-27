SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN TRANSACTION;
UPDATE animals
SET species = 'unspecified';
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
where species IS NULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT birthnarrowed;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO birthnarrowed;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT TRANSACTION;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT name FROM animals
WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;

SELECT name, full_name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';
SELECT animals.name, species.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.id = 1;
SELECT animals.name, owners.full_name FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT species.name, COUNT(*) FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.id = 2;
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.id = 5 AND escape_attemps = 0;
SELECT owners.full_name, COUNT(*) AS total FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY total DESC
LIMIT 1;

SELECT animals.name FROM animals
JOIN visits ON animal_id = animals.id
WHERE vet_id = 1 ORDER BY visits.visit_date DESC
LIMIT 1;
SELECT COUNT(*) FROM species
JOIN specializations ON specializations.species_id = species.id
WHERE vet_id = 3;
SELECT species.name, vets.name FROM species
JOIN specializations ON specializations.species_id = species.id
RIGHT JOIN vets ON specializations.vet_id = vets.id;
SELECT animals.name FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date
BETWEEN '2020-04-01' AND '2020-08-30';
SELECT animals.name, COUNT(*) as total FROM animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.name ORDER BY total DESC LIMIT 1;
SELECT animals.name, visits.visit_date FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC LIMIT 1;
SELECT animals.name, vets.name, visits.visit_date FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC LIMIT 1;
SELECT COUNT(*) FROM visits
WHERE vet_id = (
SELECT id FROM vets
FULL OUTER JOIN specializations ON vets.id = specializations.vet_id
WHERE species_id IS NULL);
SELECT species.name, COUNT(species.name) as total FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name ORDER BY total DESC LIMIT 1;

SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';