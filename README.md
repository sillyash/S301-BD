# S301-BD

## Scripts de création

- #### [Looping](./MEA-SR.txt)
- #### [MySQL](./creation.sql)

## [Script de population](./population.sql)

## TODO

### [Vues](./vues.sql)

- [ ] Groupes d'un utilisateur
- [ ] Propositions populaires
- [ ] Propositions récentes
- [ ] Propositions d'un utilisateur
- [ ] Membres d'un groupe


### [Triggers](./triggers.sql)

- [ ] Réaction
  - [ ] Upvote : incrémenter popularité proposition concernée
  - [ ] Downvote : décrémenter popularité (peut être négative)
  - [ ] Suppression de la réaction : décrémenter / incrémenter popularité
- [ ] Proposition
  - [ ] Suppression de la proposition : supprimer tous les commentaires et réactions


## Annexes

![MCD](./MEA.jpg)

![SR](./SR.jpg)
