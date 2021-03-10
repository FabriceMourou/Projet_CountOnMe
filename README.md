![Imgur](https://i.imgur.com/rV0UWjG.png)




# CountOnMe

Amélioration d'une application existante :

- Le design n’a pas été finalisé dans le projet Xcode : rien n’est responsive. 
- L’architecture du projet ne respecte pas encore les bonnes pratiques de développement.
- L’ensemble de l’application n’est pas testé.
- Seules la soustraction et l’addition ont été faites, il manque la division et la multiplication.

Voici les différentes améliorations sur lesquelles j'ai travaillé :

### Constitution de l'opération 
#### Operation Maker
- RAZ
- Constitution d’un nombre
- Ajout d'opérateur 
- Visualisation des erreurs

### Résolution de l'opération 
#### Operation Resolver
- Bouton égal
- Gestion multiplication 
- Gestion division
- Priorité de calcul 

![Imgur](https://i.imgur.com/f4rES5V.png)

#### Diagramme d'activité simplifié qui presente le fonctionnement de l'application 

![Imgur](https://i.imgur.com/Xm2nIWT.png)

#### Gestion des erreurs (UIAlert + Throws)

![Imgur](https://i.imgur.com/yovIi6y.png)

#### Test
##### Comment je nomme et je conçois mes tests ?

- Behavior Driven Development :
  - Test : Situation de départ
  - When : Action
  - Then : Situation d'arrivée

Exemple : `func testAddDigit_WhenAddSingleDigit_ThenAppendDigit`

- Test Driven Development :

![Imgur](https://i.imgur.com/gxIDTJn.png)

## Ce que j’ai appris :

- Amélioration des fonctionnalités d’une application
- Design pattern MVC
- Delegate pattern
- Gestion des erreurs ( UIAlert + Throws ) 
- Test :
  - BDD : Behavior Driven Development
  - TDD : Test Driven Development
  
  ![Imgur](https://i.imgur.com/UUucBQa.png)
